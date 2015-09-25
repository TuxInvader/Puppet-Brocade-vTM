#!/usr/bin/ruby

require 'fileutils'
require 'json'

module BrocadeREST

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
					mydoc = formatLine(props["description"], "# ")
					if (props.has_key?("items"))
						mydoc += formatLine("Type:#{props["type"]}", "# ")
						mydoc += formatLine("Properties:#{props["items"]["properties"]}", "# ")
					end
					@docHash[name] = mydoc
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

		def formatLine(line, prefix="", length=80)

			newline = ""
			length = length - prefix.length - 1

			if line.nil?
				return "\n"
			end

			if (! line.start_with?(prefix) )
				newline = prefix
			end

			#line = line.gsub(/\n/,"\n#{prefix}")
			while line.length > length do
				tmp = line.slice(0,length)
				nli = tmp.index(/\n/) 
				wsi = tmp.rindex(/\s/)
				if nli == nil || nli == 0
					if wsi == 0 || wsi == nil
						newline += line.slice!(0, 78) + "\n#{prefix}"
					else
						newline += line.slice!(0, wsi+1).strip + "\n#{prefix}"
					end
				else
					newline += line.slice!(0, nli+1).strip + "\n#{prefix}"
				end
			end
			newline = newline+line.strip
			return newline+"\n"
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
			output.puts( formatLine(@title, "# ") )
			output.puts( formatLine(@description, "# ") )
			output.puts("#")
			output.puts("# === Parameters")
			@docHash.each do |param,doc|
				output.puts("#")
				output.puts("# [*#{param}*]")
				output.puts("#{doc}")
			end

			output.puts("#")
			output.puts("# === Examples")
			output.puts("#")
			output.puts("# <CLASS-OR-TYPE-DECLARATION>")
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
			output.puts("#")

			output.puts("#")
			output.puts("# === Authors")
			output.puts("#")
			output.puts("# Mark Boddington <mbodding@brocade>")
			output.puts("#")
			output.puts("# === Copyright")
			output.puts("#")
			output.puts("# Copyright 2015 Brocade")
			output.puts("#")

			output.close()
		end

	end
end
