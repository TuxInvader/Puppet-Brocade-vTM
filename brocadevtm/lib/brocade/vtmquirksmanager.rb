#!/usr/bin/ruby

require 'json'
require 'net/https'
require 'uri'
require 'openssl'
require 'digest'

require_relative 'quirksmanager'

module BrocadeREST

	class VtmQuirksManager < QuirksManager

		def initialize(restVersion)

			super(restVersion)

			@quirks = [ "ssl_server_keys", "ssl_client_keys" ]
			@quirkHash = {}

			@quirkHash["ssl_server_keys"] = { manifest: '{"properties":{"basic":{"note":"","public":"","private":"","request":""}}}', 
													required: [{"name"=>"basic__public","example"=>""},{"name"=>"basic__private","example"=>""}],
												 	compareFunc: "hashPrivateKey", writeFunc: "stripHashValue" }

			@quirkHash["monitors"] = { writeFunc: "setEditableKeys" }
			@quirkHash["pools"] = { readFunc: "nodePriorities" }

			# SSL Client and Server keys need the same additional processing
			@quirkHash["ssl_client_keys"] = @quirkHash["ssl_server_keys"]

		end

		# Special Functions

		# Create a Base64 encoded SHA256 hash of the private key data for comparison with REST API
		# Compare functions should accept a JSON string, and return a hash for comparison
		def hashPrivateKey(uri, json)
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
		def stripHashValue(uri, json)
			hash = JSON.parse(json)
			if ( ! hash["properties"]["basic"]["private"].start_with?("-----BEGIN") )
				hash["properties"]["basic"].delete("private")
				return JSON.generate(hash)
			else
				return json
			end
		end

		# Add expert_keys to monitor put requests so that they can be seen in the UI.
		def setEditableKeys(uri, json)

			# Editable keys not available prior to REST Version 3.5 (vTM 10.1)
			if @restVersion < 3.5
				return json
			end

			# monitor types 'rtsp', 'sip', 'tcp_transaction'
			hash = JSON.parse(json)
			type = hash["properties"]["basic"]["type"]
			case type
			when "http"
				uri.query = "expert_keys=editable_keys,can_use_ssl"
				hash["properties"]["basic"]["editable_keys"] = ["authentication","body_regex","host_header","path","status_regex"]
				hash["properties"]["basic"]["can_use_ssl"] = true
				json = JSON.generate(hash)
			when "rtsp"
				uri.query = "expert_keys=editable_keys"
				hash["properties"]["basic"]["editable_keys"] = ["rtsp_body_regex","rtsp_path","rtsp_status_regex"]
				json = JSON.generate(hash)
			when "program"
				uri.query = "expert_keys=can_use_ssl"
				hash["properties"]["basic"]["can_use_ssl"] = true
				json = JSON.generate(hash)
			when "sip"
				uri.query = "expert_keys=editable_keys,can_use_ssl,can_edit_ssl"
				if hash["properties"]["sip"]["transport"] == "udp"
					hash["properties"]["basic"]["editable_keys"] = ["sip_status_regex","sip_body_regex","udp_accept_all"]
				else
					hash["properties"]["basic"]["editable_keys"] = ["sip_status_regex","sip_body_regex"]
				end
				hash["properties"]["basic"]["can_use_ssl"] = true
				json = JSON.generate(hash)
			when "tcp_transaction"
				uri.query = "expert_keys=editable_keys,can_use_ssl"
				hash["properties"]["basic"]["editable_keys"] = ["write_string","close_string","response_regex"]
				hash["properties"]["basic"]["can_use_ssl"] = true
				json = JSON.generate(hash)
			end
			return json
		end

		# Insert the node priority and weight values if they are missing.
		def nodePriorities(json)
			hash = JSON.parse(json)
			modified = false
			hash["properties"]["basic"]["nodes_table"].each do |node|
				if (! node.include?("priority"))
					node["priority"] = 1
					modified = true
				end
				if (! node.include?("weight"))
					node["weight"] = 1
					modified = true
				end
			end
			if modified
				return JSON.generate(hash)
			else
				return json
			end
		end
	end
end

