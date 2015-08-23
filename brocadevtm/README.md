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

## Installation 

    puppet module install tuxinvader/brocadevtm

## Usage

Simple web service example. Uses a single VIP with two virtual servers:
HTTP and HTTPS. The HTTPS service does SSL offload, and both use the
same server pool.

    class { 'brocadevtm':
       rest_user   => 'puppet', 
       rest_pass   => 'master',
       rest_ip     => '10.1.1.22',
    }
    
    include brocadevtm::global_settings

    brocadevtm::traffic_ip_groups { 'Web%20VIP':
       ensure             => present,
       basic__enabled     => true,
       basic__ipaddresses => ["10.1.1.10"],
       basic__machines    => ["vtm1.internal.local"],
    }

    brocadevtm::virtual_servers { 'WebService':
       ensure                       => present,
       basic__enabled               => true,
       basic__listen_on_any         => false,
       basic__listen_on_traffic_ips => ["Web VIP"],
       basic__pool                  => "WebPool",
       basic__port                  => 80,
    }
    
    brocadevtm::virtual_servers { 'WebService%20SSL':
       ensure                       => present,
       basic__enabled               => true,
       basic__listen_on_any         => false,
       basic__listen_on_traffic_ips => ["Web VIP"],
       basic__pool                  => "WebPool",
       basic__port                  => 443,
       basic__ssl_decrypt           => true,
       ssl__server_cert_default     => 'TEST-CERT',
    }

    brocadevtm::pools { 'WebPool':
       ensure             => present,
       basic__nodes_table => '[{"node":"10.1.1.1:80","priority":1,"state":"active","weight":1}]',
    }
    
    
    brocadevtm::ssl_server_keys { 'TEST-CERT': 
       ensure         => present,
       basic__note    => '',
       basic__private => '-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAsiZD53KCrcN3r4yAW6GwkITYEQyzg1bbDP8fiRvaWJxOgRtE\n/8E4KRDdeqOCuV1YNuLaTsfCkF34T4pvI00wZ5lSdXBnVrEie49ip7z0QNQ/W4mv\nDzkDQ/Och1lRevflAhJUfgiVizCxDbxJfR6oSip3RAeGarBIhp7TlfLKQj7YdnIy\nFROcHIMkLZ7aq7tUzVvcGonz5YXrmDDKFoGvbaJnNC0SAiM0aJIomOlexQmL4cgI\nhQQ1YlrF9hnulSbZN20zNz8fSeJ1UmyUgrYqLgzLXUb54pqK1aGg4rQNIqwoAbyq\nibqzc2rO/o6MXgEb9zzFwAyHI38nptE7OdiC+wIDAQABAoIBAEk98iz1p0RJWKuT\n2DHUCANimnJoBmW5D9YIDa8RBHPpz1zFGVkM10oK5QPGtbf/6ISoP5ikCBnSiIQr\nJgYddgkhwAUIcXPy33ptOOI9jS4aFPJNaOuZRP5q6a+7yQQFZuGzJ4mpfdH78s7y\n2kPWltnnG6GcdmbmkurF4beEWiNhgsex2hLhhj20oVUaGF1BGMdrp20vYE496B52\n4Wuax9lfFoFuv8FAz96EZQOQS6J1Wf+o0qqZYNDaBRI5wi3EjrNpcEHhELp9eHeG\nnFwDgQD15HyK2Qio4ig3T386OTUGT/FCNMxqT3wDn4ov+kTFtDoI+2qvJ/l6vULv\n20f50AECgYEA6f7K1jVb7nNLwUjPld0azXbQgE3mdlwJVI8urz80JLQwKckg53tP\ngol8NaZOxo7gQlML/5ltK/y5cW6B2JhxjFtNoAAzNNBmGTRvLpLK3HHGEfVRVexZ\n8ZmssEzG49Xk6l1A7O+UWgqFUMlLBcYFKEvvGS8efcXBLwOV7G3EXxsCgYEAwucK\nJ4jN8ECtDuMHY0sKbbfLXpqPS7KMfdWio1SaR1ctEos5wrKaX3vG3Zbiz6weYCko\ntNI9ioQVQ7D0Uc+lhhhlxeHAVnNFJhpZowYdf44mI/LCW2pga3dOZ9vDRqWP29KG\nUwzH1RfXPtZBqMC5vPHd42kAGgGXwBvPZChOSaECgYEAiNjyV4StVy8mxsuGW+cL\nnc428lKczevVqRZz/xm/rReUc1ulWrvLLFSrx9STjZxRm3hmM/3O00LiUWyHk9zT\ny3o6U7DKQcD/dQ4tV9eRvIrtg+MsxkuL7rgpPpIoX2bgkhAnwGn9IQu2HCEdNysw\nKPj/xILCGlxlNtGqBLPNfLECgYEAlYqHtAW3XRuCrOVsibbN7ZkTpSaZw87fFL2R\n6BfFt+8fWhcQ3l4DLDfgQay/oe/B7q4l2XdmWJ03Y5SmIQ9dRSH7FHU+Chave6jE\nFd1fTLtYcESW82UPTeVgdzebAN2PH27MOXSY7ts3/7KM9lnJKTu6r/2kYk/Oi0vL\nOGHkj4ECgYBaxw/qFIMWAvi8r84cbUG/PYivHeJNJ53EhXE6UZPxi6QuVhlbitri\nHk6SP443RCdjAR9IiZoDQkl+yW0z86ZShJYXF+1JFQU+ftsRzCtfx2XLD5dQO5qn\nleXIH8z/4lUuPMyBw5bGj9eRXat7/SI2W6cuksMHLIMBiAognmdvRw==\n-----END RSA PRIVATE KEY-----\n',
       basic__public  => '-----BEGIN CERTIFICATE-----\nMIIDFjCCAf4CCQD4M1+rCABUDjANBgkqhkiG9w0BAQsFADBNMQswCQYDVQQGEwJH\nQjESMBAGA1UEBxMJQ2FtYnJpZGdlMRAwDgYDVQQKEwdCcm9jYWRlMRgwFgYDVQQD\nEw93d3cuYnJvY2FkZS5jb20wHhcNMTUwODIwMTQ1MzQ3WhcNMTYwODE5MTQ1MzQ3\nWjBNMQswCQYDVQQGEwJHQjESMBAGA1UEBxMJQ2FtYnJpZGdlMRAwDgYDVQQKEwdC\ncm9jYWRlMRgwFgYDVQQDEw93d3cuYnJvY2FkZS5jb20wggEiMA0GCSqGSIb3DQEB\nAQUAA4IBDwAwggEKAoIBAQCyJkPncoKtw3evjIBbobCQhNgRDLODVtsM/x+JG9pY\nnE6BG0T/wTgpEN16o4K5XVg24tpOx8KQXfhPim8jTTBnmVJ1cGdWsSJ7j2KnvPRA\n1D9bia8POQND85yHWVF69+UCElR+CJWLMLENvEl9HqhKKndEB4ZqsEiGntOV8spC\nPth2cjIVE5wcgyQtntqru1TNW9waifPlheuYMMoWga9tomc0LRICIzRokiiY6V7F\nCYvhyAiFBDViWsX2Ge6VJtk3bTM3Px9J4nVSbJSCtiouDMtdRvnimorVoaDitA0i\nrCgBvKqJurNzas7+joxeARv3PMXADIcjfyem0Ts52IL7AgMBAAEwDQYJKoZIhvcN\nAQELBQADggEBAJcuRIh3ngpFz0nHym5z56tbzHBrjF3frwp75Nknz3kuyCjdG7Nr\nPF5WvDl7lb1WX9EgAn/vJznYCmMxbjnUhHTMIMWbyIoTKJIIHCsrDyiK21NoI3nY\nu/9V1TADGdkqGSag00UqygF4nVkbvKJcjXHq9t0zz56xAvCamBvlNCkJ0/mQN3Qd\n5r/HgiRX69MSG1RRAFB+rkZInGekedLumBYCuALFCY5SB1+ns9XtGGJGRMh74oUp\ngjE62k/mEGPhLaXGJRupY07ezQKJOMBLRN1+HzIETsdH68FDdowFLzcH8fOn9HIg\nCuhlcpfk5VfCaeIqdqYEsrxY+KADA8ss06M=\n-----END CERTIFICATE-----\n',
       basic__request => '-----BEGIN NEW CERTIFICATE REQUEST-----\nMIICkjCCAXoCAQAwTTELMAkGA1UEBhMCR0IxEjAQBgNVBAcTCUNhbWJyaWRnZTEQ\nMA4GA1UEChMHQnJvY2FkZTEYMBYGA1UEAxMPd3d3LmJyb2NhZGUuY29tMIIBIjAN\nBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsiZD53KCrcN3r4yAW6GwkITYEQyz\ng1bbDP8fiRvaWJxOgRtE/8E4KRDdeqOCuV1YNuLaTsfCkF34T4pvI00wZ5lSdXBn\nVrEie49ip7z0QNQ/W4mvDzkDQ/Och1lRevflAhJUfgiVizCxDbxJfR6oSip3RAeG\narBIhp7TlfLKQj7YdnIyFROcHIMkLZ7aq7tUzVvcGonz5YXrmDDKFoGvbaJnNC0S\nAiM0aJIomOlexQmL4cgIhQQ1YlrF9hnulSbZN20zNz8fSeJ1UmyUgrYqLgzLXUb5\n4pqK1aGg4rQNIqwoAbyqibqzc2rO/o6MXgEb9zzFwAyHI38nptE7OdiC+wIDAQAB\noAAwDQYJKoZIhvcNAQELBQADggEBAGnf+2VPIY8zW6IE2htseeLHxH5SlNc6GJsI\nkGmc9WG72yV97EakpzwsIgsz06QXwCh+HloNUPZQAQ9KcUFhskLXxLE7PYXKnPLr\nMMAvA7aqCGPhb3/p738tT+G9IKUQfkbYmvY4ROIk56XzWT0ufVTw11jrIglQXo+g\nWdJt2MbNC6f/1+NVL85q9pRBvFSeBk7D43U/B+KkM/7wmB+5fMB6DJfRAHCvjOEI\nX56MyO4UJXsvs9jriDHLoqpAu3IkV1oxGzdaE/dRveqq21q1hz5S2PaOU5jPzetH\nAra3APjd55zS5EGex8t82ZJbI3aru2lPl6ztfErSWQLGNrxbVlE=\n-----END NEW CERTIFICATE REQUEST-----\n',
    }

