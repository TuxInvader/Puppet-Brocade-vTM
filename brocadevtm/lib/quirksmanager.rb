#!/usr/bin/ruby

require 'json'
require 'net/https'
require 'uri'
require 'openssl'
require 'digest'

class QuirksManager

	def initialize()
	
		@quirks = [ "ssl_server_keys", "ssl_client_keys" ]
		@quirkHash = {}

		# manifest: JSON String 
		# required: array of required params
		# writeFunc: Any special function required for writing JSON - returns the json
		# compareFunc: Any special function required prior to comparing JSON - returns a hash
		# readFunc: Any special function required prior to reading JSON - not used 
		# deleteFunc: Any special function required prior to deletion - not used

		@quirkHash["ssl_server_keys"] = { manifest: '{"properties":{"basic":{"note":"","public":"","private":"","request":""}}}', 
													required: [{"name"=>"basic__public","example"=>""},{"name"=>"basic__private","example"=>""}],
												 	compareFunc: "hashPrivateKey", writeFunc: "stripHashValue" }
						
	
		# SSL Client and Server keys need the same additional processing
		@quirkHash["ssl_client_keys"] = @quirkHash["ssl_server_keys"]

	end

	# return the list of types which have quirks (currently this is just ssl)
	def getQuirks()
		return @quirks
	end

	# Return a specific quickhash
	def getQuirk(name)
		return @quirkHash[name]
	end

	# Special Functions

	# Create a Base64 encoded SHA256 hash of the private key data for comparison with REST API
	# Compare functions should accept a JSON string, and return a hash for comparison
	def hashPrivateKey(json)
		hash = JSON.parse(json)
		if ( ! hash["properties"]["basic"]["private"].start_with?("-----BEGIN") )
			# private is not a private key, maybe we stored the hash? Do nothing.
			return hash
		end
		sha = Digest::SHA2.new(256)
		sha.update( hash["properties"]["basic"]["private"] )
		hash["properties"]["basic"]["private"] = sha.base64digest()
		return hash
	end

	# If the private key is not the full key, then strip it out of the JSON, 
   # we don't want to hose the private key by overwriting it with its checksum
	def stripHashValue(json)
		hash = JSON.parse(json)
		if ( ! hash["properties"]["basic"]["private"].start_with?("-----BEGIN") )
			hash["properties"]["basic"].delete("private")
			return JSON.generate(hash)
		else
			return json
		end
	end

end

