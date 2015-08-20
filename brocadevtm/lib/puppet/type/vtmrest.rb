Puppet::Type.newtype(:vtmrest) do

  desc <<-EOT
	Controls a Brocade vTM configuration via REST.

	If the object name exists then we will check that the JSON returned from
	the REST service matches the JSON provided in the content. The content
	is most likely going to come from a template.

	The object will be created if it does not exist.

   Example:

		vtmrest { 'pools/testpool':
			ensure => present,
			endpoint => 'https://vtm1:9070/api/tm/3.2/config/active',
			username => 'puppet',
			password => 'master',
			content => template ('stingray/pools.erb'),
			debug => 4
		}

	In this example, Puppet will ensure that the vTM configuration of 
	pools/testpool matches the configuration provided in the template. The default
   type of "application/json" will be used for the content

		vtmrest { 'rules/rateShaping':
			endpoint => 'https://vtm1:9070/api/tm/3.2/config/active',
			username => 'puppet',
			password => 'master',
			type => 'application/octet-stream',
			content => "rate.use('myClass', request.getRemoteIP());"
		}

	In this example we upload a rule and provide the content-type of 'application/octet-stream'
	The default debug level of 0 will be used.

	Custom types may be suesceptable to: https://tickets.puppetlabs.com/browse/PUP-1515

	EOT

	ensurable 

	newparam(:name, :namevar => true) do
		desc 'The name of the resource to check'
	end

	newparam(:endpoint) do
		desc 'The REST address of the vTM to which this configuration is applied.'
		validate do |value|
			unless ( value =~ /^https:\/\/.*?\/config\/active/ )
				raise(Puppet::Error, "The REST endpoint must be a https URI to the active configuration. Eg: 'https://vtm:9070/api/tm/3.2/config/active' not '#{value}'")
			end
		end
	end

	newparam(:username) do
		desc 'The user account to use for making REST calls to the vTM'
	end

	newparam(:password) do
		desc 'The password for making the REST calls to vTM'
	end

	newparam(:content) do
		desc 'The content to be compared against the REST service'
	end

	newparam(:type) do
		desc 'Option Content-Type for the object. Default is application/json'
	end

	newparam(:internal) do
		desc 'The internal resource name as known by the vTM Rest Controller'
	end

	newparam(:debug) do
		desc 'Optional debug level 0 to 5, 5 being most verbose. Default is 0.'
		validate do |value|
			if ( value.is_a? String ) 
				if( ! value =~ /^\d$/ )
					raise(Puppet::Error, "The debug level must be an integer between 0 and 5, not '#{value}'")
				end
				value = value.to_i
			end
			unless ( ( value >=0 ) and (value <=5) )
				raise(Puppet::Error, "The debug level must be an integer between 0 and 5, not '#{value}'")
			end
		end
	end 

	validate do
		unless self[:name] and self[:content] and self[:username] and self[:password] and self[:endpoint]
			raise(Puppet::Error, "The object name and all parameters (content,endpoint,username, and password) are mandatory")
		end
		if ( ! defined? self[:debug] )
			self[:debug] = 0
		end
		if ( ! defined? self[:type] )
			self[:type] = 'application/json'
		end
		if ( self[:type] == 'application/json' )
			unless ( self[:content] =~ /^\{.*\}$/ )
				raise(Puppet::Error, "Content: #{self[:content]}")
				raise(Puppet::Error, "The type is application/json, so the content must be a JSON string representing the configuration object")
			end
		end
	end

end