## Tools

The bin directory contains the tools which are used to generate the manifest
files for this module.

`cleanup` - removes the current manifests and supporting files
`updateDocs` - generates docuementation for use in the manifests
`genManifests` - generates the manifests themselves.

You can upgrade or downgrade to any version of the API by using these tools.
For example, to upgrade to REST API version 3.5 you could run

    ./bin/cleanup -d
    ./bin/updateDocs -d zxtm10.1/3.5
    ./bin/genManifests -v 3.5 -h <clean vtm host> -U admin -P password -d 1

I recommend that you run genManifests against a freshly built/clean vTM host,
unless you explicitly want to include some of your configuration as default
manifests.

## Tools (cleanup)

Delete the files in manifests, templates, files, and optionally skel/docs,
and then copy in the initial configuration from the skel folder.

Usage:

	./bin/cleanup -d

The initial configuration only contains init.pp, you will need to execute
genManifests after running cleanup

## Tools (updateDocs)

You will need to have a copy of the REST schemas available to use this.
The schemas can be found in $ZEUSHOME/zxtm/etc of any 10.0 and newer version
of vTM. Extract the schemas into a folder and then point the tool at them.

Usage:

    ./bin/updateDocs -d zxtm-10.1/3.3

Where zxtm-10.1 is the root of the schema tree, and 3.3 is the api version.

