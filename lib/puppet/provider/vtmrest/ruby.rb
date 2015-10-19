require_relative '../../../brocade/vtmcontroller'
require_relative '../../../brocade/puppetmanifest'
require 'json'
require 'puppet/util/logging'

Puppet::Type.type(:vtmrest).provide(:ruby) do

	include Puppet::Util::Logging

	def exists?

		initVtmrc
		if resource[:type] == 'purge'
			return @vtmrc.objectPurge(resource[:content])
		end

		$response = @vtmrc.objectCompare(resource[:name], resource[:content], resource[:type], resource[:internal], resource[:failfast])
		if $response == true
			send_log(:notice, "Object #{resource[:name]} OK")
			return true;
		elsif $response == false
			send_log(:warning, "Object #{resource[:name]} differs from catalog")
			@vtmrc.getErrors.each do |error|
				send_log(:warning, error)
			end
			return false
		else
			send_log(:crit, "REST call Failed for: #{resource[:name]} ")
			@vtmrc.getErrors.each do |error|
				send_log(:crit, error)
			end
			return false;
		end
	end

	def create
		initVtmrc
		#$stdout.puts("Notice: Creating #{resource[:name]}")
		#if ( resource[:type] == "application/json" )
		#	$stdout.puts("Notice: Content #{resource[:content]}")
		#end
		send_log(:info, "Creating: #{resource[:name]}")
		$response = @vtmrc.objectCreate(resource[:name], resource[:content], resource[:type], resource[:internal])
		if $response == nil || ( ! $response.code.start_with?("20") )
			send_log(:warning, "Failed to create: #{resource[:name]}")
			@vtmrc.getErrors.each do |error|
				send_log(:notice, error)
			end
			raise(Puppet::Error, "Failed to create '#{resource[:name]}'")
			return false
		end
		send_log(:notice, "Object #{resource[:name]} Created.")
		return true
	end

	def destroy
		send_log(:notice, "Removing: #{resource[:name]}")
		@vtmrc.objectDelete(resource[:name])
	end

	private

	def initVtmrc
		@vtmrc = BrocadeREST::VTMController.new(resource[:username], \
				resource[:password], resource[:endpoint], \
				nil, resource[:debug])
	end


end
