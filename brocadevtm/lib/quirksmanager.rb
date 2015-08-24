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
		# writeFunc: Any special function required for writing JSON
		# compareFunc: Any special function required prior to comparing JSON
		# readFunc: Any special function required prior to reading JSON
		# deleteFunc: Any special function required prior to deletion

		@quirkHash["ssl_server_keys"] = { manifest: '{"properties":{"basic":{"note":"","public":"","private":"","request":""}}}', 
													required: [{"name"=>"basic__public","example"=>""},{"name"=>"basic__private","example"=>""}],
												 	compareFunc: "hashPrivateKey" }
	
		# SSL Client and Server keys need the same additional processing
		@quirkHash["ssl_client_keys"] = @quirkHash["ssl_server_keys"]

	end

	def getQuirks()
		return @quirks
	end

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

end

