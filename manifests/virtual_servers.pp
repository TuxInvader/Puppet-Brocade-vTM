# === Define: brocadevtm::virtual_servers
#
# Virtual Server
# The "conf/vservers" directory contains configuration files that define
# virtual servers.  The name of a file is the name of the virtual server it
# defines.  Virtual servers can be configured under the "Services > Virtual
# Servers" section of the Admin Server UI or by using functions under the
# "VirtualServer" section of the SOAP API and CLI.
#
# === Parameters
#
# [*basic__add_cluster_ip*]
# Whether or not the virtual server should add an "X-Cluster-Client-Ip" header
# to the request that contains the remote client's IP address.
#
# [*basic__add_x_forwarded_for*]
# Whether or not the virtual server should append the remote client's IP
# address to the X-Forwarded-For header. If the header does not exist, it will
# be added.
#
# [*basic__add_x_forwarded_proto*]
# Whether or not the virtual server should add an "X-Forwarded-Proto" header
# to the request that contains the original protocol used by the client to
# connect to the traffic manager.
#
# [*basic__bandwidth_class*]
# The bandwidth management class should this server should use, if any.
#
# [*basic__close_with_rst*]
# Whether or not connections from clients should be closed with a RST packet,
# rather than a FIN packet. This avoids the TIME_WAIT state, which on rare
# occasions allows wandering duplicate packets to be safely ignored.
#
# [*basic__completionrules*]
# Rules that are run at the end of a transaction, in order, comma separated.
# Type:array
# Properties:
#
# [*basic__connect_timeout*]
# The time, in seconds, to wait for data from a new connection.  If no data is
# received within this time, the connection will be closed.  A value of "0"
# (zero) will disable the timeout.
#
# [*basic__enabled*]
# Whether the virtual server is enabled.
#
# [*basic__ftp_force_server_secure*]
# Whether or not the virtual server should require that incoming FTP data
# connections from the nodes originate from the same IP address as the node.
#
# [*basic__glb_services*]
# The associated GLB services for this DNS virtual server.
# Type:array
# Properties:
#
# [*basic__listen_on_any*]
# Whether to listen on all IP addresses
#
# [*basic__listen_on_hosts*]
# Hostnames and IP addresses to listen on
# Type:array
# Properties:
#
# [*basic__listen_on_traffic_ips*]
# Traffic IP Groups to listen on
# Type:array
# Properties:
#
# [*basic__note*]
# A description for the virtual server.
#
# [*basic__pool*]
# The default pool to use for traffic.
#
# [*basic__port*]
# The port on which to listen for incoming connections.
#
# [*basic__protection_class*]
# The service protection class that should be used to protect this server, if
# any.
#
# [*basic__protocol*]
# The protocol that the virtual server is using.
#
# [*basic__request_rules*]
# Rules to be applied to incoming requests, in order, comma separated.
# Type:array
# Properties:
#
# [*basic__response_rules*]
# Rules to be applied to responses, in order, comma separated.
# Type:array
# Properties:
#
# [*basic__slm_class*]
# The service level monitoring class that this server should use, if any.
#
# [*basic__so_nagle*]
# Whether or not Nagle's algorithm should be used for TCP connections.
#
# [*basic__ssl_client_cert_headers*]
# What HTTP headers the virtual server should add to each request to show the
# data in the client certificate.
#
# [*basic__ssl_decrypt*]
# Whether or not the virtual server should decrypt incoming SSL traffic.
#
# [*basic__ssl_honor_fallback_scsv*]
# Whether or not the Fallback SCSV sent by TLS clients is honored by this
# virtual server. Choosing the global setting means the value of configuration
# key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!honor_fal
# lback_scsv"> "ssl!honor_fallback_scsv"</a> from the Global Settings section
# of the System tab will be enforced.
#
# [*aptimizer__enabled*]
# Whether the virtual server should aptimize web content.
#
# [*aptimizer__profile*]
# A table of Aptimizer profiles and the application scopes that apply to them.
# Type:array
# Properties:{"name"=>{"description"=>"The name of an Aptimizer acceleration
# profile.", "type"=>"string"}, "urls"=>{"description"=>"The application
# scopes which apply to the acceleration profile.", "type"=>"array",
# "uniqueItems"=>true, "items"=>{"type"=>"string"}}}
#
# [*connection__keepalive*]
# Whether or not the virtual server should use keepalive connections with the
# remote clients.
#
# [*connection__keepalive_timeout*]
# The length of time that the virtual server should keep an idle keepalive
# connection before discarding it.  A value of "0" (zero) will mean that the
# keepalives are never closed by the traffic manager.
#
# [*connection__max_client_buffer*]
# The amount of memory, in bytes, that the virtual server should use to store
# data sent by the client. Larger values will use more memory, but will
# minimise the number of "read()" and "write()" system calls that the traffic
# manager must perform.
#
# [*connection__max_server_buffer*]
# The amount of memory, in bytes, that the virtual server should use to store
# data returned by the server.  Larger values will use more memory, but will
# minimise the number of "read()" and "write()" system calls that the traffic
# manager must perform.
#
# [*connection__max_transaction_duration*]
# The total amount of time a transaction can take, counted from the first byte
# being received until the transaction is complete.  For HTTP, this can mean
# all data has been written in both directions, or the connection has been
# closed; in most other cases it is the same as the connection being
# closed.<br> The default value of "0" means there is no maximum duration,
# i.e., transactions can take arbitrarily long if none of the other timeouts
# occur.
#
# [*connection__server_first_banner*]
# If specified, the traffic manager will use the value as the banner to send
# for server-first protocols such as POP, SMTP and IMAP. This allows rules to
# use the first part of the client data (such as the username) to select a
# pool.
#
# [*connection__timeout*]
# A connection should be closed if no additional data has been received for
# this period of time.  A value of "0" (zero) will disable this timeout.
#
# [*connection_errors__error_file*]
# The error message to be sent to the client when the traffic manager detects
# an internal or backend error for the virtual server.
#
# [*cookie__domain*]
# The way in which the traffic manager should rewrite the domain portion of
# any cookies set by a back-end web server.
#
# [*cookie__new_domain*]
# The domain to use when rewriting a cookie's domain to a named value.
#
# [*cookie__path_regex*]
# If you wish to rewrite the path portion of any cookies set by a back-end web
# server, provide a regular expression to match the path:
#
# [*cookie__path_replace*]
# If cookie path regular expression matches, it will be replaced by this
# substitution.  Parameters $1-$9 can be used to represent bracketed parts of
# the regular expression.
#
# [*cookie__secure*]
# Whether or not the traffic manager should modify the "secure" tag of any
# cookies set by a back-end web server.
#
# [*dns__edns_udpsize*]
# EDNS UDP size advertised in responses.
#
# [*dns__max_udpsize*]
# Maximum UDP answer size.
#
# [*dns__verbose*]
# Whether or not the DNS Server should emit verbose logging. This is useful
# for diagnosing problems.
#
# [*dns__zones*]
# The DNS zones
# Type:array
# Properties:
#
# [*ftp__data_source_port*]
# The source port to be used for active-mode FTP data connections.  If 0, a
# random high port will be used, otherwise the specified port will be used. If
# a port below 1024 is required you must first explicitly permit use of low
# ports with the "data_bind_low" global setting.
#
# [*ftp__force_client_secure*]
# Whether or not the virtual server should require that incoming FTP data
# connections from the client originate from the same IP address as the
# corresponding client control connection.
#
# [*ftp__port_range_high*]
# If non-zero, then this controls the upper bound of the port range to use for
# FTP data connections.
#
# [*ftp__port_range_low*]
# If non-zero, then this controls the lower bound of the port range to use for
# FTP data connections.
#
# [*ftp__ssl_data*]
# Use SSL on the data connection as well as the control connection (if not
# enabled it is left to the client and server to negotiate this).
#
# [*gzip__compress_level*]
# Compression level (1-9, 1=low, 9=high).
#
# [*gzip__enabled*]
# Compress web pages sent back by the server.
#
# [*gzip__include_mime*]
# MIME types to compress. Complete MIME types can be used, or a type can end
# in a '*' to match multiple types.
# Type:array
# Properties:
#
# [*gzip__max_size*]
# Maximum document size to compress (0 means unlimited).
#
# [*gzip__min_size*]
# Minimum document size to compress.
#
# [*gzip__no_size*]
# Compress documents with no given size.
#
# [*http__chunk_overhead_forwarding*]
# Handling of HTTP chunk overhead.  When Stingray receives data from a server
# or client that consists purely of protocol overhead (contains no payload),
# forwarding of such segments is delayed until useful payload data arrives
# (setting "lazy").  Changing this key to "eager" will make Stingray incur the
# overhead of immediately passing such data on; it should only be used with
# HTTP peers whose chunk handling requires it.
#
# [*http__location_regex*]
# If the 'Location' header matches this regular expression, rewrite the header
# using the 'location_replace' pattern.
#
# [*http__location_replace*]
# If the 'Location' header matches the 'location_regex' regular expression,
# rewrite the header with this pattern (parameters such as $1-$9 can be used
# to match parts of the regular expression):
#
# [*http__location_rewrite*]
# The action the virtual server should take if the "Location" header does not
# match the "location_regex" regular expression.
#
# [*http__mime_default*]
# Auto-correct MIME types if the server sends the "default" MIME type for
# files.
#
# [*http__mime_detect*]
# Auto-detect MIME types if the server does not provide them.
#
# [*kerberos_protocol_transition__enabled*]
# Whether or not the virtual server should use Kerberos Protocol Transition.
#
# [*kerberos_protocol_transition__principal*]
# The Kerberos principal this virtual server should use to perform Kerberos
# Protocol Transition.
#
# [*kerberos_protocol_transition__target*]
# The Kerberos principal name of the service this virtual server targets.
#
# [*log__client_connection_failures*]
# Should the virtual server log failures occurring on connections to clients.
#
# [*log__enabled*]
# Whether or not to log connections to the virtual server to a disk on the
# file system.
#
# [*log__filename*]
# The name of the file in which to store the request logs. Appliances will
# ignore this. The filename can contain macros which will be expanded by the
# traffic manager to generate the full filename.
#
# [*log__format*]
# The log file format. This specifies the line of text that will be written to
# the log file when a connection to the traffic manager is completed.  Many
# parameters from the connection can be recorded using macros.
#
# [*log__save_all*]
# Whether to log all connections by default, or log no connections by default.
# Specific connections can be selected for addition to or exclusion from the
# log using the TrafficScript function "requestlog.include()".
#
# [*log__server_connection_failures*]
# Should the virtual server log failures occurring on connections to nodes.
#
# [*log__session_persistence_verbose*]
# Should the virtual server log session persistence events.
#
# [*log__ssl_failures*]
# Should the virtual server log failures occurring on SSL secure negotiation.
#
# [*recent_connections__enabled*]
# Whether or not connections handled by this virtual server should be shown on
# the Activity > Connections page.
#
# [*recent_connections__save_all*]
# Whether or not all connections handled by this virtual server should be
# shown on the Connections page. Individual connections can be selectively
# shown on the Connections page using the "recentconns.include()"
# TrafficScript function.
#
# [*request_tracing__enabled*]
# Record a trace of major connection processing events for each request and
# response.
#
# [*request_tracing__trace_io*]
# Include details of individual I/O events in request and response traces.
# Requires request tracing to be enabled.
#
# [*rtsp__streaming_port_range_high*]
# If non-zero this controls the upper bound of the port range to use for
# streaming data connections.
#
# [*rtsp__streaming_port_range_low*]
# If non-zero this controls the lower bound of the port range to use for
# streaming data connections.
#
# [*rtsp__streaming_timeout*]
# If non-zero data-streams associated with RTSP connections will timeout if no
# data is transmitted for this many seconds.
#
# [*sip__dangerous_requests*]
# The action to take when a SIP request with body data arrives that should be
# routed to an external IP.
#
# [*sip__follow_route*]
# Should the virtual server follow routing information contained in SIP
# requests. If set to "No" requests will be routed to the chosen back-end node
# regardless of their URI or Route header.
#
# [*sip__max_connection_mem*]
# SIP clients can have several pending requests at one time. To protect the
# traffic manager against DoS attacks, this setting limits the amount of
# memory each client can use.  When the limit is reached new requests will be
# sent a 413 response. If the value is set to "0" (zero) the memory limit is
# disabled.
#
# [*sip__mode*]
# The mode that this SIP virtual server should operate in.
#
# [*sip__rewrite_uri*]
# Replace the Request-URI of SIP requests with the address of the selected
# back-end node.
#
# [*sip__streaming_port_range_high*]
# If non-zero this controls the upper bound of the port range to use for
# streaming data connections.
#
# [*sip__streaming_port_range_low*]
# If non-zero, then this controls the lower bound of the port range to use for
# streaming data connections.
#
# [*sip__streaming_timeout*]
# If non-zero a UDP stream will timeout when no data has been seen within this
# time.
#
# [*sip__timeout_messages*]
# When timing out a SIP transaction, send a 'timed out' response to the client
# and, in the case of an INVITE transaction, a CANCEL request to the server.
#
# [*sip__transaction_timeout*]
# The virtual server should discard a SIP transaction when no further messages
# have been seen within this time.
#
# [*smtp__expect_starttls*]
# Whether or not the traffic manager should expect the connection to start off
# in plain text and then upgrade to SSL using STARTTLS when handling SMTP
# traffic.
#
# [*ssl__add_http_headers*]
# Whether or not the virtual server should add HTTP headers to each request to
# show the SSL connection parameters.
#
# [*ssl__client_cert_cas*]
# The certificate authorities that this virtual server should trust to
# validate client certificates. If no certificate authorities are selected,
# and client certificates are requested, then all client certificates will be
# accepted.
# Type:array
# Properties:
#
# [*ssl__issued_certs_never_expire*]
# When the virtual server verifies certificates signed by these certificate
# authorities, it doesn't check the 'not after' date, i.e., they are
# considered valid even after their expiration date has passed (but not if
# they have been revoked).
# Type:array
# Properties:
#
# [*ssl__ocsp_enable*]
# Whether or not the traffic manager should use OCSP to check the revocation
# status of client certificates.
#
# [*ssl__ocsp_issuers*]
# A table of certificate issuer specific OCSP settings.
# Type:array
# Properties:{"issuer"=>{"description"=>"The name of an issuer (or DEFAULT for
# default OCSP settings).", "type"=>"string"}, "aia"=>{"description"=>"Whether
# the traffic manager should use AIA information contained in a client
# certificate to determine which OCSP responder to contact.",
# "type"=>"boolean"}, "nonce"=>{"description"=>"How to use the OCSP nonce
# extension, which protects against OCSP replay attacks. Some OCSP servers do
# not support nonces.", "type"=>"string", "enum"=>["off", "on", "strict"]},
# "required"=>{"description"=>"Whether we should do an OCSP check for this
# issuer, and whether it is required or optional.", "type"=>"string",
# "enum"=>["none", "optional", "strict"]},
# "responder_cert"=>{"description"=>"The expected responder certificate.",
# "type"=>"string"}, "signer"=>{"description"=>"The certificate with which to
# sign the request, if any.", "type"=>"string"}, "url"=>{"description"=>"Which
# OCSP responders this virtual server should use to verify client
# certificates.", "type"=>"string"}}
#
# [*ssl__ocsp_max_response_age*]
# The number of seconds for which an OCSP response is considered valid if it
# has not yet exceeded the time specified in the 'nextUpdate' field. If set to
# "0" (zero) then OCSP responses are considered valid until the time specified
# in their 'nextUpdate' field.
#
# [*ssl__ocsp_stapling*]
# If OCSP URIs are present in certificates used by this virtual server, then
# enabling this option will allow the traffic manager to provide OCSP
# responses for these certificates as part of the handshake, if the client
# sends a TLS status_request extension in the ClientHello.
#
# [*ssl__ocsp_time_tolerance*]
# The number of seconds outside the permitted range for which the 'thisUpdate'
# and 'nextUpdate' fields of an OCSP response are still considered valid.
#
# [*ssl__ocsp_timeout*]
# The number of seconds after which OCSP requests will be timed out.
#
# [*ssl__prefer_sslv3*]
# Deprecated. Formerly allowed a preference for SSLv3 for performance reasons.
#
# [*ssl__request_client_cert*]
# Whether or not the virtual server should request an identifying SSL
# certificate from each client.
#
# [*ssl__send_close_alerts*]
# Whether or not to send an SSL/TLS "close alert" when the traffic manager is
# initiating an SSL socket disconnection.
#
# [*ssl__server_cert_default*]
# The default SSL certificate to use for this virtual server.
#
# [*ssl__server_cert_host_mapping*]
# Host specific SSL server certificate mappings.
# Type:array
# Properties:{"host"=>{"description"=>"Host which this entry refers to.",
# "type"=>"string"}, "certificate"=>{"description"=>"The SSL server
# certificate for a particular destination site IP.", "type"=>"string"}}
#
# [*ssl__signature_algorithms*]
# The SSL signature algorithms preference list for SSL connections to this
# virtual server using TLS version 1.2 or higher. Leaving this empty will make
# the virtual server use the globally configured preference list,
# "signature_algorithms" in the "ssl" section of the "global_settings"
# resource.  See there and in the online help for how to specify SSL signature
# algorithms.
#
# [*ssl__ssl_ciphers*]
# The SSL/TLS ciphers to allow for connections to this virtual server.
# Leaving this empty will make the virtual server use the globally configured
# ciphers, see configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!ssl3_ciph
# ers"> "ssl!ssl3_ciphers"</a> in the Global Settings section of the System
# tab.  See there for how to specify SSL/TLS ciphers.
#
# [*ssl__ssl_support_ssl2*]
# Whether or not SSLv2 is enabled for this virtual server.  Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_s
# sl2"> "ssl!support_ssl2"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__ssl_support_ssl3*]
# Whether or not SSLv3 is enabled for this virtual server.  Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_s
# sl3"> "ssl!support_ssl3"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__ssl_support_tls1*]
# Whether or not TLSv1.0 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1"> "ssl!support_tls1"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__ssl_support_tls1_1*]
# Whether or not TLSv1.1 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1.1"> "ssl!support_tls1.1"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*ssl__ssl_support_tls1_2*]
# Whether or not TLSv1.2 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1.2"> "ssl!support_tls1.2"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*ssl__trust_magic*]
# If the traffic manager is receiving traffic sent from another traffic
# manager, then enabling this option will allow it to decode extra information
# on the true origin of the SSL connection. This information is supplied by
# the first traffic manager.
#
# [*syslog__enabled*]
# Whether or not to log connections to the virtual server to a remote syslog
# host.
#
# [*syslog__format*]
# The log format for the remote syslog.  This specifies the line of text that
# will be sent to the remote syslog  when a connection to the traffic manager
# is completed. Many parameters from the connection can be recorded using
# macros.
#
# [*syslog__ip_end_point*]
# The remote host and port (default is 514) to send request log lines to.
#
# [*syslog__msg_len_limit*]
# Maximum length in bytes of a message sent to the remote syslog. Messages
# longer than this will be truncated before they are sent.
#
# [*tcp__proxy_close*]
# If set to "Yes" the traffic manager will send the client FIN to the back-end
# server and wait for a server response instead of closing the connection
# immediately.  This is only necessary for protocols that require half-close
# support to function correctly, such as "rsh".  If the traffic manager is
# responding to the request itself, setting this key to Yes will cause the
# traffic manager to continue writing the response even after it has received
# a FIN from the client.
#
# [*udp__end_point_persistence*]
# Whether or not UDP datagrams from the same IP and port are sent to the same
# node in the pool if there's an existing UDP transaction. Although it's not
# always guaranteed as while making a decision to reuse the same node, traffic
# manager can also apply other protocol specific filtering e.g CallID matching
# for SIP packets in addition to IP and port matching.
#
# [*udp__port_smp*]
# Whether or not UDP datagrams should be distributed across all traffic
# manager processes. This setting is not recommended if the traffic manager
# will be handling connection-based UDP protocols.
#
# [*udp__response_datagrams_expected*]
# The virtual server should discard any UDP connection and reclaim resources
# when the node has responded with this number of datagrams.  For simple
# request/response protocols this can be often set to "1".  If set to "-1",
# the connection will not be discarded until the "timeout" is reached.
#
# [*udp__timeout*]
# The virtual server should discard any UDP connection and reclaim resources
# when no further UDP traffic has been seen within this time.
#
# [*web_cache__control_out*]
# The "Cache-Control" header to add to every cached HTTP response, "no-cache"
# or "max-age=600" for example.
#
# [*web_cache__enabled*]
# If set to "Yes" the traffic manager will attempt to cache web server
# responses.
#
# [*web_cache__error_page_time*]
# Time period to cache error pages for.
#
# [*web_cache__max_time*]
# Maximum time period to cache web pages for.
#
# [*web_cache__refresh_time*]
# If a cached page is about to expire within this time, the traffic manager
# will start to forward some new requests on to the web servers. A maximum of
# one request per second will be forwarded; the remainder will continue to be
# served from the cache. This prevents "bursts" of traffic to your web servers
# when an item expires from the cache. Setting this value to "0" will stop the
# traffic manager updating the cache before it expires.
#
# === Examples
#
# brocadevtm::virtual_servers { 'example':
#     ensure => present,
#     basic__pool => 'foo'
#     basic__port => 8888
# }
#
#
# === Authors
#
# Mark Boddington <mbodding@brocade>
#
# === Copyright
#
# Copyright 2015 Brocade
#
define brocadevtm::virtual_servers (
  $ensure,
  $basic__pool,
  $basic__port,
  $basic__add_cluster_ip                   = true,
  $basic__add_x_forwarded_for              = false,
  $basic__add_x_forwarded_proto            = false,
  $basic__bandwidth_class                  = undef,
  $basic__close_with_rst                   = false,
  $basic__completionrules                  = '[]',
  $basic__connect_timeout                  = 10,
  $basic__enabled                          = false,
  $basic__ftp_force_server_secure          = true,
  $basic__glb_services                     = '[]',
  $basic__listen_on_any                    = true,
  $basic__listen_on_hosts                  = '[]',
  $basic__listen_on_traffic_ips            = '[]',
  $basic__note                             = undef,
  $basic__protection_class                 = undef,
  $basic__protocol                         = 'http',
  $basic__request_rules                    = '[]',
  $basic__response_rules                   = '[]',
  $basic__slm_class                        = undef,
  $basic__so_nagle                         = false,
  $basic__ssl_client_cert_headers          = 'none',
  $basic__ssl_decrypt                      = false,
  $basic__ssl_honor_fallback_scsv          = 'use_default',
  $aptimizer__enabled                      = false,
  $aptimizer__profile                      = '[]',
  $connection__keepalive                   = true,
  $connection__keepalive_timeout           = 10,
  $connection__max_client_buffer           = 65536,
  $connection__max_server_buffer           = 65536,
  $connection__max_transaction_duration    = 0,
  $connection__server_first_banner         = undef,
  $connection__timeout                     = 300,
  $connection_errors__error_file           = 'Default',
  $cookie__domain                          = 'no_rewrite',
  $cookie__new_domain                      = undef,
  $cookie__path_regex                      = undef,
  $cookie__path_replace                    = undef,
  $cookie__secure                          = 'no_modify',
  $dns__edns_udpsize                       = 4096,
  $dns__max_udpsize                        = 4096,
  $dns__verbose                            = false,
  $dns__zones                              = '[]',
  $ftp__data_source_port                   = 0,
  $ftp__force_client_secure                = true,
  $ftp__port_range_high                    = 0,
  $ftp__port_range_low                     = 0,
  $ftp__ssl_data                           = true,
  $gzip__compress_level                    = 1,
  $gzip__enabled                           = false,
  $gzip__include_mime                      = '["text/html","text/plain"]',
  $gzip__max_size                          = 10000000,
  $gzip__min_size                          = 1000,
  $gzip__no_size                           = true,
  $http__chunk_overhead_forwarding         = 'lazy',
  $http__location_regex                    = undef,
  $http__location_replace                  = undef,
  $http__location_rewrite                  = 'if_host_matches',
  $http__mime_default                      = 'text/plain',
  $http__mime_detect                       = false,
  $kerberos_protocol_transition__enabled   = false,
  $kerberos_protocol_transition__principal = undef,
  $kerberos_protocol_transition__target    = undef,
  $log__client_connection_failures         = false,
  $log__enabled                            = false,
  $log__filename                           = '%zeushome%/zxtm/log/%v.log',
  $log__format                             = '%h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"',
  $log__save_all                           = true,
  $log__server_connection_failures         = false,
  $log__session_persistence_verbose        = false,
  $log__ssl_failures                       = false,
  $recent_connections__enabled             = true,
  $recent_connections__save_all            = false,
  $request_tracing__enabled                = false,
  $request_tracing__trace_io               = false,
  $rtsp__streaming_port_range_high         = 0,
  $rtsp__streaming_port_range_low          = 0,
  $rtsp__streaming_timeout                 = 30,
  $sip__dangerous_requests                 = 'node',
  $sip__follow_route                       = true,
  $sip__max_connection_mem                 = 65536,
  $sip__mode                               = 'sip_gateway',
  $sip__rewrite_uri                        = false,
  $sip__streaming_port_range_high          = 0,
  $sip__streaming_port_range_low           = 0,
  $sip__streaming_timeout                  = 60,
  $sip__timeout_messages                   = true,
  $sip__transaction_timeout                = 30,
  $smtp__expect_starttls                   = true,
  $ssl__add_http_headers                   = false,
  $ssl__client_cert_cas                    = '[]',
  $ssl__issued_certs_never_expire          = '[]',
  $ssl__ocsp_enable                        = false,
  $ssl__ocsp_issuers                       = '[]',
  $ssl__ocsp_max_response_age              = 0,
  $ssl__ocsp_stapling                      = false,
  $ssl__ocsp_time_tolerance                = 30,
  $ssl__ocsp_timeout                       = 10,
  $ssl__prefer_sslv3                       = false,
  $ssl__request_client_cert                = 'dont_request',
  $ssl__send_close_alerts                  = true,
  $ssl__server_cert_default                = undef,
  $ssl__server_cert_host_mapping           = '[]',
  $ssl__signature_algorithms               = undef,
  $ssl__ssl_ciphers                        = undef,
  $ssl__ssl_support_ssl2                   = 'use_default',
  $ssl__ssl_support_ssl3                   = 'use_default',
  $ssl__ssl_support_tls1                   = 'use_default',
  $ssl__ssl_support_tls1_1                 = 'use_default',
  $ssl__ssl_support_tls1_2                 = 'use_default',
  $ssl__trust_magic                        = false,
  $syslog__enabled                         = false,
  $syslog__format                          = '%h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"',
  $syslog__ip_end_point                    = undef,
  $syslog__msg_len_limit                   = 1024,
  $tcp__proxy_close                        = false,
  $udp__end_point_persistence              = true,
  $udp__port_smp                           = false,
  $udp__response_datagrams_expected        = 1,
  $udp__timeout                            = 7,
  $web_cache__control_out                  = undef,
  $web_cache__enabled                      = false,
  $web_cache__error_page_time              = 30,
  $web_cache__max_time                     = 600,
  $web_cache__refresh_time                 = 2,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring virtual_servers ${name}")
  vtmrest { "virtual_servers/${name}":
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/virtual_servers.erb'),
    type     => 'application/json',
    internal => 'virtual_servers',
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/virtual_servers", {ensure => present})
    file_line { "virtual_servers/${name}":
      line => "virtual_servers/${name}",
      path => "${purge_state_dir}/virtual_servers",
    }
  }
}