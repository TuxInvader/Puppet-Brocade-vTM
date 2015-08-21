# Brocade vTM ( Virtual Traffic Manager ) module for Puppet

This is a puppet module for configuring the Brocade vTM - formerly:
	
	Zeus Load Balancer
	Zeus eXtensinle Traffic Manager (ZXTM)
	Zeus Traffic Manager

	Riverbed Stingray
	Riverbed SteelApp

This module does not envolve itself with the deployment of the vTM. 
There are many ways for you to automate the deployment of the
vTM depending where it is running... Including:

	Cloud APIs (Amazon, RackSpace, Joyent, etc, etc)
	Docker modules (if you use docker)
	puppetlabs-vsphere (if you run ESXi)
	cloud-init (Openstack and others)
	./zinstall --replay-from= on generic Linux

Once you have your vTM stood up. This module can help you manage the
configuration of that vTM instance.

## Usage

## Tools (genManifests)

I didn't write any manifests myself, I wrote a ruby script to walk 
the vTM REST API and to then write the manifests for me. The version 
of manifests included by default are for REST Version 3.3. I chose this
version because it is the most up-to-date version included with vTM 
release 9.9 (which is the current Long-Term-Support release).

If you are running an older version than 9.9, then you should probably 
upgrade. 

The ruby tool which generates the manifests is included and can be 
found in bin/genManifests.

If you want to use puppet to manage an older version than 9.9 (ie an
older version of the API), then genManifests can help.

All versions of the vTM released since 9.9 still have support for API
version 3.3, but if you wish to make use of newer API calls or features
then you can regenerate your manifests using this tool.

The tool generates manifests by walking the API. Any types it finds (eg 
Virtual Servers, Pools, Monitors) get defined types created so that you
can deploy instances of those types. Any configuration it finds will be
used to generate Classes. For example the Default Monitors are created as
classes, so you can simply "include brocadevtm::Moinitors_Simple%20HTTP".

This has a nice side affect in that it can also generate classes for any
default configuration that you want included. For example, you can have 
custom class for your FLA key created by simply uploading the FLA key
prior to running genManifests.

	./bin/genManifests -h <vTM Host> -v <API Version> -U <User> -P <Pass> -d <debug level>

## Tools (cleanup)

Delete the files in manifests, templates, and files, and then copy in the
initial configuration from the skel folder.

	./bin/cleanup

The initial configuration contains only contains init.pp, you will need
to execute genManifests after running cleanup

