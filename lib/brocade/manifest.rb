#!/usr/bin/ruby

require 'json'
require 'uri'
require 'fileutils'

module BrocadeREST

	class Manifest

		def initialize(type, uri, restVersion, object, root=nil, traverseArrays=false)
			@type = type
			@type_ = type.gsub(/[\/\.-]|%20/, "_").downcase
			@uri = uri.path
			@restVersion = restVersion
			@root = root
			@json = nil
			@data = nil
			@isBinary = false
			@object = object
			@params = {}
			@required = {}
			@maxKeyLength = 0
			@template = nil;
			@traverseArrays = traverseArrays
		end

		# Add the given parameter to the list of mandatory params for this manifest
		def addRequiredParam(name, example)
			@required[name] = { class: example.class, example: example }
		end

		# Get the isBinary flag
		def isBinary
			return @isBinary
		end

		# Get the type, as it would appear on disk
		def getType
			return @type_
		end

		# Get the current JSON blob
		def getJSON
			return @json
		end

		# Get the current binary data
		def getData
			return @data
		end

		# Set this manifest as a binary object
		def setBinary(isBinary)
			@isBinary = isBinary
			if isBinary
				@json = nil
			end
		end

		# Set this manifest as a JSON object
		def setJSON(json)
			@isBinary = false
			@json = json
			@data = nil
		end

		# Set the binary data of this manifest
		def setData(data)
			@isBinary = true
			@json = nil
			@data = data
		end

		# decode the JSON structure into the params hash
		def decodeJSON()
			if @isBinary
				return
			end
			if @json == nil
				puts("** ERROR ** JSON is null for #{@type}")
				return
			end
			parsed = JSON.parse(@json)
			if @root.nil?
				genParams(nil,parsed)
			else
				genParams(nil,parsed[@root])
			end
		end

		# recursive function used by decodeJSON to generate parameter names
		# and calculating spacing for the manifest.
		def genParams(name, data)
			if data.is_a?(Hash)
				data.each do |key, value|
					name.nil? ? new=key : new = "#{name}__#{key}"
					genParams(new, value)
				end
			elsif @traverseArrays and data.is_a?(Array) and (!data.empty?) and (!name.include?("__aRrAy"))
				data.each do |item|
					name.nil? ? new="aRrAy" : new="#{name}__aRrAy"
					genParams(new,item)
				end
			else
				@maxKeyLength = name.length if name.length > @maxKeyLength
				if data == nil or data == ""
					data = ""
				end
				if ! @required.has_key?(name)
					if name.include?("__aRrAy")
						if @params.has_key?(name)
							@params[name].push data
						else
							@params[name] = [ data ]
						end
					else
						@params[name] = data 
					end
				end
			end
		end	

		# function to generate the template string for a parameter. This is called by genTemplate()
		def genTemplateString(name,data,templvar,prefix)

			if data.is_a?(Hash)
				propStr = "{" 
				data.each do |key, value|
					propStr += '"'+key+'":'
					templvar.nil? ? nextVar=key : nextVar = "#{templvar}__#{key}"
					propStr += genTemplateString(key, value, nextVar, prefix) + ","
				end
				return propStr + "}"
			elsif @traverseArrays and data.is_a?(Array) and (!data.empty?)
				propStr = "[" 
				templvar.nil? ? nextVar="aRrAy" : nextVar = "#{templvar}__aRrAy"
				propStr += genTemplateString(name,data[0],nextVar, prefix) + ","
				return propStr + "]"
			elsif data.is_a?(Integer) or data.is_a?(Float)
				return "<%= "+prefix+templvar+" %>"
			elsif data.is_a?(Array)
				return "<%= "+prefix+templvar+" %>"
			elsif data == false or data == true
				return "<%= "+prefix+templvar+" %>"
			else
				return "\"<%= "+prefix+templvar+" %>\""
			end
		end

		# Generate our template
		def genTemplate(outputDir, instvar)

			instvar ? prefix="@" : prefix=""

			if @isBinary
				return true;
			end

			parsed = JSON.parse(@json)

			# Generate the template string for each property
			if @root.nil?
				erb = ''
				erb += genTemplateString(nil,parsed,nil,prefix)
			else
				erb = "{\"#{@root}\":"
				erb += genTemplateString(nil,parsed[@root],nil,prefix)
				erb += "}"
			end
			erb = erb.gsub(',}', '}')
			erb = erb.gsub('},}','}}')

			# Write the template to disk
			filename = "#{outputDir}/#{@type_}.erb"
			template = File.open(filename, "w")
			template.puts erb
			template.close

			# Dedupe our template
			parentFile = findParent(filename)
			if parentFile != nil
				@template = parentFile
				puts ("Deleting duplicate template: #{filename}. Using #{parentFile}\n")
				FileUtils.rm filename
			else
				puts("No Parent for: #{filename}")
			end

		end

		# If we're a binary manifest, then store our data in an external file.
		def genBinary(outputDir)

			if ( ! @isBinary )
				return true
			end

			if ( @data == nil || @data == "" )
				return true
			end

			filename = "#{outputDir}/#{@type_}.data"
			binary = File.open(filename, "w")
			binary.puts @data
			binary.close

		end

		# Write a node config to the given outfile.
		# By default we write all configuration to the outfile, however...
		# If allParams is false, then ignore params which are using defaults
		# If builtin is false, then don't create config for built-in objects (unless they're in use)
		def genNodeConfig(outfile, allParams, builtins, preReq, manifestDir, binDir=nil)

			isBuiltin = false
			myfile = "#{manifestDir}/#{@type_}.pp"

			if File.exist?(myfile)
				# I have my own manifest, I'm a builtin class
				isBuiltin = true
				parentFile = File.basename(myfile).chomp(".pp")
			else
				# Locate my type definition file
				parentFile = findParent(myfile, extension=".pp").chomp(".pp")
			end

			# Generate the classHash which will have all the defaults for my type
			if parentFile != nil
				classHash = parseManifest(manifestDir, parentFile)
				name = @uri.sub(/.*?\/config\/active\/.*\/(.*)/,'\1')
			else
				classHash = {}
			end

			# If I'm binary and a builtin class, then read in my default data
			if @isBinary
				if isBuiltin
					myDataFile = classHash["content"].sub("brocadevtm","#{manifestDir}../files")[7..-4]
					if File.exist?(myDataFile) 
						myData = File.read(myDataFile) 
					else
						myData = ""
					end
				else
					myData = ""
				end

			# If I'm a JSON object, then decode the data
			else
				decodeJSON()

				# Process the preReqs to determine which objects we have dependencies on. This will 
				# populate the requires meta-data, and inform puppet of our relationships to ensure
				# objects are created in a sensible order. 
				if preReq.has_key?(parentFile)
					checkRequires(parentFile,preReq,manifestDir,builtins,outfile)
				end

				# If we're generating a sparse config or excluding default built-in classes
				# then check to see which params are using defaults and drop them.
				if (!allParams) or (isBuiltin and !builtins) 
					@params.each do |key,value|
					value = inspectValue(value)
						if classHash.has_key?(key)
							if classHash[key] == value
								@params.delete(key)
							else
								puts("Including/Declaring #{@type}, uses custom setting for: #{key}")
							end
						end
					end
				end
			end

			# If we're a unmodified built-in, and built-ins are excluded, then we're done
			if (!builtins) and isBuiltin 
				if (!@isBinary) and @params.empty?
					puts("Ignoring BuiltIn JSON Object: #{@type_}")
					return
				elsif @isBinary and myData == @data
					puts("Ignoring BuiltIn Binary Object: #{@type_}")
					return
				end
			end

			# Append my configuration to the output file
			nodefile = File.open(outfile,"a")
			if isBuiltin
				if @isBinary

					if (myData != @data) or allParams
						dataOut = writeBinFile(outfile,binDir)
						nodefile.puts("\nclass { 'brocadevtm::#{@type_}':\n")
						nodefile.puts("  ensure => present,\n")
						nodefile.puts("  content => file('#{dataOut}'),\n")
						nodefile.puts("}\n\n")
					else
						nodefile.puts("include brocadevtm::#{@type_}\n")
					end

				else

					if @params.empty?
						nodefile.puts("include brocadevtm::#{@type_}\n")
					else
						nodefile.puts("\nclass { 'brocadevtm::#{@type_}':\n")
						@params.each do |key,value|
							value = inspectValue(value)
							sp = " " * ( @maxKeyLength - key.length )
							nodefile.puts("  #{key}#{sp} => #{value},\n")
						end
						nodefile.puts("}\n\n")
					end

				end
			else

				nodefile.puts("\nbrocadevtm::#{parentFile} { '#{name}':\n")
				if @isBinary
						dataOut = writeBinFile(outfile,binDir)
						nodefile.puts("  ensure => present,\n")
						nodefile.puts("  content => file('#{dataOut}'),\n")
				else

					@maxKeyLength >= 6 ? sp = " " * ( @maxKeyLength - 6 ) : sp = " "
					nodefile.puts("  ensure#{sp} => present,\n")
					if ! @params.empty?
						@params.each do |key,value|
							value = inspectValue(value)
							sp = " " * ( @maxKeyLength - key.length )
							nodefile.puts("  #{key}#{sp} => #{value},\n")
						end
					end
				end
				nodefile.puts("}\n\n")

			end
			nodefile.close()

		end

		# This function generates the requires meta-data for puppet. We check the prereqs provided
		# and create a relationship for each object we use. If builtins are set to be excluded, but
		# we rely on one (eg monitors_ping), then include it here.
		def checkRequires(parentFile,preReq,manifestDir,builtins,outfile)
			requires = "["
			preReq[parentFile].each do |req|
				reqObject = req.shift
				reqVar = req.shift
				reqType = req.shift
				if (@params.has_key?(reqVar))
					if (@params[reqVar].is_a? Array)
						@params[reqVar].each do |item|
							if item.is_a?(Hash)
								puts(" --!!-- TODO : we do not yet write 'require's for Aptimizer or SNI mappings !!--!!")
							else
								ro_ = reqObject.gsub(/[\/\.\s-]|%20/, "_")
								item_ = item.gsub(/[\/\.\s-]|%20/, "_").downcase
								if File.exist?("#{manifestDir}/#{ro_.downcase}_#{item_}.pp")
									# This is a builtin class
									if (!builtins)
										puts("Relationship found for Built-in object: Including: brocadevtm::#{ro_.downcase}_#{item_}")
										# builtins are disabled, so check and include if needed
										lines = IO.readlines(outfile)
										if ( lines.grep(/brocadevtm::#{ro_.downcase}_#{item_}/).empty? )
											nodefile = File.open(outfile,"a")
											nodefile.puts("\ninclude brocadevtm::#{ro_.downcase}_#{item_}\n")
											nodefile.close()
										end  
									end
									requires += " Class[Brocadevtm::#{ro_}_#{item_}], "
								else
									escaped = item.gsub(' ', '%20')
									requires += " Brocadevtm::#{reqObject}['#{escaped}'], "
								end
							end
						end
					elsif (@params[reqVar].is_a? String)
						if @params[reqVar] == ''
							next
						end
						if req.empty? or ( (!req.empty?) and (!req.include?(@params[reqVar])) )
							escaped = @params[reqVar].gsub(' ', '%20')
							requires += " Brocadevtm::#{reqObject}['#{escaped}'], "
						end
					end
				end
				if requires != '['
					@params["require"] = requires + "]"
				end
			end
		end

		# Write the binary data out to a file in the binDir. If binDir is not specified then
		# create a file using the outfile as a prefix.
		def writeBinFile(outfile, binDir)

			if binDir.nil?
				outfile = outfile.gsub(/\./,"_") + "_" + @type_ + ".data"
			else
				outfile = binDir + "/" + @type_ + ".data"
			end

			# Write the file as 8bit ascii to avoid corruption
			outfile = File.expand_path(outfile)
			out = File.open(outfile, "wb:ASCII-8BIT")
			out.write(@data)
			out.close()

			return outfile

		end

		# Generate a classHash of default values from a given manifest.
		# This classHash can then be used in direct comparisson with @params
		def parseManifest(manifestDir,parentFile)
			classHash = {}
			File.open("#{manifestDir}/#{parentFile}.pp", "r").each_line do |line|
				line.scan(/\s+\$([^\s]+)\s+=\s+['"]{0,1}(.*?)['"]{0,1},\n$/) do |key,value|
					if value == "undef"
						classHash[key] = 'undef'
					elsif value.match(/^[0-9]+$/)
						classHash[key] = Integer(value)
					elsif value == "false"
						classHash[key] = false
					elsif value == "true"
						classHash[key] = true
					elsif value == "[]"
						classHash[key] = "'[]'"
					else
						classHash[key] = "'" + value + "'"
					end
				end
			end
			return classHash
		end

		# Convert values from the format used internally by ruby into the correct format
		# for writing to puppet manifests.
		def inspectValue(value)
			if value == ""
				value = "undef"
			elsif value.is_a?(Array)
				value = "'" + JSON.generate(value) + "'"
			elsif value.is_a?(String)
				if value.start_with?('[ Brocadevtm::')
					value = value.inspect[1...-1] 
				elsif value.start_with?('[ Class[')
					value = value.inspect[1...-1] 
				else
					value = "'" + value.inspect[1...-1] + "'"
				end
			end
			return value
		end

		# Check to see if this filename has a parent object. 
		# If the file type is erb, then compare the file with it's parent.
		# If the file type is pp, then check for Define, ignore Class.
		def findParent(filename, extension=".erb")
			parentFile = nil
			parent = nil
			filetree = filename.chomp(extension).split("_")
			filetree.each do |test|
				if parent == nil
					parent = test
				else
					parent += "_" + test
				end
				test = parent+extension
				if ( test == filename )
					break
				elsif ( File.exist?(test) )
					if extension == ".erb"
						if FileUtils.compare_file(test,filename)
							parentFile=test
						end
					elsif extension == ".pp"
						if IO.read(test,7) == "# === D"
							parentFile=test
						end
					end
				end
			end
			if parentFile != nil
				return File.basename parentFile
			end
			return nil
		end

		# Dump detailed information about this manifest to stdout
		def dump()
			puts( "================================")
			puts("Type: #{@type}")
			puts("URI: #{@uri}")
			puts("Binary: #{@isBinary}")
			puts("object: #{@object}")
			puts("Required: #{@required}")
			if ( @isBinary )
				puts("DATA: #{@data}")
			else
				puts("JSON: #{@json}")
			end
			puts( "================================")
		end

	end

end
