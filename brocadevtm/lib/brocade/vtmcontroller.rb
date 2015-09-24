#!/usr/bin/ruby

require 'json'
require 'net/https'
require 'uri'
require 'openssl'
require 'digest'

require_relative 'restcontroller'
require_relative 'vtmquirksmanager'

module BrocadeREST

	class VTMController < RestController

		def initialize(user, pass, uri, manifestClass, loggerLevel=0)
			none, host, port, restVersion = uri.split(/^https:\/\/([^:]*):([0-9]+)\/api\/tm\/([^\/]*)\/.*/)
			super(user, pass, uri, restVersion, manifestClass, loggerLevel, "properties", false)
			@probeName = "BrocadeRESTProbe"
			@qm = VtmQuirksManager.new(restVersion)
			@quirks = @qm.getQuirks()
		end

	end

end

