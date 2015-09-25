#!/usr/bin/ruby

require 'json'
require 'net/https'
require 'uri'
require 'openssl'
require 'digest'

module BrocadeREST

	class QuirksManager

		def initialize(restVersion)

			@restVersion = restVersion
			@quirks = [ ]
			@quirkHash = {}

			# manifest: JSON String 
			# required: array of required params
			# writeFunc: Any special function required for writing JSON - returns the json
			# compareFunc: Any special function required prior to comparing JSON - returns a hash
			# readFunc: Any special function required when reading JSON - returns the json
			# deleteFunc: Any special function required prior to deletion - not used

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

	end
end
