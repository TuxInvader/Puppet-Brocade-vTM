#!/usr/bin/ruby

# Show all Expert keys QS == show_expert_keys=_all_

require 'json'
require 'net/https'
require 'uri'
require 'openssl'
require 'digest'

require_relative 'puppetmanifest'
require_relative 'quirksmanager'

class WalkTypes 
	READ = 1 
	PROBE = 2 
	DELETE = 4
end

class BrocadeVTMRestController

	def initialize(host, port, restVersion, user, pass, loggerLevel=0)
		@loggerLevel = Integer(loggerLevel)
		@restVersion = Float(restVersion)
		@uri = URI.parse("https://#{host}:#{port}/api/tm/#{restVersion}/config/active/")
		@user = user
		@pass = pass
		@http = Net::HTTP.new(@uri.host, @uri.port)
		@http.use_ssl = true
		@http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		@probeName = "PUPPETPROBE"
		@properties = '{"properties":{}}'
		@walkType = WalkTypes::READ
		@manifests = {}
		@objects = {}
		@knownParams = {}
		@preReq = {} 
		@rewalk = {}
		@qm = QuirksManager.new(@restVersion)
		@quirks = @qm.getQuirks()
		@homedir = File.expand_path( "#{File.dirname(__FILE__)}/.." )
		@generateOutOfTreeManifests = false
	end

	# Logger function to write log messages (level<0 - Error, level==0 - Notice, level>0 - Debug )
	def logger(level, msg)
		if ( @loggerLevel >= level )
			if level < 0
				$stderr.puts("ERROR: vtmrest: #{msg}")
			elsif level == 0
				$stdout.puts("Notice: vtmrest: #{msg}")
			else
				$stderr.puts("Debug: vtmrest: #{level}: #{msg}")
			end
		end
	end

	# set Walktype to :READ, :PROBE, or :DELETE
	def setType(walkType)
			@walkType = walkType
	end

	# Contiue on Error? Attempt to continue if we encounter problems
	# Currentlu just allows outoftree manifests to be attempted.  
	def continueOnError(cont)
		@generateOutOfTreeManifests = cont
	end

	# Return a new uri object for the provided path, by cloning our core @uri and
	# updating the path elements. Return nil if we jump hosts.
	def parseURI(uri)
		newURI = @uri.clone()
		if ( uri.start_with?("/") )
			newURI.path = uri
			return newURI
		elsif ( uri.start_with?("http") )
			fqURI = URI.parse(uri)
			if ( fqURI.host != @uri.host ) || ( fqURI.port != @uri.port ) 
				then logger(-1, "Change of host not supported")
				return nil
			else
				return fqURI
			end	
		else
			newURI.path += "/" if ( ! newURI.path.end_with?("/") )
			newURI.path += uri
			return newURI
		end
	end

	# do the get
	def do_get(uri)
		request = Net::HTTP::Get.new(uri.request_uri)
		request.basic_auth @user, @pass
		response = @http.request(request)
		case response
			when Net::HTTPSuccess then
				return response
			else
				logger(-1, "HTTP Call Failed: #{uri}, Response: #{response}")
				return nil
		end
	end

	# do the put
	def do_put(uri, body, ct="application/json")
		request = Net::HTTP::Put.new(uri.request_uri)
		request.basic_auth @user, @pass
		request['Content-Type'] = ct
		request.body=body
		response = @http.request(request)
		return response
	end

	# do the delete
	def do_delete(uri)
		request = Net::HTTP::Delete.new(uri.request_uri)
		request.basic_auth @user, @pass
		response = @http.request(request)
		return response
	end

	# GET the provided http string
	def getObject(object)
		uri = parseURI(object)
		response = do_get(uri)
		return nil if response == nil
		return response
	end

	# PUT the provided http string
	def putObject(object, body, contentType)
		uri = parseURI(object)
		response = do_put(uri, body, contentType)
		return nil if response == nil
		return response
	end

	# DELETE the provided http string
	def deleteObject(object)
		uri = parseURI(object)
		response = do_delete(uri)
		return nil if response == nil
		return response
	end

	# Puppet Compare Function
	def puppetCompare(name, content, type, internal) 
		uri = parseURI(name)
		vtmResponse = do_get(uri)
		if ( vtmResponse == nil )
			return nil
		elsif ( vtmResponse.code != "200" )
			return vtmResponse
		end
		if type == "application/json"
			qh = @qm.getQuirk(internal);
			if ( qh != nil and qh.is_a?(Hash) and qh.has_key?(:compareFunc) )
				puppet = @qm.send(qh[:compareFunc], uri, content)
			else
				puppet = JSON.parse(content)
			end
			vtm = JSON.parse(vtmResponse.body)
			#return deepCompare(name,puppet,vtm)
			return deepCompare(name,vtm,puppet)
			#return vtm == puppet
		else
			vtm = vtmResponse.body
			puppet = content.force_encoding(vtm.encoding)
			if ( vtm == puppet ) 
				return true
			end
		end
		return false
	end

	# Recurse over the hash and compare all elements. Simply using hash == hash can fail
	# when the keys are in a different order.
	def deepCompare(name, hash1, hash2)
		if hash1.is_a?(Hash)
			hash1.each do |key,value|
				if ( hash2.include?(key) )
					return false if ( ! deepCompare("#{name}:#{key}", value,hash2[key]) )
				else
					logger(0,"DeepCompare: #{name}, Missing Key '#{key}'")
					return false
				end
			end
		elsif hash1.is_a?(Array)
			# sort arrays before comparing
			sort1 = hash1.sort_by { |h| h.to_s }
			sort2 = hash2.sort_by { |h| h.to_s }
			sort1.each do |item1|
				item2 = sort2.shift
				return false if ( ! deepCompare("#{name}:#{item1}", item1,item2) )
			end	
		else
			if ( hash1 != hash2 )
				logger(0,"DeepCompare: #{name}, No Match '#{hash1}' vs '#{hash2}'")
				return false
			end
		end
		return true
	end

	# Puppet Create function
	def puppetCreate(name, content, type, internal)

		uri = parseURI(name)
		if type == "application/json"
			qh = @qm.getQuirk(internal);
			if ( qh != nil and qh.is_a?(Hash) and qh.has_key?(:writeFunc) )
				content = @qm.send(qh[:writeFunc], uri, content)
			end
		end
		return do_put(uri, content, type)
	end

	# Puppet Delete function
	def puppetDelete(name)
		return deleteObject(name)
	end

	# Load known parameters to use as default answers to mandatory params.
	# Used when we walk the API.
	def loadKnownParams()
		kpf = File.open( File.expand_path("../data/required.csv", __FILE__) )
		kpf.each_line do |line|
			entry = line.chomp.split(',')
			object = entry.shift
			if @knownParams.has_key?(object)
				@knownParams[object][entry.shift] = entry
			else
				@knownParams[object] =  { entry.shift => entry } 
			end
		end		
		kpf.close
	end

	# purge the vTM of unknown configuration objects.
	# stateDir should contain a file for each object type with a line for each object
	# Any children we find in an object tree, which do not appear in the file will be
	# deleted.
	def puppetPurge(stateDir)
		Dir.glob("#{stateDir}/*").each do |type|
			logger(1, "Purge: Checking state file: #{type}")
			uri = @uri.clone()
			# Read the state file and then delete it
			items = IO.readlines(type)
			File.unlink(type)
			# dont purge anything in root of configuration tree
			if (items.empty? or (!items[0].include?('/')))
				next
			end
			parent = items[0][0..items[0].rindex('/')]
			uri.path += parent
			logger(1, "Purge: Checking URI: #{uri}")
			response = do_get(uri)
			if response == nil
				logger(-1, "Purge: Failed to read URI: #{uri.path}. Response is nil")
				next
			elsif response.code != "200"
				logger(-1, "Purge: Failed to read URI: #{uri.path}. Response code: #{response.code}")
				next
			elsif ( response.content_type() != "application/json" )
				logger(-1, "Purge: Failed to read URI: #{uri.path}, Response was not JSON.")
				next
			else
				json = JSON.parse(response.body)
				if ( json == nil )
					logger(-1, "Purge: Failed to parse JSON: #{uri.path}.")
					next
				elsif (! json.has_key?("children") )
					logger(-1, "Purge: Failed to parse JSON: #{uri.path}, Response has no Children.")
					next
				end
				items.each {|item| item.strip!().gsub!('%20', ' ')}
				json["children"].each do |child|
					logger(2, "Purge: Child: #{child}" )
					if (! items.include?("#{parent}#{child["name"]}") )
						logger(0,"Purge: Removing unknown object: #{parent}#{child["name"]}")
						deleteObject(child["href"])
					end
				end
			end
		end
		return true
	end

	# read in the preRequisites file. This is used by genNodeConfig when generating the
	# requires paramater on puppet resources.
	def loadPreRequisites()
		@preReq = {}
		prf = File.open( File.expand_path("../data/precedence.csv", __FILE__) )
		prf.each_line do |line|
			entry = line.chomp.split(',')
			type = entry.shift
			if @preReq.include?(type)
				@preReq[type].push entry
			else
				@preReq[type] = [ entry ] 
			end
		end
		prf.close
	end

	def loadWalkOrdering()
		walkOrder = [ "monitors", "rules", "ssl_", "aptimizer", "locations", 
							"dns_", "glb_services", "kerberos_keytabs", "kerberos", 
							"pools", "traffic_ip_groups", "virtual_servers" ]
	end

	# Generate a new manifest.
	def newManifest(uri, object)
		if( ! uri.path.start_with?(@uri.path) )
			logger(-1, "This object is not in the config tree? If you have switched REST versions, this could cause problems")
			if @generateOutOfTreeManifests
				logger(-1, "Trying to Continue...")
			else
				return nil
			end
		end
		type = uri.path.byteslice(@uri.path.length..uri.path.length)
		type = type.chop() if ( type.end_with?("/") )
		name = type.gsub("/","_")
		newPM = PuppetManifest.new(type,uri,@restVersion,object)
		if ( object )
			if ( ! @objects.include?(name) )
				@objects[name] = newPM
				logger(2,"New Object: #{name}: #{uri}")
			end
		else
			if ( ! @manifests.include?(name) )
				@manifests[name] = newPM
				logger(2,"New Manifest: #{name}: #{uri}")
			end
		end
		return name
	end

	# Write a node config to the given outfile.
	# By default we write all configuration to the outfile, however...
	# If allParams is false, then ignore params which are using defaults
	# If builtin is false, then don't create config for built-in objects
	def dumpNodeConfig(outfile, allParams=true, builtin=true, manifestDir="#{@homedir}/manifests/", binDir=nil)

		loadPreRequisites()

		@objects.each do |name,manifest|
			preReq = Marshal.load(Marshal.dump(@preReq))
			manifest.genNodeConfig(outfile, allParams, builtin, preReq, manifestDir, binDir)
		end

	end

	# Dump out the Manifests to the console, and write to outputDir if provided
	def dumpConfig(type=:manifests, manOut=nil, tmpOut=nil, binOut=nil )
		if (type == :manifests) or ( type == :all )
			@manifests.each do |name,manifest|
				manifest.dump()
				if tmpOut != nil
					manifest.genTemplate(tmpOut)
				end
				if manOut != nil
					manifest.genManifest(manOut)
				end
				if binOut != nil
					manifest.genBinary(binOut)
				end
			end
		end
		if ( type == :objects ) or ( type == :all )
			@objects.each do |name,manifest|
				manifest.dump()
				if name.start_with?("traffic_managers_")
					next;
				end
				if tmpOut != nil
					manifest.genTemplate(tmpOut)
				end
				if manOut != nil
					manifest.genManifest(manOut, true)
				end
				if binOut != nil
					manifest.genBinary(binOut)
				end
			end
		end
	end

	# Recursive function to walk the REST API.
	def walk(uri=@uri.clone())
		loadKnownParams()
		loadPreRequisites()
		logger(1, "Walking: #{uri}" )
		properties = JSON.parse( @properties )
		response = do_get(uri)
		if ( response == nil )
			logger(-1, "WALK Failed")
			return
		end
		if ( response.content_type() == "application/json" ) 
			json = JSON.parse(response.body)
			if (json.has_key?("children"))
				logger(2, "Children: #{json}" )
				if ( json["children"].empty? )
					logger(2,"Empty Tree: #{uri}")
				end
				logger(2,"Probing: #{uri}")
				probe = probe(uri, properties) if @walkType == WalkTypes::PROBE
				if ( probe != nil )
					logger(2, "Creating Manifest for: #{uri}")
					name = newManifest(uri,false)
					if name.nil?
						logger(-1, "ERROR - (BUG?) newManifest returned nil for: #{uri}")
					elsif ( probe == :BINARY )
						@manifests[name].setBinary(true)
					else
						qh = @qm.getQuirk(name);
						if ( qh != nil and qh.is_a?(Hash) and qh.has_key?(:manifest) )
							quirkyJSON = qh[:manifest]
							@manifests[name].setJSON(quirkyJSON)
							if qh.has_key?(:required)
								qh[:required].each do |quirkyReqs|
									@manifests[name].addRequiredParam(quirkyReqs["name"],quirkyReqs["example"])
								end
							end
						else
							@manifests[name].setJSON(probe)
						end
					end
				end
				json["children"].each do |child|
					logger(2, child )
					nextURI = parseURI( child["href"] )
					walk( nextURI )
				end
			else
				logger(3, json )
				if @walkType == WalkTypes::PROBE or @walkType == WalkTypes::READ
					# Existing JSON object
					name = newManifest(uri,true)
					if name.nil?
						logger(-1, "(BUG?) newManifest returned nil for: #{uri}")
					else
						@objects[name].setJSON(response.body)
					end
				elsif @walkType == WalkTypes::DELETE && uri.path.end_with?(@probeName)
					logger(3, "Deleting Object: #{uri}")
					logger(3, do_delete(uri).body)
				end
			end
		else
			if @walkType == WalkTypes::PROBE or @walkType == WalkTypes::READ
				# Existing binary object
				name = newManifest(uri,true)
				if name.nil?
					logger(-1, "(BUG?) newManifest returned nil for: #{uri}")
				else
					@objects[name].setBinary(true)
					@objects[name].setData(response.body)
					logger(3, response.body )
				end
			elsif @walkType == WalkTypes::DELETE && uri.path.end_with?(@probeName)
				logger(3, "Deleting Object: #{uri}")
				logger(3, do_delete(uri).body)
			end
		end
	end

	# function to probe the API by attempting to create a new object within the tree named @probeName
	# We detect whether the API is expecting JSON or binary data, as well as any mandatory parameters
	def probe(uri, json)
		result = { }  
		testObject = uri.clone()
		testObject.path = testObject.path + @probeName
		logger(1,"Probe: #{testObject.path}")
		body = JSON.generate(json)
		response = do_put(testObject,body)
		case response
			when Net::HTTPSuccess then
				logger(4, "Probe: Body: #{response.body}" )
				logger(4, "Probe: Complete.")
				return response.body
			when Net::HTTPUnsupportedMediaType then
				logger(4, "Probe: Binary Upload Expected" )
				response = do_put(testObject, "foo\tbar\n", "application/octet-stream")
				logger(4, response)
				logger(4, "Probe: Complete.")
				return :BINARY
			when Net::HTTPForbidden then
				logger(4, "Probe: Invalid Resource")
				logger(4, "Probe: Complete.")
				return nil
			when Net::HTTPBadRequest then
				logger(4, "Probe: Mandatory parameter needed")
				name = newManifest(uri,false)
				if name.nil?
					logger(-1, "(BUG?) newManifest returned nil for: #{uri}")
					return nil
				end
				jsonError = JSON.parse(response.body)
				newJSON = (findNeededParams(name, uri, nil, jsonError))
				if ( newJSON == nil )
					logger(1, "Probe Failed: #{uri}")
					return nil
				end
				json['properties'] = newJSON
				return probe(uri, json)
			else
				logger(4, "Probe: Unhandled: #{response}" )
				return nil
		end
	end

	# This is called by the probe when it encounters missing mandatory parameters.
	# Ask the user what to do, providing a suggested answer if one exists in the knownparams data.
	# Also update the puppetmanifest object to inform it about the required parameter.
	def findNeededParams(name, uri, parent, jsonError)
		if (jsonError.class == Hash && jsonError.has_key?("error_id"))
			case jsonError["error_id"]
				when "resource.validation_error" then
					logger(4, "Resource Validation Error: Top Level")
					return findNeededParams(name, uri, parent, jsonError["error_info"] )
				when "property.no_default" then
					logger(4, "Resource Validation Error: No Default for #{parent}")
					print("Mandatory Parameter Required - Please enter a value for: #{name} -> #{parent}: ")
					if @knownParams[name] != nil and @knownParams[name].has_key?(parent)
						example = @knownParams[name][parent][1]
						example = @probeName if example == "_TESTOBJECT_"
						example = Integer(example) if @knownParams[name][parent][0] == "integer"
					else
						example = @probeName
					end
					print "[Default: #{example}]: "
					new = gets.chomp()
					if ( new != "" )
						example = new
						example = Integer(example) if example.match(/^\d+$/) 
					end
					logger(4, "Adding Required Param: #{parent} to manifest: #{name}")
					@manifests[name].addRequiredParam(parent, example)
					return example
				when "filename.forbiddenpath" then
					logger(4, "Can't use that name. Barf")
				when "json.wrong_type" then
					logger(4,"vTM reports wrong type")
				else
					logger(4, "Unhandled JSON Error #{jsonError}")
			end
		else
			newFields = {}
			if ( jsonError.class == Array )
				jsonError.each do |child|
					puts(" --------------------------------------- ARRAY: #{parent}, #{child}");
					if parent != nil
						param = parent+":"+child
					else
						param = child
					end
					newFields[child] = findNeededParams(name, uri, param, jsonError[child])
				end
			elsif ( jsonError.class == Hash )
				jsonError.each do |child,json|
					if parent != nil
						param = parent+"__"+child
					else
						param = child
					end
					newFields[child] = findNeededParams(name, uri, param, json)
				end
			else
				return jsonError
			end
			return newFields
		end
	end

end

