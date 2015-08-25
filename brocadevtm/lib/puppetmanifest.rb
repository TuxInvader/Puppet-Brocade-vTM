#!/usr/bin/ruby

require 'json'
require 'uri'
require 'fileutils'

class PuppetManifest

	def initialize(type, uri, restVersion, object)
		@type = type
		@type_ = type.gsub(/[\/\.-]|%20/, "_").downcase
		@uri = uri.path
		@restVersion = restVersion
		@json = nil
		@data = nil
		@isBinary = false
		@object = object
		@params = {}
		@required = {}
		@maxKeyLength = 0
		@template = nil;
	end

	def addRequiredParam(name, example)
		@required[name] = { class: example.class, example: example }
	end

	def setBinary(isBinary)
		@isBinary = isBinary
		if isBinary
			@json = nil
		end
	end
			
	def setJSON(json)
		@isBinary = false
		@json = json
		@data = nil
	end

	def setData(data)
		@isBinary = true
		@json = nil
		@data = data
	end

	def decodeJSON()
		if @isBinary
			return
		end
		if @json == nil
			puts("** ERROR ** JSON is null for #{@type}")
			return
		end
		parsed = JSON.parse(@json)
		parsed["properties"].each do |property, data|
			genParams(property, data)
		end
	end

	def genParams(name, data)
		if data.is_a?(Hash)
			data.each do |key, value|
				genParams(name+"__"+key, value)
			end
		else
			@maxKeyLength = name.length if name.length > @maxKeyLength
			if data == nil or data == ""
				data = ""
			end
			if ! @required.has_key?(name)
				@params[name] = data 
			end
		end
	end	

	def genManifest(outputDir,isClass=false)

		docfile = "skel/docs/#{@type_}.doc"
		if ( File.exist?(docfile) )
			documentation = File.read(docfile)
			if isClass
				documentation.sub!("<CLASS-OR-TYPE-DECLARATION>","class {'brocadevtm::#{@type_}':")
			else 
				documentation.sub!("<CLASS-OR-TYPE-DECLARATION>","brocadevtm::#{@type_} { 'example':")
			end
		elsif (@template != nil)
			parent = @template.chomp(".erb")
			documentation = "#\n# This class is a direct implementation of brocadvtm::#{parent}\n"
			documentation += "#\n# Please refer to the documentation in that module for more information\n"
			documentation += "#\n"
		else
			documentation = ""
		end

		decodeJSON()

		if isClass
			desc = "# === Class: brocadevtm::#{@type_}\n"
			code = "class brocadevtm::#{@type_} (\n"
			@maxKeyLength >= 6 ? sp = " " * ( @maxKeyLength - 6 ) : sp = " "
			code += "  \$ensure#{sp} = present,\n"
		else
			desc = "# === Define: brocadevtm::#{@type_}\n"
			code = "define brocadevtm::#{@type_} (\n"
			code += "  \$ensure,\n"
		end
		if @isBinary 
			if isClass 
				code += "  \$content = file('brocadevtm/#{@type_}.data'),\n){\n"
			else
				code += "  \$content,\n){\n"
			end
		else
		
			@required.each_key do |key|
				$stderr.puts($key)
				code += "  \$#{key},\n"
			end

			@params.each do |key,value|
				value = inspectValue(value)
				sp = " " * ( @maxKeyLength - key.length )
				code += "  \$#{key}#{sp} = #{value},\n"
			end
			code += "){\n"
		end

		code += "  include brocadevtm\n"

		code += "  $ip      = $brocadevtm::rest_ip\n"
		code += "  $port    = $brocadevtm::rest_port\n"
		code += "  $user    = $brocadevtm::rest_user\n"
		code += "  $pass    = $brocadevtm::rest_pass\n\n"
		code += "  info (\"Configuring #{@type_} ${name}\")\n"

		if isClass
			code += "  vtmrest { '#{@type}':\n"
		else
			code += "  vtmrest { \"#{@type}/\${name}\":\n"
		end
		code += "    ensure     => $ensure,\n"
		code += "    endpoint   => \"https://\${ip}:\${port}/api/tm/#{@restVersion}/config/active\",\n"
		code += "    username   => $user,\n"
		code += "    password   => $pass,\n"
		if @isBinary
			code += "    content    => $content,\n"
			code += "    type       => 'application/octet-stream',\n"
		else
			if @template == nil
				code += "    content    => template('brocadevtm/#{@type_}.erb'),\n"
			else
				code += "    content    => template('brocadevtm/#{@template}'),\n"
			end
			code += "    type       => 'application/json',\n"
			code += "    internal   => '#{@type_}',\n"
		end
		code += "    debug      => 0,\n"
		code += "  }\n}\n"

		filename = "#{outputDir}/#{@type_}.pp"
		manifest = File.open(filename, "w")
		manifest.puts desc
		manifest.puts documentation
		manifest.puts code
		manifest.close
	end

	def genTemplateString(name,data,templvar)
		if data.is_a?(Hash)
			propStr = "\"#{name}\":{"
			data.each do |key, value|
				templvar = name+"__"+key
				propStr += '"'+key+'":'
				propStr += genTemplateString( name[key], value, templvar) + ","
			end
			return propStr + "},"
		elsif data.is_a?(Integer) or data.is_a?(Float)
			return "<%= @"+templvar+" %>"
		elsif data.is_a?(Array)
			return "<%= @"+templvar+" %>"
		elsif data == false or data == true
			return "<%= @"+templvar+" %>"
		else
			return "\"<%= @"+templvar+" %>\""
		end
	end

	def genTemplate(outputDir)

		if @isBinary
			return true;
		end

		parsed = JSON.parse(@json)
	
		erb = '{"properties":{';
		parsed["properties"].each do |property, data|
			erb += genTemplateString(property,data,"") 
		end
		erb += "}}"
		erb = erb.gsub(',}', '}')
		erb = erb.gsub('},}','}}')

		filename = "#{outputDir}/#{@type_}.erb"
		template = File.open(filename, "w")
		template.puts erb
		template.close

		dedupe(filename)

	end

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
   # If builtin is false, then don't create config for built-in objects
	def genNodeConfig(outfile, allParams, builtins, manifestDir, binDir=nil)

		isBuiltin = false
		myfile = "#{manifestDir}/#{@type_}.pp"

		if File.exist?(myfile)
			isBuiltin = true
			@template = File.basename(myfile)
		else
			dedupe(myfile, extension=".pp")
		end

		if @template
			classHash = parseManifest(manifestDir)
			name = @uri.sub(/.*?\/config\/active\/.*\/(.*)/,'\1')
		else
			classHash = {}
		end

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
		else
			decodeJSON()
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

		if (!builtins) and isBuiltin 
			if (!@isBinary) and @params.empty?
				puts("Ignoring BuiltIn JSON Object: #{@type_}")
				return
			elsif @isBinary and myData == @data
				puts("Ignoring BuiltIn Binary Object: #{@type_}")
				return
			end
		end

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
			
			nodefile.puts("\nbrocadevtm::#{@template.chomp(".pp")} { '#{name}':\n")
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

	def writeBinFile(outfile, binDir)

		if binDir.nil?
			outfile = outfile.gsub(/\./,"_") + "_" + @type_ + ".data"
		else
			outfile = binDir + "/" + @type_ + ".data"
		end

		outfile = File.expand_path(outfile)
		out = File.open(outfile, "wb:ASCII-8BIT")
		out.write(@data)
		out.close()

		return outfile

	end

	def parseManifest(manifestDir)
		classHash = {}
		File.open("#{manifestDir}/#{@template}", "r").each_line do |line|
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

	def inspectValue(value)
		if value == ""
			value = "undef"
		elsif value.is_a?(Array)
			value = "'" + JSON.generate(value) + "'"
		elsif value.is_a?(String)
			value = "'" + value.inspect[1...-1] + "'"
		end
		return value
	end

	# static objects can cause us to generate lots of duplicate templates.
   # Remove any duplicates and store the parent template in @template
	def dedupe(filename, extension=".erb")
		template = nil
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
						template=test
					end
				else
					if IO.read(test,7) == "# === D"
						template=test
					end
				end
			end
		end
		if template != nil
			if extension == ".erb"
				puts ("Deleting duplicate template: #{filename}. Using #{template}\n")
				FileUtils.rm filename
			end
			@template = File.basename template
		end
	end

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

