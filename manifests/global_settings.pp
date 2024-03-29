# === class: brocadevtm::global_settings
#
# Global Settings
# General settings that apply to every machine in the cluster.
#
# === Parameters
#
# [*basic__accepting_delay*]
# How often, in milliseconds, each traffic manager child process (that isn't
# listening for new connections) checks to see whether it should start
# listening for new connections.
#
# [*basic__afm_cluster_timeout*]
# How long in seconds to wait for the application firewall control script to
# complete clustering operations for the application firewall.
#
# [*basic__afm_control_timeout*]
# How long in seconds to wait for the application firewall control script to
# complete operations such as starting and stopping the application firewall.
#
# [*basic__afm_enabled*]
# Is the application firewall enabled.
#
# [*basic__child_control_command_timeout*]
# Timeout for waiting for child processes to respond to parent control
# requests If a child process (zeus.zxtm, zeus.eventd, zeus.autoscaler, etc)
# takes longer than this number of seconds to respond to a parent control
# command, error messages will be logged for every multiple of this number of
# seconds, for example, if set to 10 seconds, a log message will be logged
# every 10 seconds, until the child responds or is automatically killed (see
# the child_control_kill_timeout setting).
#
# [*basic__child_control_kill_timeout*]
# Timeout for waiting for child processes to respond to parent control
# requests If a child process (zeus.zxtm, zeus.eventd, zeus.autoscaler, etc)
# takes longer than this number of seconds to respond to a parent control
# command, then the parent zeus.zxtm process will assume this process is stuck
# in an unresponsive loop and will kill it, log the termination event, and
# wait for a new process of the same type to restart. Set this to 0 to disable
# killing unresponsive child processes.
#
# [*basic__chunk_size*]
# The default chunk size for reading/writing requests.
#
# [*basic__client_first_opt*]
# Whether or not your traffic manager should make use of TCP optimisations to
# defer the processing of new client-first connections until the client has
# sent some data.
#
# [*basic__cluster_identifier*]
# Cluster identifier. Generally supplied by Services Director.
#
# [*basic__cpu_starvation_check_interval*]
# How frequently should child processes check for CPU starvation? A value of 0
# disables the detection.
#
# [*basic__cpu_starvation_check_tolerance*]
# How much delay in milliseconds between starvation checks do we allow before
# we assume that the machine or its HyperVisor are overloaded.
#
# [*basic__http2_conn_frame_queue_limit*]
# Maximum number of queued HTTP/2 frames per connection before the connection
# is closed. Intended to protect against CVE-2019-9514 and similar exploits.
#
# [*basic__http2_no_cipher_blacklist_check*]
# Disable the cipher blacklist check in HTTP2 (mainly intended for testing
# purposes)
#
# [*basic__internal_config_logging*]
# Whether or not messages pertaining to internal configuration files should be
# logged to the event log.
#
# [*basic__license_servers*]
# A list of license servers for FLA licensing.  A license server should be
# specified as a "<ip/host>:<port>" pair.
# Type:array
# Properties:
#
# [*basic__max_fds*]
# The maximum number of file descriptors that your traffic manager will
# allocate.
#
# [*basic__max_tcp_buff_mem*]
# The maximum amount of memory allowed to be used to buffer network data in
# user space for all TCP connections. The TCP data buffered are either
# received from clients but before sending to pool nodes, or recevied from
# pool nodes but before sending to clients. This is specified as either a
# percentage of system RAM, "5%" for example, or an absolute size such as
# "1024MB" and "2GB". A numeric value without suffix MB, GB or % defaults to
# MB. A value of "800" means 800MB. A value of "0" means unlimited.
#
# [*basic__monitor_memory_size*]
# The maximum number of each of nodes, pools or locations that can be
# monitored. The memory used to store information about nodes, pools and
# locations is allocated at start-up, so the traffic manager must be restarted
# after changing this setting.
#
# [*basic__rate_class_limit*]
# The maximum number of Rate classes that can be created. Approximately 100
# bytes will be pre-allocated per Rate class.
#
# [*basic__shared_pool_size*]
# The size of the shared memory pool used for shared storage across worker
# processes (e.g. bandwidth shared data).This is specified as either a
# percentage of system RAM, "5%" for example, or an absolute size such as
# "10MB".
#
# [*basic__slm_class_limit*]
# The maximum number of SLM classes that can be created. Approximately 100
# bytes will be pre-allocated per SLM class.
#
# [*basic__so_rbuff_size*]
# The size of the operating system's read buffer. A value of "0" (zero) means
# to use the OS default; in normal circumstances this is what should be used.
#
# [*basic__so_wbuff_size*]
# The size of the operating system's write buffer. A value of "0" (zero) means
# to use the OS default; in normal circumstances this is what should be used.
#
# [*basic__socket_optimizations*]
# Whether or not the traffic manager should use potential network socket
# optimisations. If set to "auto", a decision will be made based on the host
# platform.
#
# [*basic__storage_shared*]
# Whether the storage for the traffic managers' configuration is shared
# between cluster members.
#
# [*basic__tip_class_limit*]
# The maximum number of Traffic IP Groups that can be created.
#
# [*admin__honor_fallback_scsv*]
# Whether or not the admin server, the internal control port and the config
# daemon honor the Fallback SCSV to protect connections against downgrade
# attacks.
#
# [*admin__ssl3_allow_rehandshake*]
# Whether or not SSL3/TLS re-handshakes should be supported for admin server
# and internal connections.
#
# [*admin__ssl3_ciphers*]
# The SSL ciphers to use for admin server and internal connections. For
# information on supported ciphers see the online help.
#
# [*admin__ssl3_diffie_hellman_key_length*]
# The length in bits of the Diffie-Hellman key for ciphers that use
# Diffie-Hellman key agreement for admin server and internal connections.
#
# [*admin__ssl3_min_rehandshake_interval*]
# If SSL3/TLS re-handshakes are supported on the admin server, this defines
# the minimum time interval (in milliseconds) between handshakes on a single
# SSL3/TLS connection that is permitted.  To disable the minimum interval for
# handshakes the key should be set to the value "0".
#
# [*admin__ssl_elliptic_curves*]
# The SSL elliptic curve preference list for admin and internal connections.
# The named curves P256, P384 and P521 may be configured.
# Type:array
# Properties:
#
# [*admin__ssl_insert_extra_fragment*]
# Whether or not SSL3 and TLS1 use one-byte fragments as a BEAST
# countermeasure for admin server and internal connections.
#
# [*admin__ssl_max_handshake_message_size*]
# The maximum size (in bytes) of SSL handshake messages that the admin server
# and internal connections will accept. To accept any size of handshake
# message the key should be set to the value "0".
#
# [*admin__ssl_signature_algorithms*]
# The SSL signature algorithms preference list for admin and internal
# connections using TLS version 1.2 or higher. For information on supported
# algorithms see the online help.
#
# [*admin__support_ssl3*]
# Whether or not SSL3 support is enabled for admin server and internal
# connections.
#
# [*admin__support_tls1*]
# Whether or not TLS1.0 support is enabled for admin server and internal
# connections.
#
# [*admin__support_tls1_1*]
# Whether or not TLS1.1 support is enabled for admin server and internal
# connections.
#
# [*admin__support_tls1_2*]
# Whether or not TLS1.2 support is enabled for admin server and internal
# connections.
#
# [*admin__support_tls1_3*]
# Whether or not TLS1.3 support is enabled for admin server and internal
# connections.
#
# [*appliance__bootloader_password*]
# The password used to protect the bootloader. An empty string means there
# will be no protection.
#
# [*appliance__return_path_routing_enabled*]
# Whether or not the traffic manager will attempt to route response packets
# back to clients via the same route on which the corresponding request
# arrived.
# Note that this applies only to the last hop of the route - the behaviour of
# upstream routers cannot be altered by the traffic manager.
#
# [*aptimizer__cache_entry_lifetime*]
# The period of time (in seconds) that unaccessed cache entries will be
# retained by Web Accelerator.
#
# [*aptimizer__cache_entry_limit*]
# The maximum number of cache entries that will be retained by Web Accelerator
# before removing old entries to make room for new ones.
#
# [*aptimizer__default_profile*]
# The Profile to use by default if no mappings are configured (or if Web
# Accelerator is licensed in Express mode)
#
# [*aptimizer__default_scope*]
# The Scope to use by default if no mappings are configured (or if Web
# Accelerator is licensed in Express mode)
#
# [*aptimizer__dependent_fetch_timeout*]
# How long to wait for dependent resource fetches (default 30 seconds).
#
# [*aptimizer__enable_state_dump*]
# Whether or not the Web Accelerator state will be dumped if
# "/aptimizer-state-dump" is appended to an optimized URL.
#
# [*aptimizer__ipc_timeout*]
# The time after which connections between the traffic manager and Web
# Accelerator processes will be closed, should an optimization job take
# considerably longer than expected.
#
# [*aptimizer__max_concurrent_jobs*]
# How many direct jobs can be in progress before optimization jobs start
# getting rejected by Web Accelerator.
#
# [*aptimizer__max_dependent_fetch_size*]
# The maximum size of a dependent resource that can undergo Web Accelerator
# optimization. Any content larger than this size will not be optimized. Units
# of KB and MB can be used, no postfix denotes bytes. A value of 0 disables
# the limit.
#
# [*aptimizer__max_original_content_buffer_size*]
# The maximum size of unoptimized content buffered in the traffic manager for
# a single backend response that is undergoing Web Accelerator optimization.
# Responses larger than this will not be optimized. Note that if the backend
# response is compressed then this setting pertains to the compressed size,
# before Web Accelerator decompresses it. Units of KB and MB can be used, no
# postfix denotes bytes. Value range is 1 - 128MB.
#
# [*aptimizer__queue_buffer_size*]
# The size in bytes of the operating system buffer which is used to send
# request URLs and data to Web Accelerator and return optimized resources from
# Web Accelerator. A larger buffer will allow a greater number of simultaneous
# resources to be optimized, particularly if a large number of requests are
# made at the same time, for example an HTML page containing hundreds of
# images to optimize. If this is set to zero, the default operating system
# buffer size will be used.
#
# [*aptimizer__resource_lifetime*]
# The period of time (in seconds) that resource data is retained by Web
# Accelerator after it is no longer actively in use.
#
# [*aptimizer__resource_memory_limit*]
# The maximum amount of memory the cache is allowed to have pinned. Once it
# goes over that limit, it starts releasing resource data in LRU order.
#
# [*aptimizer__watchdog_interval*]
# The period of time (in seconds) after which a previous failure will no
# longer count towards the watchdog limit.
#
# [*aptimizer__watchdog_limit*]
# The maximum number of times the Web Accelerator sub-process will be started
# or restarted within the interval defined by the aptimizer!watchdog_interval
# setting. If the process fails this many times, it must be restarted manually
# from the Diagnose page.  Zero means no limit.
#
# [*auditlog__via_eventd*]
# Whether to mirror the audit log to EventD.
#
# [*auditlog__via_syslog*]
# Whether to output audit log message to the syslog.
#
# [*auth__saml_key_lifetime*]
# Lifetime in seconds of cryptographic keys used to decrypt SAML SP sessions
# stored externally (client-side).
#
# [*auth__saml_key_rotation_interval*]
# Rotation interval in seconds for cryptographic keys used to encrypt SAML SP
# sessions stored externally (client-side).
#
# [*autoscaler__slm_interval*]
# The interval at which the parent sends new SLM status to the autoscaler.
#
# [*autoscaler__verbose*]
# Whether or not detailed messages about the autoscaler's activity are written
# to the error log.
#
# [*bandwidth__license_sharing*]
# For the global BW limits, how the bandwidth allocation should be shared
# between consumers. In 'pooled' mode, the allocation is shared between all
# consumers, who can write as much data as they want until the pool of data is
# exhausted. In 'quota' mode, bandwidth is divided between consumers, who can
# write only as much as they are allocated. Any unused bandwidth will be lost.
#
# [*bandwidth__pooled_min_write*]
# For the global BW limits using 'pooled' bandwidth allocation sharing between
# consumers, when the license limit is reached the allowance will be evenly
# distributed between the remaining consumers. Each consumer will, however be
# permitted to write at least this much data.
#
# [*bgp__as_number*]
# The number of the BGP AS in which the traffic manager will operate. Must be
# entered in decimal.
#
# [*bgp__enabled*]
# Whether BGP Route Health Injection is enabled
#
# [*cluster_comms__allow_update_default*]
# The default value of "allow_update" for new cluster members.  If you have
# cluster members joining from less trusted locations (such as cloud
# instances) this can be set to "false" in order to make them effectively
# "read-only" cluster members.
#
# [*cluster_comms__allowed_update_hosts*]
# The hosts that can contact the internal administration port on each traffic
# manager.  This should be a list containing IP addresses, CIDR IP subnets,
# and "localhost"; or it can be set to "all" to allow any host to connect.
# Type:array
# Properties:
#
# [*cluster_comms__state_sync_interval*]
# How often to propagate the session persistence and bandwidth information to
# other traffic managers in the same cluster. Set this to "0" (zero) to
# disable propagation.<br /> Note that a cluster using "unicast" heartbeat
# messages cannot turn off these messages.
#
# [*cluster_comms__state_sync_timeout*]
# The maximum amount of time to wait when propagating session persistence and
# bandwidth information to other traffic managers in the same cluster. Once
# this timeout is hit the transfer is aborted and a new connection created.
#
# [*connection__idle_connections_max*]
# The maximum number of unused HTTP keepalive connections with back-end nodes
# that the traffic manager should maintain for re-use.  Setting this to "0"
# (zero) will cause the traffic manager to auto-size this parameter based on
# the available number of file-descriptors.
#
# [*connection__idle_timeout*]
# How long an unused HTTP keepalive connection should be kept before it is
# discarded.
#
# [*connection__listen_queue_size*]
# The listen queue size for managing incoming connections. It may be necessary
# to increase the system's listen queue size if this value is altered.  If the
# value is set to "0" then the default system setting will be used.
#
# [*connection__max_accepting*]
# Number of processes that should accept new connections. Only this many
# traffic manager child processes will listen for new connections at any one
# time. Setting this to "0" (zero) will cause your traffic manager to select
# an appropriate default value based on the architecture and number of CPUs.
#
# [*connection__multiple_accept*]
# Whether or not the traffic manager should try to read multiple new
# connections each time a new client connects. This can improve performance
# under some very specific conditions. However, in general it is recommended
# that this be set to 'false'.
#
# [*connection__udp_read_multiple*]
# Whether or not the traffic manager should try to read multiple UDP packets
# from clients each time the kernel reports data received from clients. This
# can improve performance for the situation with high UDP traffic throughput
# from clients to the traffic manager. Therefore, in general it is recommended
# that this be set to 'Yes'.
#
# [*dns__checktime*]
# How often to check the DNS configuration for changes.
#
# [*dns__hosts*]
# The location of the "hosts" file.
#
# [*dns__hostsfirst*]
# Whether or not to try reading the "dns!hosts" file before calling
# gethostbyname(). This config key exists for testing purposes only.
#
# [*dns__max_ttl*]
# Maximum Time To Live (expiry time) for entries in the DNS cache.
#
# [*dns__maxasynctries*]
# How often to send DNS request packets before giving up.
#
# [*dns__min_ttl*]
# Minimum Time To Live (expiry time) for entries in the DNS cache.
#
# [*dns__negative_expiry*]
# Expiry time for failed lookups in the DNS cache.
#
# [*dns__resolv*]
# The location of the "resolv.conf" file.
#
# [*dns__size*]
# Maximum number of entries in the DNS cache.
#
# [*dns__timeout*]
# Timeout for receiving a response from a DNS server.
#
# [*dns_autoscale__resolver*]
# The IP address and port number of the DNS server to use for DNS-derived
# autoscaling, in the form addr:port. This is intended for test and debug
# purposes, and will override the configuration of the system resolver, which
# is usually defined in /etc/resolv.conf
#
# [*ec2__access_key_id*]
# Deprecated: This key is unused. Amazon authentication credentials are now
# extracted from IAM Roles assigned to an EC2 instance.
#
# [*ec2__action_timeout*]
# How long, in seconds, the traffic manager should wait while associating or
# disassociating an Elastic IP to the instance.
#
# [*ec2__awstool_timeout*]
# The maximum amount of time requests to the AWS Query API can take before
# timing out.
#
# [*ec2__metadata_server*]
# URL for the EC2 metadata server, "http://169.254.169.254/latest/meta-data"
# for example.
#
# [*ec2__metadata_timeout*]
# The maximum amount of time requests to the EC2 Metadata Server can take
# before timing out.
#
# [*ec2__query_server*]
# URL for the Amazon EC2 endpoint, "https://ec2.amazonaws.com/" for example.
#
# [*ec2__secret_access_key*]
# Deprecated: This key is unused. Amazon authentication credentials are now
# extracted from IAM Roles assigned to an EC2 instance.
#
# [*ec2__verify_query_server_cert*]
# Whether to verify Amazon EC2 endpoint's certificate using CA(s) present in
# SSL Certificate Authorities Catalog.
#
# [*ec2__vpc_decluster_on_stop*]
# Whether to decluster the traffic manager running inside vpc when the
# instance stops.
#
# [*eventing__mail_interval*]
# The minimum length of time that must elapse between alert emails being sent.
# Where multiple alerts occur inside this timeframe, they will be retained
# and sent within a single email rather than separately.
#
# [*eventing__max_attempts*]
# The number of times to attempt to send an alert email before giving up.
#
# [*fault_tolerance__arp_count*]
# The number of ARP packets a traffic manager should send when an IP address
# is raised.
#
# [*fault_tolerance__auto_failback*]
# Whether or not traffic IPs automatically move back to machines that have
# recovered from a failure and have dropped their traffic IPs.
#
# [*fault_tolerance__autofailback_delay*]
# Configure the delay of automatic failback after a previous failover event.
# This setting has no effect if autofailback is disabled.
#
# [*fault_tolerance__child_timeout*]
# How long the traffic manager should wait for status updates from any of the
# traffic manager's child processes before assuming one of them is no longer
# servicing traffic.
#
# [*fault_tolerance__frontend_check_ips*]
# The IP addresses used to check front-end connectivity. The text "%gateway%"
# will be replaced with the default gateway on each system. Set this to an
# empty string if the traffic manager is on an Intranet with no external
# connectivity.
# Type:array
# Properties:
#
# [*fault_tolerance__heartbeat_method*]
# The method traffic managers should use to exchange cluster heartbeat
# messages.
#
# [*fault_tolerance__igmp_interval*]
# The interval between unsolicited periodic IGMP Membership Report messages
# for Multi-Hosted Traffic IP Groups.
#
# [*fault_tolerance__monitor_interval*]
# The frequency, in milliseconds, that each traffic manager machine should
# check and announce its connectivity.
#
# [*fault_tolerance__monitor_timeout*]
# How long, in seconds, each traffic manager should wait for a response from
# its connectivity tests or from other traffic manager machines before
# registering a failure.
#
# [*fault_tolerance__multicast_address*]
# The multicast address and port to use to exchange cluster heartbeat messages.
#
# [*fault_tolerance__multicast_version*]
# The multicast version to be use ("1", "2" or "3") for cluster heartbeat
# messages. A value of "0" will let the operating system choose (but note that
# Linux often gets this wrong). This setting is only supported when using 2.6
# versions of the Linux kernel.
#
# [*fault_tolerance__routing_sw_run_ribd*]
# Whether the ribd routing daemon is to be run. The routing software needs to
# be restarted for this change to take effect.
#
# [*fault_tolerance__routing_sw_watchdog_interval*]
# The period of time in seconds after which a failure will no longer count
# towards the watchdog limit.
#
# [*fault_tolerance__routing_sw_watchdog_limit*]
# The maximum number of times the routing software suite of processes will be
# started or restarted within the interval defined by the
# flipper!routing_sw_watchdog_interval setting. If the routing software fails
# this many times within the interval, it will be stopped and can only be
# restarted manually from the Diagnose page or by switching OSPF off and on
# again. Zero means no limit.
#
# [*fault_tolerance__tipv6_raise_deprecated*]
# Mark Traffic IPv6 addresses as "deprecated" to prevent their use during IPv6
# source selection.
#
# [*fault_tolerance__unicast_port*]
# The unicast UDP port to use to exchange cluster heartbeat messages.
#
# [*fault_tolerance__use_bind_ip*]
# Whether or not cluster heartbeat messages should only be sent and received
# over the management network.
#
# [*fault_tolerance__verbose*]
# Whether or not a traffic manager should log all connectivity tests.  This is
# very verbose, and should only be used for diagnostic purposes.
#
# [*fips__enabled*]
# Enable FIPS Mode (requires software restart).
#
# [*ftp__data_bind_low*]
# Whether or not the traffic manager should permit use of FTP data connection
# source ports lower than 1024.  If "No" the traffic manager can completely
# drop root privileges, if "Yes" some or all privileges may be retained in
# order to bind to low ports.
#
# [*gce__action_timeout*]
# How long, in seconds, the traffic manager should wait while associating or
# disassociating an External IP to a NIC on the instance.
#
# [*glb__verbose*]
# Write a message to the logs for every DNS query that is load balanced,
# showing the source IP address and the chosen datacenter.
#
# [*historical_activity__keep_days*]
# Number of days to store historical traffic information, if set to "0" the
# data will be kept indefinitely.
#
# [*http__max_chunk_header_length*]
# The maximum length the header line of an HTTP chunk can have in an upload
# from the client.  Header lines exceeding this length will be considered
# invalid.  The traffic manager buffers the header line before it can read any
# payload data in the chunk; the limit exists to protect against malicious
# clients that send very long lines but never any payload data.
#
# [*ip__appliance_returnpath*]
# A table of MAC address/network interface to IP address mappings for each
# router where return path routing is required.
# Type:array
# Properties:{"mac"=>{"description"=>"The MAC address/network interface of a
# router the software is connected to.", "type"=>"string"},
# "ipv4"=>{"description"=>"The MAC address/network interface to IPv4 address
# mapping of a router the software is connected to. The value is the IPv4
# address, the \"*\" (asterisk) in the key name is the MAC address and an
# optional network interface name, for example, 00:50:56:a6:24:3d or
# 00:50:56:a6:24:3d#eth0.", "type"=>"string", "default"=>""},
# "ipv6"=>{"description"=>"The MAC address/network interface to IPv6 address
# mapping of a router the software is connected to. The value is the IPv6
# address, the \"*\" (asterisk) in the key name is the MAC address and an
# optional network interface name, for example, 00:50:56:a6:24:3d or
# 00:50:56:a6:24:3d#eth0.", "type"=>"string", "default"=>""}}
#
# [*java__classpath*]
# CLASSPATH to use when starting the Java runner.
#
# [*java__command*]
# Java command to use when starting the Java runner, including any additional
# options.
#
# [*java__enabled*]
# Whether or not Java support should be enabled.  If this is set to "No", then
# your traffic manager will not start any Java processes. Java support is only
# required if you are using the TrafficScript "java.run()" function.
#
# [*java__lib*]
# Java library directory for additional jar files. The Java runner will load
# classes from any ".jar" files stored in this directory, as well as the * jar
# files and classes stored in traffic manager's catalog.
#
# [*java__max_connections*]
# Maximum number of simultaneous Java requests. If there are more than this
# many requests, then further requests will be queued until the earlier
# requests are completed. This setting is per-CPU, so if your traffic manager
# is running on a machine with 4 CPU cores, then each core can make this many
# requests at one time.
#
# [*java__session_age*]
# Default time to keep a Java session.
#
# [*kerberos__timeout*]
# The period of time after which an outstanding Kerberos operation will be
# cancelled, generating an error for dependent operations.
#
# [*kerberos__verbose*]
# Whether or not a traffic manager should log all Kerberos related activity.
# This is very verbose, and should only be used for diagnostic purposes.
#
# [*log__error_level*]
# The minimum severity of events/alerts that should be logged to disk. "INFO"
# will log all events; a higher severity setting will log fewer events.  More
# fine-grained control can be achieved using events and actions.
#
# [*log__flush_time*]
# How long to wait before flushing the request log files for each virtual
# server.
#
# [*log__log_file*]
# The file to log event messages to.
#
# [*log__rate*]
# The maximum number of connection errors logged per second when connection
# error reporting is enabled.
#
# [*log__reopen*]
# How long to wait before re-opening request log files, this ensures that log
# files will be recreated in the case of log rotation.
#
# [*log__time*]
# The minimum time between log messages for log intensive features such as SLM.
#
# [*log_export__auth_hec_token*]
# The HTTP Event Collector token to use for HTTP authentication with a Splunk
# server.
#
# [*log_export__auth_http*]
# The HTTP authentication method to use when exporting log entries.
#
# [*log_export__auth_password*]
# The password to use for HTTP basic authentication.
#
# [*log_export__auth_username*]
# The username to use for HTTP basic authentication.
#
# [*log_export__enabled*]
# Monitor log files and export entries to the configured endpoint.
#
# [*log_export__endpoint*]
# The URL to which log entries should be sent. Entries are sent using HTTP(S)
# POST requests.
#
# [*log_export__max_event_message_size*]
# The maximum size of any individual log entry to be exported. Log entries
# that exceed this size will be truncated. The maximum individual entry size
# must be at least "80" characters. A value of "0" means that no limit is
# imposed on the length of message for any individual entry.
#
# [*log_export__max_request_bandwidth*]
# The maximum bandwidth to be used for sending HTTP requests to the configured
# endpoint, measured in kilobits per second. A value of zero means that no
# bandwidth limit will be imposed.
#
# [*log_export__max_request_size*]
# The maximum amount of log data to export in a single request. A value of "0"
# means no limit.
#
# [*log_export__max_response_size*]
# The maximum permitted size of HTTP responses from the configured endpoint.
# Both headers and body data are included in the size calculation. A response
# exceeding this size will be treated as an error response. A value of "0"
# means that there is no limit to the size of response that will be considered
# valid.
#
# [*log_export__maximum_error_raising_period*]
# An upper limit to the interval for rate limiting all errors raised by the
# log exporter.
#
# [*log_export__minimum_error_raising_period*]
# A lower limit to the interval for rate limiting all errors raised by the log
# exporter. The interval can only be shorter than this limit if the maximum
# interval is set to be less than this minimum limit.
#
# [*log_export__request_timeout*]
# The number of seconds after which HTTP requests sent to the configured
# endpoint will be considered to have failed if no response is received. A
# value of "0" means that HTTP requests will not time out.
#
# [*log_export__tls_verify*]
# Whether the server certificate should be verified when connecting to the
# endpoint. If enabled, server certificates that do not match the server name,
# are self-signed, have expired, have been revoked, or that are signed by an
# unknown CA will be rejected.
#
# [*ospfv2__area*]
# The OSPF area in which the traffic manager will operate. May be entered in
# decimal or IPv4 address format.
#
# [*ospfv2__area_type*]
# The type of OSPF area in which the traffic manager will operate. This must
# be the same for all routers in the area, as required by OSPF.
#
# [*ospfv2__authentication_key_id_a*]
# OSPFv2 authentication key ID. If set to 0, which is the default value, the
# key is disabled.
#
# [*ospfv2__authentication_key_id_b*]
# OSPFv2 authentication key ID. If set to 0, which is the default value, the
# key is disabled.
#
# [*ospfv2__authentication_shared_secret_a*]
# OSPFv2 authentication shared secret (MD5). If set to blank, which is the
# default value, the key is disabled.
#
# [*ospfv2__authentication_shared_secret_b*]
# OSPFv2 authentication shared secret (MD5). If set to blank, which is the
# default value, the key is disabled.
#
# [*ospfv2__dead_interval*]
# The number of seconds before declaring a silent router down.
#
# [*ospfv2__enabled*]
# Whether OSPFv2 Route Health Injection is enabled
#
# [*ospfv2__hello_interval*]
# The interval at which OSPF "hello" packets are sent to the network.
#
# [*periodic_log__enabled*]
# Enable periodic logging
#
# [*periodic_log__interval*]
# Time interval in seconds for periodic logging
#
# [*periodic_log__max_archive_set_size*]
# Maximum size (in MBytes) for the archive periodic logs. When combined size
# of the archives exceeds this value, the oldest archives will be deleted. Set
# to 0 to disable archive size limit
#
# [*periodic_log__max_log_set_size*]
# Maximum size (in MBytes) for the current set of periodic logs. If this size
# is exceeded, the current set will be archived. Set to zero to disable
# archiving based on current set size.
#
# [*periodic_log__max_num_archives*]
# Maximum number of archived log sets to keep. When the number of archived
# periodic log sets exceeds this, the oldest archives will be deleted.
#
# [*periodic_log__run_count*]
# Number of periodic logs which should be archived together as a run.
#
# [*protection__conncount_size*]
# The amount of shared memory reserved for an inter-process table of combined
# connection counts, used by all Service Protection classes that have
# "per_process_connection_count" set to "No".  The amount is specified as an
# absolute size, eg 20MB.
#
# [*recent_connections__max_per_process*]
# How many recently closed connections each traffic manager process should
# save. These saved connections will be shown alongside currently active
# connections when viewing the Connections page. You should set this value to
# "0" in a benchmarking or performance-critical environment.
#
# [*recent_connections__retain_time*]
# The amount of time for which snapshots will be retained on the Connections
# page.
#
# [*recent_connections__snapshot_size*]
# The maximum number of connections each traffic manager process should show
# when viewing a snapshot on the Connections page. This value includes both
# currently active connections and saved connections. If set to "0" all active
# and saved connection will be displayed on the Connections page.
#
# [*remote_licensing__comm_channel_enabled*]
# Whether to create a Communications Channel agent to send and receive
# messages from the Services Director Registration Server. This will be
# disabled when performing self-registration with a Services Director which
# does not support this feature.
#
# [*remote_licensing__comm_channel_port*]
# The port number the Services Director instance is using for access to the
# traffic manager Communications Channel.
#
# [*remote_licensing__owner*]
# The Owner of a Services Director instance, used for self-registration.
#
# [*remote_licensing__owner_secret*]
# The secret associated with the Owner.
#
# [*remote_licensing__policy_id*]
# The auto-accept Policy ID that this instance should attempt to use.
#
# [*remote_licensing__registration_server*]
# A Services Director address for self-registration. A registration server
# should be specified as a "<ip/host>:<port>" pair.
#
# [*remote_licensing__script_timeout*]
# Time-out value for the self-register script.
#
# [*remote_licensing__server_certificate*]
# The certificate of a Services Director instance, used for self-registration.
#
# [*remote_licensing__server_certificate_secondary*]
# A secondary certificate of a Services Director instance, used while the
# Services Director is renewing its primary certificate.
#
# [*rest_api__auth_timeout*]
# The length of time after a successful request that the authentication of a
# given username and password will be cached for an IP address. A setting of 0
# disables the cache forcing every REST request to be authenticated which will
# adversely affect performance.
#
# [*rest_api__block_for_future_max*]
# Maximum amount of time in seconds to block the event queue waiting for
# unparallisable events like loading from disk.
#
# [*rest_api__enabled*]
# Whether or not the REST service is enabled.
#
# [*rest_api__http_compress_min*]
# Minimum size in bytes a response body needs to be for compression (e.g.
# gzip) to be used. Set to 0 to always use compression when available.
#
# [*rest_api__http_keep_alive_timeout*]
# The length of time in seconds an idle connection will be kept open before
# the REST API closes the connection.
#
# [*rest_api__http_max_header_length*]
# The maximum allowed length in bytes of a HTTP request's headers.
#
# [*rest_api__http_max_resource_body_length*]
# Maximum size in bytes the body of an HTTP PUT request can be for a key-value
# resource (i.e. a JSON request)
#
# [*rest_api__http_max_write_buffer*]
# Maximum size in bytes the per-connection output buffer can grow to before
# being paused.
#
# [*rest_api__http_session_timeout*]
# Maximum time in seconds to keep an idle session open for.
#
# [*rest_api__maxfds*]
# Maximum number of file descriptors that the REST API will allocate. The REST
# API must be restarted for a change to this setting to take effect.
#
# [*rest_api__proxy_map*]
# A set of symlinks that the REST API maps to actual directories. Used to add
# mirored resources so proxies work correctly.
# Type:array
# Properties:{"absolute_path"=>{"description"=>"The real path to create a
# symlinked resource to.", "type"=>"string"},
# "symlink_path"=>{"description"=>"The path to the symlinked resource.
# Intermediate resources will be created. All new resources will be hidden.",
# "type"=>"string"}}
#
# [*rest_api__replicate_absolute*]
# Configuration changes will be replicated across the cluster after this
# period of time, regardless of whether additional API requests are being made.
#
# [*rest_api__replicate_lull*]
# Configuration changes made via the REST API will be propagated across the
# cluster when no further API requests have been made for this period of time.
#
# [*rest_api__replicate_timeout*]
# The period of time after which configuration replication across the cluster
# will be cancelled if it has not completed.
#
# [*security__login_banner*]
# Banner text displayed on the Admin Server login page and before logging in
# to appliance SSH servers.
#
# [*security__login_banner_accept*]
# Whether or not users must explicitly agree to the displayed "login_banner"
# text before logging in to the Admin Server.
#
# [*security__login_delay*]
# The number of seconds before another login attempt can be made after a
# failed attempt.
#
# [*security__max_login_attempts*]
# The number of sequential failed login attempts that will cause a user
# account to be suspended.  Setting this to "0" disables this feature. To
# apply this to users who have never successfully logged in,
# "track_unknown_users" must also be enabled.
#
# [*security__max_login_external*]
# Whether or not usernames blocked due to the "max_login_attempts" limit
# should also be blocked from authentication against external services (such
# as LDAP and RADIUS).
#
# [*security__max_login_suspension_time*]
# The number of minutes to suspend users who have exceeded the
# "max_login_attempts" limit.
#
# [*security__password_allow_consecutive_chars*]
# Whether or not to allow the same character to appear consecutively in
# passwords.
#
# [*security__password_changes_per_day*]
# The maximum number of times a password can be changed in a 24-hour period.
# Set to "0" to disable this restriction.
#
# [*security__password_min_alpha_chars*]
# Minimum number of alphabetic characters a password must contain. Set to 0 to
# disable this restriction.
#
# [*security__password_min_length*]
# Minimum number of characters a password must contain. Set to "0" to disable
# this restriction.
#
# [*security__password_min_numeric_chars*]
# Minimum number of numeric characters a password must contain. Set to "0" to
# disable this restriction.
#
# [*security__password_min_special_chars*]
# Minimum number of special (non-alphanumeric) characters a password must
# contain. Set to "0" to disable this restriction.
#
# [*security__password_min_uppercase_chars*]
# Minimum number of uppercase characters a password must contain. Set to "0"
# to disable this restriction.
#
# [*security__password_reuse_after*]
# The number of times a password must have been changed before it can be
# reused. Set to "0" to disable this restriction.
#
# [*security__post_login_banner*]
# Banner text to be displayed on the appliance console after login.
#
# [*security__track_unknown_users*]
# Whether to remember past login attempts from usernames that are not known to
# exist (should be set to false for an Admin Server accessible from the public
# Internet). This does not affect the audit log.
#
# [*security__ui_page_banner*]
# Banner text to be displayed on all Admin Server pages.
#
# [*session__asp_cache_size*]
# The maximum number of entries in the ASP session persistence cache.  This is
# used for storing session mappings for ASP session persistence. Approximately
# 100 bytes will be pre-allocated per entry.
#
# [*session__ip_cache_expiry*]
# IP session persistence cache expiry time in seconds. A session will not be
# reused if the time since it was last used exceeds this value. 0 indicates no
# expiry timeout.
#
# [*session__ip_cache_size*]
# The maximum number of entries in the IP session persistence cache.  This is
# used to provide session persistence based on the source IP address.
# Approximately 100 bytes will be pre-allocated per entry.
#
# [*session__j2ee_cache_expiry*]
# J2EE session persistence cache expiry time in seconds. A session will not be
# reused if the time since it was last used exceeds this value. 0 indicates no
# expiry timeout.
#
# [*session__j2ee_cache_size*]
# The maximum number of entries in the J2EE session persistence cache.  This
# is used for storing session mappings for J2EE session persistence.
# Approximately 100 bytes will be pre-allocated per entry.
#
# [*session__ssl_cache_size*]
# The maximum number of entries in the SSL session persistence cache. This is
# used to provide session persistence based on the SSL session ID.
# Approximately 200 bytes will be pre-allocated per entry.
#
# [*session__universal_cache_expiry*]
# Universal session persistence cache expiry time in seconds. A session will
# not be reused if the time since it was last used exceeds this value. 0
# indicates no expiry timeout.
#
# [*session__universal_cache_size*]
# The maximum number of entries in the global universal session persistence
# cache.  This is used for storing session mappings for universal session
# persistence.  Approximately 100 bytes will be pre-allocated per entry.
#
# [*snmp__user_counters*]
# The number of user defined SNMP counters. Approximately 100 bytes will be
# pre-allocated at start-up per user defined SNMP counter.
#
# [*soap__idle_minutes*]
# The number of minutes that the SOAP server should remain idle before
# exiting.  The SOAP server has a short startup delay the first time a SOAP
# request is made, subsequent SOAP requests don't have this delay.
#
# [*ssl__allow_rehandshake*]
# Whether or not SSL/TLS re-handshakes should be supported. Enabling support
# for re-handshakes can expose services to Man-in-the-Middle attacks. It is
# recommended that only "safe" handshakes be permitted, or none at all.
#
# [*ssl__cache_enabled*]
# Whether or not the SSL server session cache is enabled, unless overridden by
# virtual server settings.
#
# [*ssl__cache_expiry*]
# How long the SSL session IDs for SSL decryption should be stored for.
#
# [*ssl__cache_per_virtualserver*]
# Whether an SSL session created by a given virtual server can only be resumed
# by a connection to the same virtual server.
#
# [*ssl__cache_size*]
# How many entries the SSL session ID cache should hold. This cache is used to
# cache SSL sessions to help speed up SSL handshakes when performing SSL
# decryption. Each entry will allocate approximately 1.75kB of metadata.
#
# [*ssl__cipher_suites*]
# The SSL/TLS cipher suites preference list for SSL/TLS connections, unless
# overridden by virtual server or pool settings. For information on supported
# cipher suites see the online help.
#
# [*ssl__client_cache_enabled*]
# Whether or the SSL client cache will be used, unless overridden by pool
# settings.
#
# [*ssl__client_cache_expiry*]
# How long in seconds SSL sessions should be stored in the client cache for,
# by default. Servers returning session tickets may also provide a lifetime
# hint, which will be used if it is less than this value.
#
# [*ssl__client_cache_size*]
# How many entries the SSL client session cache should hold, per child. This
# cache is used to cache SSL sessions to help speed up SSL handshakes when
# performing SSL encryption. Each entry will require approx 100 bytes of
# memory plus space for either an SSL session id or an SSL session ticket,
# which may be as small as 16 bytes or may be as large as a few kilobytes,
# depending upon the server behavior.
#
# [*ssl__client_cache_tickets_enabled*]
# Whether or not session tickets, including TLS >= 1.3 PSKs, may be requested
# and stored in the SSL client cache.
#
# [*ssl__crl_mem_size*]
# How much shared memory to allocate for loading Certificate Revocation Lists.
# This should be at least 3 times the total size of all CRLs on disk. This is
# specified as either a percentage of system RAM, "1%" for example, or an
# absolute size such as "10MB".
#
# [*ssl__diffie_hellman_client_min_modulus_size*]
# The minimum size in bits of the modulus in the domain parameters that the
# traffic manager will accept when connecting using finite field
# Diffie-Hellman key agreement as a client.
#
# [*ssl__diffie_hellman_modulus_size*]
# The size in bits of the modulus for the domain parameters used for cipher
# suites that use finite field Diffie-Hellman key agreement.
#
# [*ssl__disable_stitched_cbc_hmac*]
# Enable or disable use of "stitched" CBC/HMAC mode ciphers
#
# [*ssl__elliptic_curves*]
# The SSL/TLS elliptic curve preference list for SSL/TLS connections using TLS
# version 1.0 or higher, unless overridden by virtual server or pool settings.
# For information on supported curves see the online help.
# Type:array
# Properties:
#
# [*ssl__honor_fallback_scsv*]
# Whether or not ssl-decrypting Virtual Servers honor the Fallback SCSV to
# protect connections against downgrade attacks.
#
# [*ssl__insert_extra_fragment*]
# Whether or not SSL3 and TLS1 use one-byte fragments as a BEAST
# countermeasure.
#
# [*ssl__log_keys*]
# Whether SSL connection key logging should be available via the
# ssl.sslkeylogline() TrafficScript function. If this setting is disabled then
# ssl.sslkeylogline() will always return the empty string.
#
# [*ssl__max_handshake_message_size*]
# The maximum size (in bytes) of SSL handshake messages that SSL connections
# will accept. To accept any size of handshake message the key should be set
# to the value "0".
#
# [*ssl__middlebox_compatibility*]
# Whether or not TLS 1.3 middlebox compatibility mode as described in RFC 8446
# appendix D.4 will be used in connections to pool nodes, unless overridden by
# pool settings.
#
# [*ssl__min_rehandshake_interval*]
# If SSL3/TLS re-handshakes are supported, this defines the minimum time
# interval (in milliseconds) between handshakes on a single SSL3/TLS
# connection that is permitted.  To disable the minimum interval for
# handshakes the key should be set to the value "0".
#
# [*ssl__obscure_alert_descriptions*]
# Whether SSL/TLS alert descriptions should be obscured (where reasonable)
# when sent to a remote peer. Alert descriptions are useful for diagnosing
# SSL/TLS connection issues when connecting to a remote peer. However those
# diagnostics may provide information that an attacker could use to compromise
# the system (as a concrete example, see Moeller, B., "Security of CBC
# Ciphersuites in SSL/TLS: Problems and Countermeasures"). If not enabled,
# alert descriptions that are known to facilitate compromise will still be
# obscured.  Otherwise, if enabled, alert descriptions that can be safely
# mapped to a more general one, will be.
#
# [*ssl__ocsp_cache_size*]
# The maximum number of cached client certificate OCSP results stored. This
# cache is used to speed up OCSP checks against client certificates by caching
# results. Approximately 1040 bytes are pre-allocated per entry.
#
# [*ssl__ocsp_max_response_size*]
# Maximum size of OCSP response to accept when verifying client certificates
# during SSL decryption. 0 means unlimited.
#
# [*ssl__ocsp_stapling_default_refresh_interval*]
# How long to wait before refreshing requests on behalf of the store of
# certificate status responses used by OCSP stapling, if we don't have an
# up-to-date OCSP response.
#
# [*ssl__ocsp_stapling_maximum_refresh_interval*]
# Maximum time to wait before refreshing requests on behalf of the store of
# certificate status responses used by OCSP stapling. (0 means no maximum.)
#
# [*ssl__ocsp_stapling_mem_size*]
# How much shared memory to allocate for the store of certificate status
# responses for OCSP stapling. This should be at least 2kB times the number of
# certificates configured to use OCSP stapling. This is specified as either a
# percentage of system RAM, "1%" for example, or an absolute size such as
# "10MB".
#
# [*ssl__ocsp_stapling_minimum_refresh_interval*]
# The minimum number of seconds to wait between OCSP requests for the same
# certificate.
#
# [*ssl__ocsp_stapling_prefetch*]
# The number of seconds before an OCSP response is stale to make a new OCSP
# request.
#
# [*ssl__ocsp_stapling_time_tolerance*]
# How many seconds to allow the current time to be outside the validity time
# of an OCSP response before considering it invalid.
#
# [*ssl__ocsp_stapling_verify_response*]
# Whether the OCSP response signature should be verified before the OCSP
# response is cached.
#
# [*ssl__signature_algorithms*]
# The SSL/TLS signature algorithms preference list for SSL/TLS connections
# using TLS version 1.2 or higher, unless overridden by virtual server or pool
# settings. For information on supported algorithms see the online help.
#
# [*ssl__support_ssl3*]
# Whether or not SSL3 support is enabled.
#
# [*ssl__support_tls1*]
# Whether or not TLS1.0 support is enabled.
#
# [*ssl__support_tls1_1*]
# Whether or not TLS1.1 support is enabled.
#
# [*ssl__support_tls1_2*]
# Whether or not TLS1.2 support is enabled.
#
# [*ssl__support_tls1_3*]
# Whether or not TLS1.3 support is enabled.
#
# [*ssl__tickets_enabled*]
# Whether or not session tickets will be issued to and accepted from clients
# that support them, unless overridden by virtual server settings.
#
# [*ssl__tickets_reissue_policy*]
# When an SSL session ticket will be reissued (ie when a new ticket will be
# generated for the same SSL session).
#
# [*ssl__tickets_ticket_expiry*]
# The length of time for which an SSL session ticket will be accepted by a
# virtual server after the ticket is created. If a ticket is reissued (if
# ssl!tickets!reissue_policy is set to 'always') this time starts at the time
# when the ticket was reissued.
#
# [*ssl__tickets_ticket_key_expiry*]
# The length of time for which an auto-generated SSL ticket key will be used
# to decrypt old session ticket, before being deleted from memory. This
# setting is ignored if there are any entries in the (REST-only) SSL ticket
# keys catalog.
#
# [*ssl__tickets_ticket_key_rotation*]
# The length of time for which an auto-generated SSL ticket key will be used
# to encrypt new session tickets, before a new SSL ticket key is generated.
# The ticket encryption key will be held in memory for
# ssl!tickets!ticket_key_expiry, so that tickets encrypted using the key can
# still be decrypted and used. This setting is ignored if there are any
# entries in the (REST-only) SSL ticket keys catalog.
#
# [*ssl__tickets_time_tolerance*]
# How many seconds to allow the current time to be outside the validity time
# of an SSL ticket before considering it invalid.
#
# [*ssl__validate_server_certificates_catalog*]
# Whether the traffic manager should validate that SSL server certificates
# form a matching key pair before the certificate gets used on an SSL
# decrypting virtual server.
#
# [*ssl_hardware__accel*]
# Whether or not the SSL hardware is an "accelerator" (faster than software).
# By default the traffic manager will only use the SSL hardware if a key
# requires it (i.e. the key is stored on secure hardware and the traffic
# manager only has a placeholder/identifier key). With this option enabled,
# your traffic manager will instead try to use hardware for all SSL decrypts.
#
# [*ssl_hardware__azure_api_version*]
# The version of the Azure Key Vault REST API.
#
# [*ssl_hardware__azure_client_id*]
# The client identifier used when accessing the Microsoft Azure Key Vault.
#
# [*ssl_hardware__azure_client_secret*]
# The client secret used when accessing the Microsoft Azure Key Vault.
#
# [*ssl_hardware__azure_connect_timeout*]
# Timeout for establishing a connection to the Azure Key Vault REST API. Using
# a value of 0 will use libcurl's built-in timeout.
#
# [*ssl_hardware__azure_idle_timeout*]
# Idle timeout for a connection to the Azure Key Vault REST API. Using a value
# of 0 will deactivate the timeout.
#
# [*ssl_hardware__azure_key_list_conns*]
# The maximum number of concurrent HTTPS connections that will be used to
# retrieve the list of keys stored in an Azure Key Vault.
#
# [*ssl_hardware__azure_vault_url*]
# The URL for the REST API of the Microsoft Azure Key Vault.
#
# [*ssl_hardware__azure_verify_rest_api_cert*]
# Whether or not the Azure Key Vault REST API certificate should be verified.
#
# [*ssl_hardware__driver_pkcs11_debug*]
# Print verbose information about the PKCS11 hardware security module to the
# event log.
#
# [*ssl_hardware__driver_pkcs11_lib*]
# The location of the PKCS#11 library for your SSL hardware if it is not in a
# standard location.  The traffic manager will search the standard locations
# by default.
#
# [*ssl_hardware__driver_pkcs11_slot_desc*]
# The label of the SSL Hardware slot to use. Only required if you have
# multiple HW accelerator slots.
#
# [*ssl_hardware__driver_pkcs11_slot_type*]
# The type of SSL hardware slot to use.
#
# [*ssl_hardware__driver_pkcs11_user_pin*]
# The User PIN for the PKCS token (PKCS#11 devices only).
#
# [*ssl_hardware__failure_count*]
# The number of consecutive failures from the SSL hardware that will be
# tolerated before the traffic manager assumes its session with the device is
# invalid and tries to log in again.  This is necessary when the device
# reboots following a power failure.
#
# [*ssl_hardware__library*]
# The type of SSL hardware to use. The drivers for the SSL hardware should be
# installed and accessible to the traffic manager software.
#
# [*ssl_hardware__nworkers*]
# The maximum number of concurrent requests the traffic manager will offload
# to the accelerator device.
#
# [*ssl_hardware__queuelen*]
# The maximum number of requests that will be queued to the accelerator device.
#
# [*telemetry__autotest_schedule*]
# Instruct the telemetry system to use an extra fast schedule for autotesting
#
# [*telemetry__enabled*]
# Allow the reporting of anonymized usage data for product improvement and
# customer support purposes.
#
# [*telemetry__internal_use*]
# Tag exported data with an arbitrary string, to mark is as not being "real"
# data
#
# [*telemetry__test_schedule*]
# Instruct the telemetry system to use a fast schedule for testing
#
# [*telemetry__url*]
# Override the default URL for telemetry data export.
#
# [*trafficscript__data_local_size*]
# The maximum amount of memory available to store TrafficScript
# "data.local.set()" information. This can be specified as a percentage of
# system RAM, "5%" for example; or an absolute size such as "200MB".
#
# [*trafficscript__data_size*]
# The maximum amount of memory available to store TrafficScript "data.set()"
# information.  This can be specified as a percentage of system RAM, "5%" for
# example; or an absolute size such as "200MB".
#
# [*trafficscript__execution_time_warning*]
# Raise an event if a TrafficScript rule runs for more than this number of
# milliseconds in a single invocation. If you get such events repeatedly, you
# may want to consider re-working some of your TrafficScript rules. A value of
# 0 means no warnings will be issued.
#
# [*trafficscript__max_instr*]
# The maximum number of instructions a TrafficScript rule will run. A rule
# will be aborted if it runs more than this number of instructions without
# yielding, preventing infinite loops.
#
# [*trafficscript__memory_warning*]
# Raise an event if a TrafficScript rule requires more than this amount of
# buffered network data.  If you get such events repeatedly, you may want to
# consider re-working some of your TrafficScript rules to use less memory or
# to stream the data that they process rather than storing it all in memory.
# This setting also limits the amount of data that can be returned by
# "request.GetLine()".
#
# [*trafficscript__regex_cache_size*]
# The maximum number of regular expressions to cache in TrafficScript. Regular
# expressions will be compiled in order to speed up their use in the future.
#
# [*trafficscript__regex_match_limit*]
# The maximum number of ways TrafficScript will attempt to match a regular
# expression at each position in the subject string, before it aborts the rule
# and reports a TrafficScript error.
#
# [*trafficscript__regex_match_warn_percentage*]
# The percentage of "regex_match_limit" at which TrafficScript reports a
# performance warning.
#
# [*trafficscript__variable_pool_use*]
# Allow the "pool.use" and "pool.select" TrafficScript functions to accept
# variables instead of requiring literal strings. <br /> Enabling this feature
# has the following effects
# 1. Your traffic manager may no longer be able to know whether a pool is in
# use.
# 2. Errors for pools that aren't in use will not be hidden.
# 3. Some settings displayed for a Pool may not be appropriate for the type of
# traffic being managed.
# 4. Pool usage information on the pool edit pages and config summary may not
# be accurate.
# 5. Monitors will run for all pools (with this option disabled monitors will
# only run for Pools that are used).
#
# [*transaction_export__auto_brief*]
# The maximum buffering of transaction metadata before events are switched to
# brief mode automatically. Each child process is permitted to buffer this
# amount of verbose event data, if this buffer size is exceeded, then events
# are recorded in brief until space becomes available. A value of 0 disables
# this feature.
#
# [*transaction_export__enabled*]
# Export metadata about transactions processed by the traffic manager to an
# external location.
#
# [*transaction_export__endpoint*]
# The endpoint to which transaction metadata should be exported. The endpoint
# is specified as a hostname or IP address with a port.
#
# [*transaction_export__failure_interval*]
# The interval at which reconnection failures will be reported in the event
# log.
#
# [*transaction_export__memory*]
# The maximum amount of transaction metadata pending export to buffer. If the
# buffer size is exceeded, metadata pertaining to new transactions will be
# dropped until more buffer space becomes available.
#
# [*transaction_export__reconnect_interval*]
# The interval at which reconnection will be attempted to the analytics engine
# following a disconnection or connection failure.
#
# [*transaction_export__tls*]
# Whether the connection to the specified endpoint should be encrypted.
#
# [*transaction_export__tls_timeout*]
# The maximum time allowed to complete a TLS handshake after completing a TCP
# connection. If the TLS handshake does not complete in time, the connection
# is considered to have failed.
#
# [*transaction_export__tls_verify*]
# Whether the server certificate presented by the endpoint should be verified,
# preventing a connection from being established if the certificate does not
# match the server name, is self-signed, is expired, is revoked, or has an
# unknown CA.
#
# [*watchdog__timeout*]
# The maximum time in seconds a process can fail to update its heartbeat,
# before the watchdog considers it to have stalled.
#
# [*web_cache__avg_path_length*]
# The estimated average length of the path (including query string) for
# resources being cached. An amount of memory equal to this figure multiplied
# by max_file_num will be allocated for storing the paths for cache entries.
# This setting can be increased if your web site makes extensive use of long
# URLs.
#
# [*web_cache__blocksize*]
# The size of the blocks of shared memory that are allocated for the content
# cache.  Every entry in the content cache will use at least this amount of
# memory.  You can specify the number of bytes, kB, or MB.  Unless you know
# that you are serving almost exclusively very small or very large files,
# there is no reason to change this value.
#
# [*web_cache__disk*]
# Whether or not to use a disk-backed (typically SSD) cache.  If set to "Yes"
# cached web pages will be stored in a file on disk.  This enables the traffic
# manager to use a cache that is larger than available RAM.  The "size"
# setting should also be adjusted to select a suitable maximum size based on
# your disk space. <br /> Note that the disk caching is optimized for use with
# SSD storage.
#
# [*web_cache__disk_dir*]
# If disk caching is enabled, this sets the directory where the disk cache
# file will be stored.  The traffic manager will create a file called
# "webcache.data" in this location. <br /> Note that the disk caching is
# optimized for use with SSD storage.
#
# [*web_cache__max_byte_range_segments*]
# Maximum number of range segments allowed in a range request.  Requests
# containing more segments than this will get a 416 "Requested Range Not
# Satisfiable" response, even if the page actually contains the requested
# ranges.  This setting is useful to protect against byte-range-related DoS
# attacks.
#
# [*web_cache__max_file_num*]
# Maximum number of entries in the cache.  Approximately 0.9 KB will be
# pre-allocated per entry for metadata, this is in addition to the memory
# reserved for the content cache and for storing the paths of the cached
# resources.
#
# [*web_cache__max_file_size*]
# Largest size of a cacheable object in the cache.  This is specified as
# either a percentage of the total cache size, "2%" for example, or an
# absolute size such as "20MB".
#
# [*web_cache__max_handles*]
# Maximum number of webcache handles to allow per process. This is a limit on
# the maximum number of cached objects being simultaneously served, not a
# limit on the maximum that can be in the cache. A value of 0 indicates that
# we should use the system per-process limit on number of FDs.
#
# [*web_cache__max_path_length*]
# The maximum length of the path (including query string) for the resource
# being cached. If the path exceeds this length then it will not be added to
# the cache.
#
# [*web_cache__min_size_accept_range*]
# If a page is stored in the cache, the traffic manager will add the header
# "Accept-Ranges: bytes" to responses that are not chunked, not compressed and
# exceed a certain size (and do not have it yet). This expert tunable
# specifies the minimum size a page has to have for the traffic manager to add
# the Accept-Ranges header.
#
# [*web_cache__normalize_query*]
# Enable normalization (lexical ordering of the parameter-assignments) of the
# query string.
#
# [*web_cache__size*]
# The maximum size of the HTTP web page cache.  This is specified as either a
# percentage of system RAM, "20%" for example, or an absolute size such as
# "200MB".
#
# [*web_cache__url_store_keep_free*]
# Percentage of space to keep free in the URL store.
#
# [*web_cache__url_store_max_mallocs*]
# How many times to attempt to malloc space for a cache URL before giving up.
# 0 means never give up.
#
# [*web_cache__url_store_num_bins*]
# The number of bins to use for the URL store. 0 means no binning.
#
# [*web_cache__verbose*]
# Add an X-Cache-Info header to every HTTP response, showing whether the
# request and/or the response was cacheable.
#
# [*zoneinfo__directory*]
# The directory containing the OS-supplied timezone database ("zoneinfo")
#
# === Examples
#
# class {'brocadevtm::global_settings':
#     ensure => present,
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
class brocadevtm::global_settings (
  $ensure                                      = present,
  $basic__accepting_delay                      = 50,
  $basic__afm_enabled                          = false,
  $basic__chunk_size                           = 16384,
  $basic__client_first_opt                     = false,
  $basic__cluster_identifier                   = undef,
  $basic__license_servers                      = '[]',
  $basic__max_fds                              = 1048576,
  $basic__max_tcp_buff_mem                     = '0',
  $basic__monitor_memory_size                  = 4096,
  $basic__rate_class_limit                     = 25000,
  $basic__shared_pool_size                     = '10MB',
  $basic__slm_class_limit                      = 1024,
  $basic__so_rbuff_size                        = 0,
  $basic__so_wbuff_size                        = 0,
  $basic__socket_optimizations                 = 'auto',
  $basic__tip_class_limit                      = 10000,
  $admin__honor_fallback_scsv                  = true,
  $admin__ssl3_allow_rehandshake               = 'rfc5746',
  $admin__ssl3_ciphers                         = undef,
  $admin__ssl3_diffie_hellman_key_length       = 'dh_2048',
  $admin__ssl3_min_rehandshake_interval        = 1000,
  $admin__ssl_elliptic_curves                  = '[]',
  $admin__ssl_insert_extra_fragment            = false,
  $admin__ssl_max_handshake_message_size       = 10240,
  $admin__ssl_signature_algorithms             = undef,
  $admin__support_ssl3                         = false,
  $admin__support_tls1                         = true,
  $admin__support_tls1_1                       = true,
  $admin__support_tls1_2                       = true,
  $admin__support_tls1_3                       = true,
  $appliance__bootloader_password              = undef,
  $appliance__return_path_routing_enabled      = false,
  $aptimizer__max_dependent_fetch_size         = '2MB',
  $aptimizer__max_original_content_buffer_size = '2MB',
  $aptimizer__watchdog_interval                = 300,
  $aptimizer__watchdog_limit                   = 3,
  $auditlog__via_eventd                        = false,
  $auditlog__via_syslog                        = false,
  $auth__saml_key_lifetime                     = 86400,
  $auth__saml_key_rotation_interval            = 14400,
  $autoscaler__verbose                         = false,
  $bgp__as_number                              = 65534,
  $bgp__enabled                                = false,
  $cluster_comms__allow_update_default         = true,
  $cluster_comms__allowed_update_hosts         = '["127.0.0.1"]',
  $cluster_comms__state_sync_interval          = 3,
  $cluster_comms__state_sync_timeout           = 6,
  $connection__idle_connections_max            = 0,
  $connection__idle_timeout                    = 10,
  $connection__listen_queue_size               = 0,
  $connection__max_accepting                   = 0,
  $connection__multiple_accept                 = false,
  $connection__udp_read_multiple               = true,
  $dns__max_ttl                                = 86400,
  $dns__min_ttl                                = 86400,
  $dns__negative_expiry                        = 60,
  $dns__size                                   = 10867,
  $dns__timeout                                = 12,
  $ec2__access_key_id                          = undef,
  $ec2__awstool_timeout                        = 10,
  $ec2__metadata_server                        = undef,
  $ec2__query_server                           = undef,
  $ec2__secret_access_key                      = undef,
  $ec2__verify_query_server_cert               = false,
  $eventing__mail_interval                     = 30,
  $eventing__max_attempts                      = 10,
  $fault_tolerance__arp_count                  = 10,
  $fault_tolerance__auto_failback              = true,
  $fault_tolerance__autofailback_delay         = 10,
  $fault_tolerance__child_timeout              = 5,
  $fault_tolerance__frontend_check_ips         = '["%gateway%"]',
  $fault_tolerance__heartbeat_method           = 'unicast',
  $fault_tolerance__igmp_interval              = 30,
  $fault_tolerance__monitor_interval           = 500,
  $fault_tolerance__monitor_timeout            = 5,
  $fault_tolerance__multicast_address          = '239.100.1.1:9090',
  $fault_tolerance__unicast_port               = 9090,
  $fault_tolerance__use_bind_ip                = false,
  $fault_tolerance__verbose                    = false,
  $fips__enabled                               = false,
  $ftp__data_bind_low                          = false,
  $glb__verbose                                = false,
  $historical_activity__keep_days              = 90,
  $ip__appliance_returnpath                    = '[]',
  $java__classpath                             = undef,
  $java__command                               = 'java -server',
  $java__enabled                               = false,
  $java__lib                                   = undef,
  $java__max_connections                       = 256,
  $java__session_age                           = 86400,
  $kerberos__verbose                           = false,
  $log__error_level                            = 'info',
  $log__flush_time                             = 5,
  $log__log_file                               = '%zeushome%/zxtm/log/errors',
  $log__rate                                   = 50,
  $log__reopen                                 = 30,
  $log__time                                   = 60,
  $log_export__auth_hec_token                  = undef,
  $log_export__auth_http                       = 'none',
  $log_export__auth_password                   = undef,
  $log_export__auth_username                   = undef,
  $log_export__enabled                         = false,
  $log_export__endpoint                        = undef,
  $log_export__request_timeout                 = 30,
  $log_export__tls_verify                      = true,
  $ospfv2__area                                = '0.0.0.1',
  $ospfv2__area_type                           = 'normal',
  $ospfv2__authentication_key_id_a             = 0,
  $ospfv2__authentication_key_id_b             = 0,
  $ospfv2__authentication_shared_secret_a      = undef,
  $ospfv2__authentication_shared_secret_b      = undef,
  $ospfv2__dead_interval                       = 40,
  $ospfv2__enabled                             = false,
  $ospfv2__hello_interval                      = 10,
  $protection__conncount_size                  = '20MB',
  $recent_connections__max_per_process         = 500,
  $recent_connections__retain_time             = 60,
  $recent_connections__snapshot_size           = 500,
  $remote_licensing__comm_channel_enabled      = true,
  $remote_licensing__comm_channel_port         = 8102,
  $remote_licensing__owner                     = undef,
  $remote_licensing__owner_secret              = undef,
  $remote_licensing__policy_id                 = undef,
  $remote_licensing__registration_server       = undef,
  $remote_licensing__server_certificate        = undef,
  $rest_api__auth_timeout                      = 120,
  $rest_api__enabled                           = true,
  $rest_api__http_max_header_length            = 4096,
  $rest_api__maxfds                            = 1048576,
  $rest_api__replicate_absolute                = 20,
  $rest_api__replicate_lull                    = 5,
  $rest_api__replicate_timeout                 = 10,
  $security__login_banner                      = undef,
  $security__login_banner_accept               = false,
  $security__login_delay                       = 4,
  $security__max_login_attempts                = 0,
  $security__max_login_external                = false,
  $security__max_login_suspension_time         = 15,
  $security__password_allow_consecutive_chars  = true,
  $security__password_changes_per_day          = 0,
  $security__password_min_alpha_chars          = 0,
  $security__password_min_length               = 0,
  $security__password_min_numeric_chars        = 0,
  $security__password_min_special_chars        = 0,
  $security__password_min_uppercase_chars      = 0,
  $security__password_reuse_after              = 0,
  $security__post_login_banner                 = undef,
  $security__track_unknown_users               = false,
  $security__ui_page_banner                    = undef,
  $session__asp_cache_size                     = 32768,
  $session__ip_cache_expiry                    = 0,
  $session__ip_cache_size                      = 32768,
  $session__j2ee_cache_expiry                  = 0,
  $session__j2ee_cache_size                    = 32768,
  $session__ssl_cache_size                     = 32768,
  $session__universal_cache_expiry             = 0,
  $session__universal_cache_size               = 32768,
  $snmp__user_counters                         = 10,
  $soap__idle_minutes                          = 10,
  $ssl__allow_rehandshake                      = 'safe',
  $ssl__cache_enabled                          = true,
  $ssl__cache_expiry                           = 1800,
  $ssl__cache_per_virtualserver                = true,
  $ssl__cache_size                             = 6151,
  $ssl__cipher_suites                          = undef,
  $ssl__client_cache_enabled                   = true,
  $ssl__client_cache_expiry                    = 14400,
  $ssl__client_cache_size                      = 1024,
  $ssl__client_cache_tickets_enabled           = true,
  $ssl__crl_mem_size                           = '5MB',
  $ssl__diffie_hellman_modulus_size            = 'dh_2048',
  $ssl__elliptic_curves                        = '[]',
  $ssl__honor_fallback_scsv                    = true,
  $ssl__insert_extra_fragment                  = false,
  $ssl__log_keys                               = false,
  $ssl__max_handshake_message_size             = 10240,
  $ssl__middlebox_compatibility                = true,
  $ssl__min_rehandshake_interval               = 1000,
  $ssl__ocsp_cache_size                        = 2048,
  $ssl__ocsp_stapling_default_refresh_interval = 60,
  $ssl__ocsp_stapling_maximum_refresh_interval = 864000,
  $ssl__ocsp_stapling_mem_size                 = '1MB',
  $ssl__ocsp_stapling_time_tolerance           = 30,
  $ssl__ocsp_stapling_verify_response          = false,
  $ssl__signature_algorithms                   = undef,
  $ssl__support_ssl3                           = false,
  $ssl__support_tls1                           = true,
  $ssl__support_tls1_1                         = true,
  $ssl__support_tls1_2                         = true,
  $ssl__support_tls1_3                         = true,
  $ssl__tickets_enabled                        = true,
  $ssl__tickets_reissue_policy                 = 'never',
  $ssl__tickets_ticket_expiry                  = 14400,
  $ssl__tickets_ticket_key_expiry              = 86400,
  $ssl__tickets_ticket_key_rotation            = 14400,
  $ssl__tickets_time_tolerance                 = 30,
  $ssl__validate_server_certificates_catalog   = true,
  $ssl_hardware__accel                         = false,
  $ssl_hardware__azure_client_id               = undef,
  $ssl_hardware__azure_client_secret           = undef,
  $ssl_hardware__azure_vault_url               = undef,
  $ssl_hardware__azure_verify_rest_api_cert    = true,
  $ssl_hardware__driver_pkcs11_debug           = false,
  $ssl_hardware__driver_pkcs11_lib             = undef,
  $ssl_hardware__driver_pkcs11_slot_desc       = undef,
  $ssl_hardware__driver_pkcs11_slot_type       = 'operator',
  $ssl_hardware__driver_pkcs11_user_pin        = undef,
  $ssl_hardware__failure_count                 = 5,
  $ssl_hardware__library                       = 'none',
  $telemetry__enabled                          = true,
  $trafficscript__data_local_size              = '5%',
  $trafficscript__data_size                    = '5%',
  $trafficscript__execution_time_warning       = 500,
  $trafficscript__max_instr                    = 100000,
  $trafficscript__memory_warning               = 1048576,
  $trafficscript__regex_cache_size             = 57,
  $trafficscript__regex_match_limit            = 10000000,
  $trafficscript__regex_match_warn_percentage  = 5,
  $trafficscript__variable_pool_use            = false,
  $transaction_export__enabled                 = false,
  $transaction_export__endpoint                = undef,
  $transaction_export__tls                     = true,
  $transaction_export__tls_verify              = true,
  $watchdog__timeout                           = 5,
  $web_cache__avg_path_length                  = 512,
  $web_cache__disk                             = false,
  $web_cache__disk_dir                         = '%zeushome%/zxtm/internal',
  $web_cache__max_file_num                     = 10000,
  $web_cache__max_file_size                    = '2%',
  $web_cache__max_path_length                  = 2048,
  $web_cache__normalize_query                  = true,
  $web_cache__size                             = '20%',
  $web_cache__verbose                          = false,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring global_settings ${name}")
  vtmrest { 'global_settings':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/8.3/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/global_settings.erb'),
    type     => 'application/json',
    internal => 'global_settings',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/global_settings", {ensure => present})
    file_line { 'global_settings':
      line => 'global_settings',
      path => "${purge_state_dir}/global_settings",
    }
  }
}
