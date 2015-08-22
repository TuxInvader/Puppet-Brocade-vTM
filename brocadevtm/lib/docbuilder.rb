#!/usr/bin/ruby

require 'fileutils'
require 'json'

class DocBuilder

	def initialize(dir)
		@dir = dir
		@docHash = nil
		@id = nil
		@title = nil
		@description = nil
		@required = nil
	end

	def buildDoc
		@docHash = {}
		schema = File.read( "#{@dir}/read.schema.json")
		schemaHash = JSON.parse(schema);
		@id = schemaHash["id"].sub(/.*\/config\/active\/([^#]*)#read/, '\1').gsub(/\//,'_')
		@title = schemaHash["title"]
		@description = schemaHash["description"]
		genParams(schemaHash["properties"]["properties"])
		getRequiredParams()
	end
	
	def genParams(props, name=nil)
		if props.is_a?(Hash)
			if (props.has_key?("properties"))
				props["properties"].each do |section|
					genParams(section,name)
				end
			elsif (props.has_key?("description"))
				if (props.has_key?("items"))
					type = props["type"]
					items = props["items"]["properties"]
					@docHash[name] = "#{props["description"]}\n# Type:#{type}, Details:#{items}\n"
				else
					@docHash[name] = "#{props["description"]}\n"
				end
			end
		elsif props.is_a?(Array)
			if name == nil
				name = props[0]
			else
				name = name+"__"+props[0]
			end
			genParams(props[1], name)
		else
			raise "Unexpected schema path discovered: #{name}, hash: #{props}"
		end
	end

	def getRequiredParams
		schema = File.read( "#{@dir}/create.schema.json")
		schemaHash = JSON.parse(schema);
		props = schemaHash["properties"]["properties"]["properties"]
		if props.has_key?("basic")
			if props["basic"].has_key?("required")
				@required = {}
				props["basic"]["required"].each do |param|
					type = props["basic"]["properties"][param]["type"]
					@required["basic__#{param}"] = type
				end
			end
		end
	end

	def writeDoc(dir)
		if @id == nil
			return false
		end

		output = File.open("#{dir}/#{@id}.doc", "w")
		output.puts("#")
		output.puts("# #{@title}")
		output.puts("# #{@description}")
		output.puts("#")
		output.puts("# === Parameters")
		@docHash.each do |param,doc|
			output.puts("#")
			output.puts("# [*#{param}*]")
			output.puts("# #{doc}")
		end

		output.puts("# ")
		output.puts("# === Examples")
		output.puts("# ")
		output.puts("# <CLASS-OR-TYPE-DECLARATION> ")
		output.puts("#     ensure => present,")

		if ( @required != nil )
			@required.each do |name,type|
				if type == "boolean"
					output.puts("#     #{name} => true")
				elsif type == "integer"
					output.puts("#     #{name} => 8888")
				elsif type == "array"
					output.puts("#     #{name} => ['obj1','obj2']")
				else
					output.puts("#     #{name} => 'foo'")
				end
			end
		end

		output.puts("# }")
		output.puts("# ")

		output.puts("# ")
		output.puts("# === Authors")
		output.puts("# ")
		output.puts("# Mark Boddington <mbodding@brocade>")
		output.puts("# ")
		output.puts("# === Copyright")
		output.puts("# ")
		output.puts("# Copyright 2015 Brocade")
		output.puts("# ")
		
		output.close()
	end

end