updateDocs places a markdown file for each REST schema in the skel/docs
folder. The genManifests tool will look in this folder as it builds
manifests, so you should ensure you use the same API version in both.

## Tools (genManifests)

I only wrote the init.pp manifest myself, the rest are generate by a ruby
script. The script walks the vTM REST API and then writes the manifests.

The version of manifests included by default are for REST Version 3.3. I chose
this version because it is the most up-to-date version included with vTM
release 9.9, which is the current LTS (Long-Term-Supported) release.

If you are running an older version than 9.9, then you should probably 
upgrade.

The ruby tool which generates the manifests is included and can be 
found in bin/genManifests.

If you want to use puppet to manage an older version than 9.9 (ie an
older version of the API), then genManifests can help.

All versions of the vTM released since 9.9 still have support for API
version 3.3, but if you wish to make use of newer API calls or features
then you can regenerate your manifests using this tool.

Usage:

	./bin/genManifests -h <vTM Host> -v <API Version> -U <User> -P <Pass> -d <debug level>

The tool generates manifests by walking the API. Any types it finds (eg 
Virtual Servers, Pools, Monitors) get defined types createdi, so that you
can deploy instances of those types. Any configuration it finds will be
used to generate Classes. For example the Default Monitors are created as
classes, so you can simply `include brocadevtm::moinitors_simple_http`.

This has the nice side affect that it can also generate classes for any
default configuration that you want included. For example, you could have 
a custom class for your FLA key created by simply uploading the FLA key
prior to running genManifests. Then `include brocadevtm::licenses_myfla`


