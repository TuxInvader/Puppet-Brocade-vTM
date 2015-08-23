#!/usr/bin/ruby

require 'json'
require 'uri'
require 'fileutils'

class PuppetManifest

	def initialize(type, uri, restVersion, object)
		@type = type
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
		type_ = @type.gsub(/[\/\.-]|%20/, "_").downcase

		docfile = "skel/docs/#{type_}.doc"
		if ( File.exist?(docfile) )
			documentation = File.read(docfile)
			if isClass
				documentation.sub!("<CLASS-OR-TYPE-DECLARATION>","class {'brocadevtm::#{type_}':")
			else 
				documentation.sub!("<CLASS-OR-TYPE-DECLARATION>","brocadevtm::#{type_} { 'example':")
			end
		elsif (@template != nil)
			parent = @template.chomp(".erb")
			documentation = "#\n# This class is a direct implementation of brocadvtm::#{parent}\n"
			documentation += "#\n# Please refer to the documentation in that module for more information\n"
			documentation += "#\n"
		else
			documentation = ""
		end

		if isClass
			desc = "# === Class: brocadevtm::#{type_}\n"
			code = "class brocadevtm::#{type_} (\n"
			code += "  \$ensure = present,\n"
		else
			desc = "# === Define: brocadevtm::#{type_}\n"
			code = "define brocadevtm::#{type_} (\n"
			code += "  \$ensure,\n"
		end
		if @isBinary 
			if isClass 
				code += "  \$content = file('brocadevtm/#{type_}.data'),\n){\n"
			else
				code += "  \$content,\n){\n"
			end
		else
		
			decodeJSON()
			@required.each_key do |key|
				$stderr.puts($key)
				code += "  \$#{key},\n"
			end

			@params.each do |key,value|
				sp = " " * ( @maxKeyLength - key.length )
				if value.is_a?(String) and value != "undef"
					if value == ""
						value = "undef"
					else
						value = "'" + value.gsub(/(["'])/, '\\\\\1') + "'"
					end
				elsif value.is_a?(Array)
					value = "'#{value}'"
				end
				code += "  \$#{key}#{sp} = #{value},\n"
			end
			code += "){\n"
		end

		code += "  include brocadevtm\n"

		code += "  $ip      = $brocadevtm::rest_ip\n"
		code += "  $port    = $brocadevtm::rest_port\n"
		code += "  $user    = $brocadevtm::rest_user\n"
		code += "  $pass    = $brocadevtm::rest_pass\n\n"
		code += "  info (\"Configuring #{type_} ${name}\")\n"

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
				code += "    content    => template('brocadevtm/#{type_}.erb'),\n"
			else
				code += "    content    => template('brocadevtm/#{@template}'),\n"
			end
			code += "    type       => 'application/json',\n"
			code += "    internal   => '#{type_}',\n"
		end
		code += "    debug      => 0,\n"
		code += "  }\n}\n"

		filename = "#{outputDir}/#{type_}.pp"
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
		elsif data.is_a?(Integer)
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

		type_ = @type.gsub(/[\/\.-]|%20/, "_").downcase
		filename = "#{outputDir}/#{type_}.erb"
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

		type_ = @type.gsub(/[\/\.-]|%20/, "_").downcase
		filename = "#{outputDir}/#{type_}.data"
		binary = File.open(filename, "w")
		binary.puts @data
		binary.close

	end

	# static objects can cause us to generate lots of duplicate templates.
        # Remove any duplicates and store the parent template in @template
	def dedupe(filename)
		template = nil
		parent = nil
		filetree = filename.chomp(".erb").split("_")
		filetree.each do |test|
			if parent == nil
				parent = test
			else
				parent += "_" + test
			end
			test = parent+".erb"
			if ( test == filename )
				break
			elsif ( File.exist?(test) )
				if FileUtils.compare_file(test,filename)
					template=test;
				end
			end
		end
		if template != nil
			puts ("Deleting duplicate template: #{filename}. Using #{template}\n")
			FileUtils.rm filename
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

