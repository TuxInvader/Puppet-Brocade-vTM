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
# [*basic__bandwidth_class*]
# The bandwidth management class that this server should use, if any.
#
# [*basic__completion_rules*]
# Rules that are run at the end of a transaction, in order, comma separated.
# Type:array
# Properties:
#
# [*basic__connect_timeout*]
# The time, in seconds, for which an established connection can remain idle
# waiting for some initial data to be received from the client. The initial
# data is defined as a complete set of request headers for HTTP, SIP and RTSP
# services, or the first byte of data for all other services. A value of "0"
# will disable the timeout.
#
# [*basic__enabled*]
# Whether the virtual server is enabled.
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
# [*basic__max_concurrent_connections*]
# The maximum number of concurrent TCP connections that will be handled by
# this virtual server. If set to a non-zero value, the traffic manager will
# limit the number of concurrent TCP connections that this virtual server will
# accept to the value specified. When the limit is reached, new connections to
# this virtual server will not be accepted. If set to "0" the number of
# concurrent TCP connections will not be limited.
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
# [*basic__proxy_protocol*]
# Expect connections to the traffic manager to be prefixed with a PROXY
# protocol header. If enabled, the information contained in the PROXY header
# will be available in TrafficScript. Connections that are not prefixed with a
# valid PROXY protocol header will be discarded.
#
# [*basic__proxy_protocol_optional*]
# Connections which do not include a PROXY protocol header are not rejected,
# but are treated as ordinary non-PROXY protocol connections.
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
# [*basic__rules_on_connect*]
# Only applicable for Client First Generic Protocol. Allows Virtual Traffic
# Manager to execute rules on a client connects without waiting for data from
# the client.
#
# [*basic__slm_class*]
# The service level monitoring class that this server should use, if any.
#
# [*basic__ssl_decrypt*]
# Whether or not the virtual server should decrypt incoming SSL traffic.
#
# [*basic__transparent*]
# Whether or not bound sockets should be configured for transparent proxying.
#
# [*aptimizer__enabled*]
# Whether the virtual server should optimize web content.
#
# [*aptimizer__profile*]
# A table of Aptimizer profiles and the application scopes that apply to them.
# Type:array
# Properties:{"name"=>{"description"=>"The name of an Aptimizer acceleration
# profile.", "type"=>"string"}, "urls"=>{"description"=>"The application
# scopes which apply to the acceleration profile.", "type"=>"array",
# "uniqueItems"=>true, "items"=>{"type"=>"string"}}}
#
# [*auth__saml_idp*]
# Name of the Trusted Identity Provider configuration to use. To create
# Identity Providers, please visit section <a
# href="?section=SAML%3aTrusted%20Identity%20Providers">Trusted Identity
# Providers</a>
#
# [*auth__saml_nameid_format*]
# The NameID format to request and expect from the identity provider.
#
# [*auth__saml_sp_acs_url*]
# The 'Assertion Consumer Service' endpoint for the SAML service provider on
# this virtual server, ie the endpoint to which the identity provider will
# cause the user agent to send SAML assertions. This should be an HTTPS URL,
# must be in the same cookie domain as all hostnames used by the end user to
# access the virtual server (see cookie configuration) and the port must be
# the port on which this virtual server is listening. It must match the URI
# placed by the identity provider in the 'Recipient' attribute in the SAML
# assertion, if present.
#
# [*auth__saml_sp_entity_id*]
# The entity ID to be used by the SAML service provider function on this
# virtual server. This should usually be a URL, or a URN, however it may be
# any string. It must match the entity ID placed  by the identity provider in
# the 'Audience' field in the SAML assertion.
#
# [*auth__saml_time_tolerance*]
# Time tolerance on authentication checks. When checking time-stamps and
# expiry dates against the current time on the system, allow a tolerance of
# this many seconds. For example, if a SAML response contains a 'NotOnOrAfter'
# that is 4 seconds in the past according to the local time, and the tolerance
# is set to 5 seconds, it will still be accepted. This is to prevent a lack of
# clock synchronization from resulting in rejection of SAML responses.
#
# [*auth__session_cookie_attributes*]
# Attributes of cookie used for authentication session.
#
# [*auth__session_cookie_name*]
# Name of cookie used for authentication session.
#
# [*auth__session_log_external_state*]
# Whether or not to include state of authentication sessions stored encrypted
# on the client as plaintext in the logs.
#
# [*auth__session_timeout*]
# Timeout on authentication session.
#
# [*auth__type*]
# Type of authentication to apply to requests to the virtual server.
#
# [*auth__verbose*]
# Whether or not detailed messages about virtual server authentication should
# be written to the error log.
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
# for server-first protocols such as FTP, POP, SMTP and IMAP. This allows
# rules to use the first part of the client data (such as the username) to
# select a pool. The banner should be in the correct format for the protocol,
# e.g. for FTP it should start with "220 "
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
# [*dns__edns_client_subnet*]
# Enable/Disable use of EDNS client subnet option
#
# [*dns__edns_udpsize*]
# EDNS UDP size advertised in responses.
#
# [*dns__max_udpsize*]
# Maximum UDP answer size.
#
# [*dns__rrset_order*]
# Response record ordering.
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
# [*ftp__force_server_secure*]
# Whether or not the virtual server should require that incoming FTP data
# connections from the nodes originate from the same IP address as the node.
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
# [*gzip__chunk*]
# Use HTTP chunking to deliver data to the client. If this is turned off, we
# won't use chunking when gzipping server data. This would mean that the
# response couldn't be kept-alive.
#
# [*gzip__compress_level*]
# Compression level (1-9, 1=low, 9=high).
#
# [*gzip__enabled*]
# Compress web pages sent back by the server.
#
# [*gzip__etag_rewrite*]
# How the ETag header should be manipulated when compressing content.
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
# [*http__add_cluster_ip*]
# Whether or not the virtual server should add an "X-Cluster-Client-Ip" header
# to the request that contains the remote client's IP address.
#
# [*http__add_x_forwarded_for*]
# Whether or not the virtual server should append the remote client's IP
# address to the X-Forwarded-For header. If the header does not exist, it will
# be added.
#
# [*http__add_x_forwarded_proto*]
# Whether or not the virtual server should add an "X-Forwarded-Proto" header
# to the request that contains the original protocol used by the client to
# connect to the traffic manager.
#
# [*http__auto_upgrade_protocols*]
# A case-insensitive list of HTTP "Upgrade" header values that will trigger
# the HTTP connection upgrade auto-detection.
# Type:array
# Properties:
#
# [*http__autodetect_upgrade_headers*]
# Whether the traffic manager should check for HTTP responses that confirm an
# HTTP connection is transitioning to the WebSockets protocol.  If that such a
# response is detected, the traffic manager will cease any protocol-specific
# processing on the connection and just pass incoming data to the
# client/server as appropriate.
#
# [*http__chunk_overhead_forwarding*]
# Handling of HTTP chunk overhead.  When vTM receives data from a server or
# client that consists purely of protocol overhead (contains no payload),
# forwarding of such segments is delayed until useful payload data arrives
# (setting "lazy").  Changing this key to "eager" will make vTM incur the
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
# [*http__strip_x_forwarded_proto*]
# Whether or not the virtual server should strip the 'X-Forwarded-Proto'
# header from incoming requests.
#
# [*http2__connect_timeout*]
# The time, in seconds, to wait for a request on a new HTTP/2 connection.  If
# no request is received within this time, the connection will be closed. This
# setting overrides the "connect_timeout" setting. If set to "0" (zero), the
# value of "connect_timeout" will be used instead.
#
# [*http2__data_frame_size*]
# This setting controls the preferred frame size used when sending body data
# to the client. If the client specifies a smaller maximum size than this
# setting, the client's maximum size will be used. Every data frame sent has
# at least a 9-byte header, in addition to this frame size, prepended to it.
#
# [*http2__enabled*]
# This setting allows the HTTP/2 protocol to be used by a HTTP virtual server.
# Unless use of HTTP/2 is negotiated by the client, the virtual server will
# fall back to HTTP 1.x automatically.
#
# [*http2__header_table_size*]
# This setting controls the amount of memory allowed for header compression on
# each HTTP/2 connection.
#
# [*http2__headers_index_blacklist*]
# A list of header names that should never be compressed using indexing.
# Type:array
# Properties:
#
# [*http2__headers_index_default*]
# The HTTP/2 HPACK compression scheme allows for HTTP headers to be compressed
# using indexing. Sensitive headers can be marked as "never index", which
# prevents them from being compressed using indexing. When this setting is
# "Yes", only headers included in "http2!headers_index_blacklist" are marked
# as "never index". When this setting is "No", all headers will be marked as
# "never index" unless they are included in "http2!headers_index_whitelist".
#
# [*http2__headers_index_whitelist*]
# A list of header names that can be compressed using indexing when the value
# of "http2!headers_index_default" is set to "No".
# Type:array
# Properties:
#
# [*http2__headers_size_limit*]
# The maximum size, in bytes, of decompressed headers for an HTTP/2 request.
# If the limit is exceeded, the connection on which the request was sent will
# be dropped. A value of 0 disables the limit check. If a service protection
# class with "http!max_header_length" configured is associated with this
# service then that setting will take precedence.
#
# [*http2__idle_timeout_no_streams*]
# The time, in seconds, to wait for a new HTTP/2 request on a previously used
# HTTP/2 connection that has no open HTTP/2 streams. If an HTTP/2 request is
# not received within this time, the connection will be closed. A value of "0"
# (zero) will disable the timeout.
#
# [*http2__idle_timeout_open_streams*]
# The time, in seconds, to wait for data on an idle HTTP/2 connection, which
# has open streams, when no data has been sent recently (e.g. for long-polled
# requests). If data is not sent within this time, all open streams and the
# HTTP/2 connection will be closed. A value of "0" (zero) will disable the
# timeout.
#
# [*http2__max_concurrent_streams*]
# This setting controls the number of streams a client is permitted to open
# concurrently on a single connection.
#
# [*http2__max_frame_size*]
# This setting controls the maximum HTTP/2 frame size clients are permitted to
# send to the traffic manager.
#
# [*http2__max_header_padding*]
# The maximum size, in bytes, of the random-length padding to add to HTTP/2
# header frames. The padding, a random number of zero bytes up to the maximum
# specified.
#
# [*http2__merge_cookie_headers*]
# Whether Cookie headers received from an HTTP/2 client should be merged into
# a single Cookie header using RFC6265 rules before forwarding to an HTTP/1.1
# server. Some web applications do not handle multiple Cookie headers
# correctly.
#
# [*http2__stream_window_size*]
# This setting controls the flow control window for each HTTP/2 stream. This
# will limit the memory used for buffering when the client is sending body
# data faster than the pool node is reading it.
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
# [*log__always_flush*]
# Write log data to disk immediately, rather than buffering data.
#
# [*log__client_connection_failures*]
# Should the virtual server log failures occurring on connections to clients.
#
# [*log__enabled*]
# Whether or not to log connections to the virtual server to a disk on the
# file system.
#
# [*log__filename*]
# The name of the file in which to store the request logs. The filename can
# contain macros which will be expanded by the traffic manager to generate the
# full filename.
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
# [*log__ssl_resumption_failures*]
# Should the virtual server log messages when attempts to resume SSL sessions
# (either from the session cache or a session ticket) fail. Note that failure
# to resume an SSL session does not result in the SSL connection being closed,
# but it does cause a full SSL handshake to take place.
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
# [*ssl__cipher_suites*]
# The SSL/TLS cipher suites to allow for connections to this virtual server.
# Leaving this empty will make the virtual server use the globally configured
# cipher suites, see configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!cipher_su
# ites"> "ssl!cipher_suites"</a> in the Global Settings section of the System
# tab.  See there for how to specify SSL/TLS cipher suites.
#
# [*ssl__client_cert_cas*]
# The certificate authorities that this virtual server should trust to
# validate client certificates. If no certificate authorities are selected,
# and client certificates are requested, then all client certificates will be
# accepted.
# Type:array
# Properties:
#
# [*ssl__client_cert_headers*]
# What HTTP headers the virtual server should add to each request to show the
# data in the client certificate.
#
# [*ssl__elliptic_curves*]
# The SSL elliptic curve preference list for SSL connections to this virtual
# server using TLS version 1.0 or higher. Leaving this empty will make the
# virtual server use the globally configured curve preference list. The named
# curves P256, P384 and P521 may be configured.
# Type:array
# Properties:
#
# [*ssl__honor_fallback_scsv*]
# Whether or not the Fallback SCSV sent by TLS clients is honored by this
# virtual server. Choosing the global setting means the value of configuration
# key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!honor_fal
# lback_scsv"> "ssl!honor_fallback_scsv"</a> from the Global Settings section
# of the System tab will be enforced.
#
# [*ssl__issued_certs_never_expire*]
# When the virtual server verifies certificates signed by these certificate
# authorities, it doesn't check the 'not after' date, i.e., they are
# considered valid even after their expiration date has passed (but not if
# they have been revoked).
# Type:array
# Properties:
#
# [*ssl__issued_certs_never_expire_depth*]
# This setting gives the number of certificates in a certificate chain beyond
# those listed as issued_certs_never_expire whose certificate expiry will not
# be checked. For example "0" will result in the expiry checks being made for
# certificates issued by issued_certs_never_expire certificates, "1" will
# result in no expiry checks being performed for the certificates directly
# issued by issued_certs_never_expire certificates, "2" will avoid checking
# expiry for certificates issued by certificates issued by the
# issued_certs_never_expire certificates as well, and so on.
#
# [*ssl__max_key_size*]
# The maximum client RSA/DSA certificate key size that the virtual server
# should accept.
#
# [*ssl__min_key_size*]
# The minimum client RSA/DSA certificate key size that the virtual server
# should accept.
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
# "type"=>"boolean", "default"=>true}, "nonce"=>{"description"=>"How to use
# the OCSP nonce extension, which protects against OCSP replay attacks. Some
# OCSP servers do not support nonces.", "type"=>"string", "default"=>"off",
# "enum"=>["off", "on", "strict"]}, "required"=>{"description"=>"Whether we
# should do an OCSP check for this issuer, and whether it is required or
# optional.", "type"=>"string", "default"=>"optional", "enum"=>["none",
# "optional", "strict"]}, "responder_cert"=>{"description"=>"The expected
# responder certificate.", "type"=>"string", "default"=>""},
# "signer"=>{"description"=>"The certificate with which to sign the request,
# if any.", "type"=>"string", "default"=>""}, "url"=>{"description"=>"Which
# OCSP responders this virtual server should use to verify client
# certificates.", "type"=>"string", "default"=>""}}
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
# [*ssl__request_client_cert*]
# Whether or not the virtual server should request an identifying SSL
# certificate from each client.
#
# [*ssl__send_close_alerts*]
# Whether or not to send an SSL/TLS "close alert" when the traffic manager is
# initiating an SSL socket disconnection.
#
# [*ssl__server_cert_alt_certificates*]
# The SSL certificates and corresponding private keys.
# Type:array
# Properties:
#
# [*ssl__server_cert_default*]
# The default SSL certificate to use for this virtual server.
#
# [*ssl__server_cert_host_mapping*]
# Host specific SSL server certificate mappings.
# Type:array
# Properties:{"host"=>{"description"=>"Host which this entry refers to.",
# "type"=>"string"}, "certificate"=>{"description"=>"The SSL server
# certificate for a particular destination site IP.", "type"=>"string"},
# "alt_certificates"=>{"description"=>"The SSL server certificates for a
# particular destination site IP.", "type"=>"array", "default"=>[],
# "uniqueItems"=>false, "items"=>{"type"=>"string"}}}
#
# [*ssl__session_cache_enabled*]
# Whether or not use of the session cache is enabled for this virtual server.
# Choosing the global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!cache!ena
# bled"> "ssl!session_cache_enabled"</a> from the Global Settings section of
# the System tab will be enforced.
#
# [*ssl__session_tickets_enabled*]
# Whether or not use of session tickets is enabled for this virtual server.
# Choosing the global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!tickets!e
# nabled"> "ssl!tickets!enabled"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*ssl__signature_algorithms*]
# The SSL signature algorithms preference list for SSL connections to this
# virtual server using TLS version 1.2 or higher. Leaving this empty will make
# the virtual server use the globally configured preference list,
# "signature_algorithms" in the "ssl" section of the "global_settings"
# resource.  See there and in the online help for how to specify SSL signature
# algorithms.
#
# [*ssl__support_ssl3*]
# Whether or not SSLv3 is enabled for this virtual server.  Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_s
# sl3"> "ssl!support_ssl3"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__support_tls1*]
# Whether or not TLSv1.0 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1"> "ssl!support_tls1"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__support_tls1_1*]
# Whether or not TLSv1.1 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1_1"> "ssl!support_tls1_1"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*ssl__support_tls1_2*]
# Whether or not TLSv1.2 is enabled for this virtual server. Choosing the
# global setting means the value of configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1_2"> "ssl!support_tls1_2"</a> from the Global Settings section of the
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
# [*tcp__close_with_rst*]
# Whether or not connections from clients should be closed with a RST packet,
# rather than a FIN packet. This avoids the TIME_WAIT state, which on rare
# occasions allows wandering duplicate packets to be safely ignored.
#
# [*tcp__mss*]
# The maximum TCP segment size. This will place a maximum on the size of TCP
# segments that are sent by this machine, and will advertise to the client
# this value as the maximum size of TCP segment to send to this machine.
# Setting this to zero causes the default maximum TCP segment size to be
# advertised and used.
#
# [*tcp__nagle*]
# Whether or not Nagle's algorithm should be used for TCP connections.
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
# [*transaction_export__brief*]
# Whether to export a restricted set of metadata about transactions processed
# by this virtual server. If enabled, more verbose information such as client
# and server headers and request tracing events will be omitted from the
# exported data.
#
# [*transaction_export__enabled*]
# Export metadata about transactions handled by this service to the globally
# configured endpoint. Data will be exported only if the global
# "transaction_export!enabled" setting is enabled.
#
# [*transaction_export__hi_res*]
# Whether the transaction processing timeline included in the metadata export
# is recorded with a high, microsecond, resolution. If set to "No", timestamps
# will be recorded with a resolution of milliseconds.
#
# [*transaction_export__http_header_blacklist*]
# The set of HTTP header names for which corresponding values should be
# redacted from the metadata exported by this virtual server.
# Type:array
# Properties:
#
# [*udp__end_point_persistence*]
# Whether UDP datagrams received from the same IP address and port are sent to
# the same pool node if they match an existing UDP session. Sessions are
# defined by the protocol being handled, for example SIP datagrams are grouped
# based on the value of the Call-ID header.
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
  $basic__bandwidth_class                    = undef,
  $basic__completion_rules                   = '[]',
  $basic__connect_timeout                    = 10,
  $basic__enabled                            = false,
  $basic__glb_services                       = '[]',
  $basic__listen_on_any                      = true,
  $basic__listen_on_hosts                    = '[]',
  $basic__listen_on_traffic_ips              = '[]',
  $basic__max_concurrent_connections         = 0,
  $basic__note                               = undef,
  $basic__protection_class                   = undef,
  $basic__protocol                           = 'http',
  $basic__proxy_protocol                     = false,
  $basic__request_rules                      = '[]',
  $basic__response_rules                     = '[]',
  $basic__slm_class                          = undef,
  $basic__ssl_decrypt                        = false,
  $basic__transparent                        = false,
  $aptimizer__enabled                        = false,
  $aptimizer__profile                        = '[]',
  $auth__saml_idp                            = undef,
  $auth__saml_nameid_format                  = 'none',
  $auth__saml_sp_acs_url                     = undef,
  $auth__saml_sp_entity_id                   = undef,
  $auth__saml_time_tolerance                 = 5,
  $auth__session_cookie_attributes           = 'HttpOnly; SameSite=Strict',
  $auth__session_cookie_name                 = 'VS_SamlSP_Auth',
  $auth__session_log_external_state          = false,
  $auth__session_timeout                     = 7200,
  $auth__type                                = 'none',
  $auth__verbose                             = false,
  $connection__keepalive                     = true,
  $connection__keepalive_timeout             = 10,
  $connection__max_client_buffer             = 65536,
  $connection__max_server_buffer             = 65536,
  $connection__max_transaction_duration      = 0,
  $connection__server_first_banner           = undef,
  $connection__timeout                       = 300,
  $connection_errors__error_file             = 'Default',
  $cookie__domain                            = 'no_rewrite',
  $cookie__new_domain                        = undef,
  $cookie__path_regex                        = undef,
  $cookie__path_replace                      = undef,
  $cookie__secure                            = 'no_modify',
  $dns__edns_client_subnet                   = true,
  $dns__edns_udpsize                         = 4096,
  $dns__max_udpsize                          = 4096,
  $dns__rrset_order                          = 'fixed',
  $dns__verbose                              = false,
  $dns__zones                                = '[]',
  $ftp__data_source_port                     = 0,
  $ftp__force_client_secure                  = true,
  $ftp__force_server_secure                  = true,
  $ftp__port_range_high                      = 0,
  $ftp__port_range_low                       = 0,
  $ftp__ssl_data                             = true,
  $gzip__compress_level                      = 1,
  $gzip__enabled                             = false,
  $gzip__etag_rewrite                        = 'wrap',
  $gzip__include_mime                        = '["text/html","text/plain"]',
  $gzip__max_size                            = 10000000,
  $gzip__min_size                            = 1000,
  $gzip__no_size                             = true,
  $http__add_cluster_ip                      = true,
  $http__add_x_forwarded_for                 = false,
  $http__add_x_forwarded_proto               = false,
  $http__autodetect_upgrade_headers          = true,
  $http__chunk_overhead_forwarding           = 'lazy',
  $http__location_regex                      = undef,
  $http__location_replace                    = undef,
  $http__location_rewrite                    = 'if_host_matches',
  $http__mime_default                        = 'text/plain',
  $http__mime_detect                         = false,
  $http__strip_x_forwarded_proto             = true,
  $http2__connect_timeout                    = 0,
  $http2__data_frame_size                    = 4096,
  $http2__enabled                            = true,
  $http2__header_table_size                  = 4096,
  $http2__headers_index_blacklist            = '[]',
  $http2__headers_index_default              = true,
  $http2__headers_index_whitelist            = '[]',
  $http2__headers_size_limit                 = 262144,
  $http2__idle_timeout_no_streams            = 120,
  $http2__idle_timeout_open_streams          = 600,
  $http2__max_concurrent_streams             = 200,
  $http2__max_frame_size                     = 16384,
  $http2__max_header_padding                 = 0,
  $http2__merge_cookie_headers               = true,
  $http2__stream_window_size                 = 65535,
  $kerberos_protocol_transition__enabled     = false,
  $kerberos_protocol_transition__principal   = undef,
  $kerberos_protocol_transition__target      = undef,
  $log__client_connection_failures           = false,
  $log__enabled                              = false,
  $log__filename                             = '%zeushome%/zxtm/log/%v.log',
  $log__format                               = '%h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"',
  $log__save_all                             = true,
  $log__server_connection_failures           = false,
  $log__session_persistence_verbose          = false,
  $log__ssl_failures                         = false,
  $log__ssl_resumption_failures              = false,
  $recent_connections__enabled               = true,
  $recent_connections__save_all              = false,
  $request_tracing__enabled                  = false,
  $request_tracing__trace_io                 = false,
  $rtsp__streaming_port_range_high           = 0,
  $rtsp__streaming_port_range_low            = 0,
  $rtsp__streaming_timeout                   = 30,
  $sip__dangerous_requests                   = 'node',
  $sip__follow_route                         = true,
  $sip__max_connection_mem                   = 65536,
  $sip__mode                                 = 'sip_gateway',
  $sip__rewrite_uri                          = false,
  $sip__streaming_port_range_high            = 0,
  $sip__streaming_port_range_low             = 0,
  $sip__streaming_timeout                    = 60,
  $sip__timeout_messages                     = true,
  $sip__transaction_timeout                  = 30,
  $smtp__expect_starttls                     = true,
  $ssl__add_http_headers                     = false,
  $ssl__cipher_suites                        = undef,
  $ssl__client_cert_cas                      = '[]',
  $ssl__client_cert_headers                  = 'none',
  $ssl__elliptic_curves                      = '[]',
  $ssl__honor_fallback_scsv                  = 'use_default',
  $ssl__issued_certs_never_expire            = '[]',
  $ssl__issued_certs_never_expire_depth      = 1,
  $ssl__ocsp_enable                          = false,
  $ssl__ocsp_issuers                         = '[]',
  $ssl__ocsp_max_response_age                = 0,
  $ssl__ocsp_stapling                        = false,
  $ssl__ocsp_time_tolerance                  = 30,
  $ssl__ocsp_timeout                         = 10,
  $ssl__request_client_cert                  = 'dont_request',
  $ssl__send_close_alerts                    = true,
  $ssl__server_cert_alt_certificates         = '[]',
  $ssl__server_cert_default                  = undef,
  $ssl__server_cert_host_mapping             = '[]',
  $ssl__session_cache_enabled                = 'use_default',
  $ssl__session_tickets_enabled              = 'use_default',
  $ssl__signature_algorithms                 = undef,
  $ssl__support_ssl3                         = 'use_default',
  $ssl__support_tls1                         = 'use_default',
  $ssl__support_tls1_1                       = 'use_default',
  $ssl__support_tls1_2                       = 'use_default',
  $ssl__trust_magic                          = false,
  $syslog__enabled                           = false,
  $syslog__format                            = '%h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"',
  $syslog__ip_end_point                      = undef,
  $syslog__msg_len_limit                     = 1024,
  $tcp__close_with_rst                       = false,
  $tcp__nagle                                = false,
  $tcp__proxy_close                          = false,
  $transaction_export__brief                 = false,
  $transaction_export__enabled               = true,
  $transaction_export__hi_res                = false,
  $transaction_export__http_header_blacklist = '["Authorization"]',
  $udp__end_point_persistence                = true,
  $udp__port_smp                             = false,
  $udp__response_datagrams_expected          = 1,
  $udp__timeout                              = 7,
  $web_cache__control_out                    = undef,
  $web_cache__enabled                        = false,
  $web_cache__error_page_time                = 30,
  $web_cache__max_time                       = 600,
  $web_cache__refresh_time                   = 2,
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
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/virtual_servers.erb'),
    type     => 'application/json',
    internal => 'virtual_servers',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/virtual_servers", {ensure => present})
    file_line { "virtual_servers/${name}":
      line => "virtual_servers/${name}",
      path => "${purge_state_dir}/virtual_servers",
    }
  }
}
