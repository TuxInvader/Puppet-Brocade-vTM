# === Class: brocadevtm::global_settings
#
# Global Settings
# General settings that apply to every machine in the cluster.
#
# === Parameters
#
# [*basic__accepting_delay*]
# How often, in milliseconds, each traffic manager child process (that isn't listening for new connections) checks to see whether it should start listening for new connections.
#
# [*basic__afm_cluster_timeout*]
# How long in seconds to wait for the application firewall control script to complete clustering operations for the application firewall.
#
# [*basic__afm_control_timeout*]
# How long in seconds to wait for the application firewall control script to complete operations such as starting and stopping the application firewall.
#
# [*basic__afm_enabled*]
# Is the application firewall enabled.
#
# [*basic__child_control_command_timeout*]
# Timeout for waiting for child processes to respond to parent control requests If a child process (zeus.zxtm, zeus.eventd, zeus.autoscaler, etc) takes longer than this number of seconds to respond to a parent control command, error messages will be logged for every multiple of this number of seconds, for example, if set to 10 seconds, a log message will be logged every 10 seconds, until the child responds or is automatically killed (see the child_control_kill_timeout setting).
#
# [*basic__child_control_kill_timeout*]
# Timeout for waiting for child processes to respond to parent control requests If a child process (zeus.zxtm, zeus.eventd, zeus.autoscaler, etc) takes longer than this number of seconds to respond to a parent control command, then the parent zeus.zxtm process will assume this process is stuck in an unresponsive loop and will kill it, log the termination event, and wait for a new process of the same type to restart. Set this to 0 to disable killing unresponsive child processes.
#
# [*basic__chunk_size*]
# The default chunk size for reading/writing requests.
#
# [*basic__client_first_opt*]
# Whether or not your traffic manager should make use of TCP optimisations to defer the processing of new client-first connections until the client has sent some data.
#
# [*basic__internal_config_logging*]
# Whether or not messages pertaining to internal configuration files should be logged to the event log.
#
# [*basic__max_fds*]
# The maximum number of file descriptors that your traffic manager will allocate.
#
# [*basic__monitor_memory_size*]
# The maximum number of nodes that can be monitored. This is used to size the shared memory, that keeps track of the state.
#
# [*basic__rate_class_limit*]
# The maximum number of Rate classes that can be created. Approximately 100 bytes will be pre-allocated per Rate class.
#
# [*basic__shared_pool_size*]
# The size of the shared memory pool used for shared storage across worker processes (e.g. bandwidth shared data).This is specified as either a percentage of system RAM, "5%" for example, or an absolute size such as "10MB".
#
# [*basic__slm_class_limit*]
# The maximum number of SLM classes that can be created. Approximately 100 bytes will be pre-allocated per SLM class.
#
# [*basic__so_rbuff_size*]
# The size of the operating system's read buffer. A value of "0" (zero) means to use the OS default; in normal circumstances this is what should be used.
#
# [*basic__so_wbuff_size*]
# The size of the operating system's write buffer. A value of "0" (zero) means to use the OS default; in normal circumstances this is what should be used.
#
# [*basic__socket_optimizations*]
# Whether or not the traffic manager should use potential network socket optimisations. If set to "auto", a decision will be made based on the host platform.
#
# [*basic__storage_shared*]
# Whether the storage for the traffic managers' configuration is shared between cluster members.
#
# [*basic__tip_class_limit*]
# The maximum number of Traffic IP Groups that can be created.
#
# [*admin__honor_fallback_scsv*]
# Whether or not the admin server, the internal control port and the config daemon honor the Fallback SCSV to protect connections against downgrade attacks.
#
# [*admin__ssl3_allow_rehandshake*]
# Whether or not SSL3/TLS re-handshakes should be supported for admin server and internal connections.
#
# [*admin__ssl3_ciphers*]
# The SSL ciphers to use for admin server and internal connections. For information on supported ciphers see the online help.
#
# [*admin__ssl3_diffie_hellman_key_length*]
# The length in bits of the Diffie-Hellman key for ciphers that use Diffie-Hellman key agreement for admin server and internal connections.
#
# [*admin__ssl3_min_rehandshake_interval*]
# If SSL3/TLS re-handshakes are supported on the admin server, this defines the minimum time interval (in milliseconds) between handshakes on a single SSL3/TLS connection that is permitted.  To disable the minimum interval for handshakes the key should be set to the value "0".
#
# [*admin__ssl_insert_extra_fragment*]
# Whether or not SSL3 and TLS1 use one-byte fragments as a BEAST countermeasure for admin server and internal connections.
#
# [*admin__ssl_max_handshake_message_size*]
# The maximum size (in bytes) of SSL handshake messages that the admin server and internal connections will accept. To accept any size of handshake message the key should be set to the value "0".
#
# [*admin__ssl_prevent_timing_side_channels*]
# Take performance degrading steps to prevent exposing timing side-channels with SSL3 and TLS used by the admin server and internal connections.
#
# [*admin__ssl_signature_algorithms*]
# The SSL signature algorithms preference list for admin and internal connections using TLS version 1.2 or higher. For information on supported algorithms see the online help.
#
# [*admin__support_ssl2*]
# Whether or not SSL2 support is enabled for admin server and internal connections.
#
# [*admin__support_ssl3*]
# Whether or not SSL3 support is enabled for admin server and internal connections.
#
# [*admin__support_tls1*]
# Whether or not TLS1.0 support is enabled for admin server and internal connections.
#
# [*admin__support_tls11*]
# Whether or not TLS1.1 support is enabled for admin server and internal connections.
#
# [*admin__support_tls12*]
# Whether or not TLS1.2 support is enabled for admin server and internal connections.
#
# [*appliance__bootloader_password*]
# The password used to protect the bootloader. An empty string means there will be no protection.
#
# [*appliance__manage_ncipher*]
# Whether or not we should manage the nCipher Support Software automatically.
#
# [*appliance__nethsm_esn*]
# The ESN (electronic serial number) for the NetHSM.
#
# [*appliance__nethsm_hash*]
# The key hash for the NetHSM.
#
# [*appliance__nethsm_ip*]
# The IP address of the nCipher NetHSM to use.
#
# [*appliance__nethsm_ncipher_rfs*]
# The IP address of the nCipher Remote File System to use.
#
# [*appliance__return_path_routing_enabled*]
# Whether or not the traffic manager will attempt to route response packets back to clients via the same route on which the corresponding request arrived. 
 Note that this applies only to the last hop of the route - the behaviour of upstream routers cannot be altered by the traffic manager.
#
# [*aptimizer__cache_entry_lifetime*]
# The period of time (in seconds) that unaccessed cache entries will be retained by aptimizer.
#
# [*aptimizer__cache_entry_limit*]
# The maximum number of cache entries that will be retained by aptimizer before removing old entries to make room for new ones.
#
# [*aptimizer__default_profile*]
# The Profile to use by default if no mappings are configured (or if Aptimizer is licensed in Express mode)
#
# [*aptimizer__default_scope*]
# The Scope to use by default if no mappings are configured (or if Aptimizer is licensed in Express mode)
#
# [*aptimizer__dependent_fetch_timeout*]
# How long to wait for dependent resource fetches (default 30 seconds).
#
# [*aptimizer__enable_state_dump*]
# Whether or not the Aptimizer state will be dumped if "/aptimizer-state-dump" is appended to an Aptimized URL.
#
# [*aptimizer__ipc_timeout*]
# The time after which connections between the traffic manager and Aptimizer processes will be closed, should an optimization job take considerably longer than expected.
#
# [*aptimizer__max_concurrent_jobs*]
# How many direct jobs can be in progress before optimization jobs start getting rejected by aptimizer
#
# [*aptimizer__max_dependent_fetch_size*]
# The maximum size of a dependent resource that can undergo Aptimizer optimization. Any content larger than this size will not be optimized. Units of KB and MB can be used, no postfix denotes bytes. A value of 0 disables the limit.
#
# [*aptimizer__max_original_content_buffer_size*]
# The maximum size of unoptimized content buffered in the traffic manager for a single backend response that is undergoing Aptimizer optimization. Responses larger than this will not be optimized. Note that if the backend response is compressed then this setting pertains to the compressed size, before Aptimizer decompresses it. Units of KB and MB can be used, no postfix denotes bytes. Value range is 1 - 128MB.
#
# [*aptimizer__queue_buffer_size*]
# The size in bytes of the operating system buffer which is used to send request URLs and data to Aptimizer and return optimized resources from Aptimizer. A larger buffer will allow a greater number of simultaneous resources to be optimized, particularly if a large number of requests are made at the same time, for example an HTML page containing hundreds of images to optimize. If this is set to zero, the default operating system buffer size will be used.
#
# [*aptimizer__resource_lifetime*]
# The period of time (in seconds) that resource data is retained by aptimizer after it is no longer actively in use.
#
# [*aptimizer__resource_memory_limit*]
# The maximum amount of memory the cache is allowed to have pinned. Once it goes over that limit, it starts releasing resource data in LRU order.
#
# [*aptimizer__watchdog_interval*]
# The period of time (in seconds) after which a previous failure will no longer count towards the watchdog limit.
#
# [*aptimizer__watchdog_limit*]
# The maximum number of times the Aptimizer sub-process will be started or restarted within the interval defined by the aptimizer!watchdog_interval setting. If the process fails this many times, it must be restarted manually from the Diagnose page.  Zero means no limit.
#
# [*autoscaler__slm_interval*]
# The interval at which the parent sends new SLM status to the autoscaler.
#
# [*autoscaler__verbose*]
# Whether or not detailed messages about the autoscaler's activity are written to the error log.
#
# [*bandwidth__license_sharing*]
# For the global BW limits, how the bandwidth allocation should be shared between consumers. In 'pooled' mode, the allocation is shared between all consumers, who can write as much data as they want until the pool of data is exhausted. In 'quota' mode, bandwidth is divided between consumers, who can write only as much as they are allocated. Any unused bandwidth will be lost.
#
# [*bandwidth__pooled_min_write*]
# For the global BW limits using 'pooled' bandwidth allocation sharing between consumers, when the license limit is reached the allowance will be evenly distributed between the remaining consumers. Each consumer will, however be permitted to write at least this much data.
#
# [*cluster_comms__allow_update_default*]
# The default value of "allow_update" for new cluster members.  If you have cluster members joining from less trusted locations (such as cloud instances) this can be set to "false" in order to make them effectively "read-only" cluster members.
#
# [*cluster_comms__allowed_update_hosts*]
# The hosts that can contact the internal administration port on each traffic manager.  This should be a list containing IP addresses, CIDR IP subnets, and "localhost"; or it can be set to "all" to allow any host to connect.
# Type:array, Details:
#
# [*cluster_comms__state_sync_interval*]
# How often to propagate the session persistence and bandwidth information to other traffic managers in the same cluster. Set this to "0" (zero) to disable propagation.<br /> Note that a cluster using "unicast" heartbeat messages cannot turn off these messages.
#
# [*cluster_comms__state_sync_timeout*]
# The maximum amount of time to wait when propagating session persistence and bandwidth information to other traffic managers in the same cluster. Once this timeout is hit the transfer is aborted and a new connection created.
#
# [*connection__idle_connections_max*]
# The maximum number of unused HTTP keepalive connections with back-end nodes that the traffic manager should maintain for re-use.  Setting this to "0" (zero) will cause the traffic manager to auto-size this parameter based on the available number of file-descriptors.
#
# [*connection__idle_timeout*]
# How long an unused HTTP keepalive connection should be kept before it is discarded.
#
# [*connection__listen_queue_size*]
# The listen queue size for managing incoming connections. It may be necessary to increase the system's listen queue size if this value is altered.  If the value is set to "0" then the default system setting will be used.
#
# [*connection__max_accepting*]
# Number of processes that should accept new connections. Only this many traffic manager child processes will listen for new connections at any one time. Setting this to "0" (zero) will cause your traffic manager to select an appropriate default value based on the architecture and number of CPUs.
#
# [*connection__multiple_accept*]
# Whether or not the traffic manager should try to read multiple new connections each time a new client connects. This can improve performance under some very specific conditions. However, in general it is recommended that this be set to 'false'.
#
# [*dns__max_ttl*]
# Maximum Time To Live (expiry time) for entries in the DNS cache.
#
# [*dns__min_ttl*]
# Minimum Time To Live (expiry time) for entries in the DNS cache.
#
# [*dns__negative_expiry*]
# Expiry time for failed lookups in the DNS cache.
#
# [*dns__size*]
# Maximum number of entries in the DNS cache.
#
# [*dns__timeout*]
# Timeout for receiving a response from a DNS server.
#
# [*dns_autoscale__resolver*]
# The IP address and port number of the DNS server to use for DNS-derived autoscaling, in the form addr:port. This is intended for test and debug purposes, and will override the configuration of the system resolver, which is usually defined in /etc/resolv.conf
#
# [*ec2__access_key_id*]
# Amazon EC2 Access Key ID.
#
# [*ec2__action_timeout*]
# How long, in seconds, the traffic manager should wait while associating or disassociating an Elastic IP to the instance.
#
# [*ec2__secret_access_key*]
# Amazon EC2 Secret Access Key.
#
# [*ec2__verify_query_server_cert*]
# Whether to verify Amazon EC2 endpoint's certificate using CA(s) present in SSL Certificate Authorities Catalog.
#
# [*ec2__vpc_decluster_on_stop*]
# Whether to decluster the traffic manager running inside vpc when the instance stops.
#
# [*eventing__mail_interval*]
# The minimum length of time that must elapse between alert emails being sent.  Where multiple alerts occur inside this timeframe, they will be retained and sent within a single email rather than separately.
#
# [*eventing__max_attempts*]
# The number of times to attempt to send an alert email before giving up.
#
# [*fault_tolerance__arp_count*]
# The number of ARP packets a traffic manager should send when an IP address is raised.
#
# [*fault_tolerance__auto_failback*]
# Whether or not traffic IPs automatically move back to machines that have recovered from a failure and have dropped their traffic IPs.
#
# [*fault_tolerance__frontend_check_ips*]
# The IP addresses used to check front-end connectivity. Set this to an empty string if the traffic manager is on an Intranet with no external connectivity.
# Type:array, Details:
#
# [*fault_tolerance__heartbeat_method*]
# The method traffic managers should use to exchange cluster heartbeat messages.
#
# [*fault_tolerance__igmp_interval*]
# The interval between unsolicited periodic IGMP Membership Report messages for Multi-Hosted Traffic IP Groups.
#
# [*fault_tolerance__monitor_interval*]
# The frequency, in milliseconds, that each traffic manager machine should check and announce its connectivity.
#
# [*fault_tolerance__monitor_timeout*]
# How long, in seconds, each traffic manager should wait for a response from its connectivity tests or from other traffic manager machines before registering a failure.
#
# [*fault_tolerance__multicast_address*]
# The multicast address and port to use to exchange cluster heartbeat messages.
#
# [*fault_tolerance__routing_sw_run_ribd*]
# Whether the ribd routing daemon is to be run. The routing software needs to be restarted for this change to take effect.
#
# [*fault_tolerance__routing_sw_watchdog_interval*]
# The period of time in seconds after which a failure will no longer count towards the watchdog limit.
#
# [*fault_tolerance__routing_sw_watchdog_limit*]
# The maximum number of times the routing software suite of processes will be started or restarted within the interval defined by the flipper!routing_sw_watchdog_interval setting. If the routing software fails this many times within the interval, it will be stopped and can only be restarted manually from the Diagnose page or by switching OSPF off and on again. Zero means no limit.
#
# [*fault_tolerance__tipv6_raise_deprecated*]
# Mark Traffic IPv6 addresses as "deprecated" to prevent their use during IPv6 source selection.
#
# [*fault_tolerance__unicast_port*]
# The unicast UDP port to use to exchange cluster heartbeat messages.
#
# [*fault_tolerance__use_bind_ip*]
# Whether or not cluster heartbeat messages should only be sent and received over the management network.
#
# [*fault_tolerance__verbose*]
# Whether or not a traffic manager should log all connectivity tests.  This is very verbose, and should only be used for diagnostic purposes.
#
# [*fips__enabled*]
# Enable FIPS Mode (requires software restart).
#
# [*ftp__data_bind_low*]
# Whether or not the traffic manager should permit use of FTP data connection source ports lower than 1024.  If "No" the traffic manager can completely drop root privileges, if "Yes" some or all privileges may be retained in order to bind to low ports.
#
# [*glb__verbose*]
# Write a message to the logs for every DNS query that is load balanced, showing the source IP address and the chosen datacenter.
#
# [*historical_activity__keep_days*]
# Number of days to store historical traffic information, if set to "0" the data will be kept indefinitely.
#
# [*ip__appliance_returnpath*]
# A table of MAC to IP address mappings for each router where return path routing is required.
# Type:array, Details:{"mac"=>{"description"=>"The MAC address of a router the software is connected to.", "type"=>"string"}, "ipv4"=>{"description"=>"The MAC address to IPv4 address mapping of a router the software is connected to. The \"*\" (asterisk) in the key name is the MAC address, the value is the IP address.", "type"=>"string"}, "ipv6"=>{"description"=>"The MAC address to IPv6 address mapping of a router the software is connected to. The \"*\" (asterisk) in the key name is the MAC address, the value is the IP address.", "type"=>"string"}}
#
# [*java__classpath*]
# CLASSPATH to use when starting the Java runner.
#
# [*java__command*]
# Java command to use when starting the Java runner, including any additional options.
#
# [*java__enabled*]
# Whether or not Java support should be enabled.  If this is set to "No", then your traffic manager will not start any Java processes. Java support is only required if you are using the TrafficScript "java.run()" function.
#
# [*java__lib*]
# Java library directory for additional jar files. The Java runner will load classes from any ".jar" files stored in this directory, as well as the * jar files and classes stored in traffic manager's catalog.
#
# [*java__max_connections*]
# Maximum number of simultaneous Java requests. If there are more than this many requests, then further requests will be queued until the earlier requests are completed. This setting is per-CPU, so if your traffic manager is running on a machine with 4 CPU cores, then each core can make this many requests at one time.
#
# [*java__session_age*]
# Default time to keep a Java session.
#
# [*kerberos__timeout*]
# The period of time after which an outstanding Kerberos operation will be cancelled, generating an error for dependent operations.
#
# [*kerberos__verbose*]
# Whether or not a traffic manager should log all Kerberos related activity.  This is very verbose, and should only be used for diagnostic purposes.
#
# [*log__error_level*]
# The minimum severity of events/alerts that should be logged to disk. "INFO" will log all events; a higher severity setting will log fewer events.  More fine-grained control can be achieved using events and actions.
#
# [*log__flush_time*]
# How long to wait before flushing the request log files for each virtual server.
#
# [*log__log_file*]
# The file to log event messages to.
#
# [*log__rate*]
# The maximum number of connection errors logged per second when connection error reporting is enabled.
#
# [*log__reopen*]
# How long to wait before re-opening request log files, this ensures that log files will be recreated in the case of log rotation.
#
# [*log__time*]
# The minimum time between log messages for log intensive features such as SLM.
#
# [*ospfv2__area*]
# The OSPF area in which the traffic manager will operate. May be entered in decimal or IPv4 address format.
#
# [*ospfv2__area_type*]
# The type of the OSPF area in which the traffic manager will operate. This must be the same for all routers in the area, as required by OSPF.
#
# [*ospfv2__authentication_key_id_a*]
# OSPFv2 authentication key ID. If set to 0, the key is disabled. If there are no enabled keys, OSPFv2 authentication is not used.
#
# [*ospfv2__authentication_key_id_b*]
# OSPFv2 authentication key ID. If set to 0, the key is disabled. If there are no enabled keys, OSPFv2 authentication is not used.
#
# [*ospfv2__authentication_shared_secret_a*]
# OSPFv2 authentication shared secret (MD5). If set to blank, the key is disabled. If there are no enabled keys, OSPFv2 authentication is not used.
#
# [*ospfv2__authentication_shared_secret_b*]
# OSPFv2 authentication shared secret (MD5). If set to blank, the key is disabled. If there are no enabled keys, OSPFv2 authentication is not used.
#
# [*ospfv2__enabled*]
# Whether OSPFv2 Route Health Injection is enabled
#
# [*ospfv2__hello_interval*]
# The interval at which OSPF "hello" packets are sent to the network.
#
# [*ospfv2__router_dead_interval*]
# The number of seconds before declaring a silent router down.
#
# [*periodic_log__enabled*]
# Enable periodic logging
#
# [*periodic_log__interval*]
# Time interval in seconds for periodic logging
#
# [*periodic_log__max_archive_set_size*]
# Maximum size (in MBytes) for the archive periodic logs. When combined size of the archives exceeds this value, the oldest archives will be deleted. Set to 0 to disable archive size limit
#
# [*periodic_log__max_log_set_size*]
# Maximum size (in MBytes) for the current set of periodic logs. If this size is exceeded, the current set will be archived. Set to zero to disable archiving based on current set size.
#
# [*periodic_log__max_num_archives*]
# Maximum number of archived log sets to keep. When the number of archived periodic log sets exceeds this, the oldest archives will be deleted.
#
# [*periodic_log__run_count*]
# Number of periodic logs which should be archived together as a run.
#
# [*protection__conncount_size*]
# The amount of shared memory reserved for an inter-process table of combined connection counts, used by all Service Protection classes that have "per_process_connection_count" set to "No".  The amount is specified as an absolute size, eg 20MB.
#
# [*recent_connections__max_per_process*]
# How many recently closed connections each traffic manager process should save. These saved connections will be shown alongside currently active connections when viewing the Connections page. You should set this value to "0" in a benchmarking or performance-critical environment.
#
# [*recent_connections__retain_time*]
# The amount of time for which snapshots will be retained on the Connections page.
#
# [*recent_connections__snapshot_size*]
# The maximum number of connections each traffic manager process should show when viewing a snapshot on the Connections page. This value includes both currently active connections and saved connections. If set to "0" all active and saved connection will be displayed on the Connections page.
#
# [*rest_api__auth_timeout*]
# The length of time after a successful request that the authentication of a given username and password will be cached for an IP address. A setting of 0 disables the cache forcing every REST request to be authenticated which will adversely affect performance.
#
# [*rest_api__enabled*]
# Whether or not the REST service is enabled.
#
# [*rest_api__http_max_header_length*]
# The maximum allowed length in bytes of a HTTP request's headers.
#
# [*rest_api__proxy_map*]
# A set of symlinks that the REST API maps to actual directories. Used to add mirored resources so proxies work correctly.
# Type:array, Details:{"absolute_path"=>{"description"=>"The real path to create a symlinked resource to.", "type"=>"string"}, "symlink_path"=>{"description"=>"The path to the symlinked resource. Intermediate resources will be created. All new resources will be hidden.", "type"=>"string"}}
#
# [*rest_api__replicate_absolute*]
# Configuration changes will be replicated across the cluster after this period of time, regardless of whether additional API requests are being made.
#
# [*rest_api__replicate_lull*]
# Configuration changes made via the REST API will be propagated across the cluster when no further API requests have been made for this period of time.
#
# [*rest_api__replicate_timeout*]
# The period of time after which configuration replication across the cluster will be cancelled if it has not completed.
#
# [*security__login_banner*]
# Banner text displayed on the Admin Server login page and before logging in to appliance SSH servers.
#
# [*security__login_banner_accept*]
# Whether or not users must explicitly agree to the displayed "login_banner" text before logging in to the Admin Server.
#
# [*security__login_delay*]
# The number of seconds before another login attempt can be made after a failed attempt.
#
# [*security__max_login_attempts*]
# The number of sequential failed login attempts that will cause a user account to be suspended.  Setting this to "0" disables this feature. To apply this to users who have never successfully logged in, "track_unknown_users" must also be enabled.
#
# [*security__max_login_external*]
# Whether or not usernames blocked due to the "max_login_attempts" limit should also be blocked from authentication against external services (such as LDAP and RADIUS).
#
# [*security__max_login_suspension_time*]
# The number of minutes to suspend users who have exceeded the "max_login_attempts" limit.
#
# [*security__password_allow_consecutive_chars*]
# Whether or not to allow the same character to appear consecutively in passwords.
#
# [*security__password_changes_per_day*]
# The maximum number of times a password can be changed in a 24-hour period. Set to "0" to disable this restriction.
#
# [*security__password_min_alpha_chars*]
# Minimum number of alphabetic characters a password must contain. Set to 0 to disable this restriction.
#
# [*security__password_min_length*]
# Minimum number of characters a password must contain. Set to "0" to disable this restriction.
#
# [*security__password_min_numeric_chars*]
# Minimum number of numeric characters a password must contain. Set to "0" to disable this restriction.
#
# [*security__password_min_special_chars*]
# Minimum number of special (non-alphanumeric) characters a password must contain. Set to "0" to disable this restriction.
#
# [*security__password_min_uppercase_chars*]
# Minimum number of uppercase characters a password must contain. Set to "0" to disable this restriction.
#
# [*security__password_reuse_after*]
# The number of times a password must have been changed before it can be reused. Set to "0" to disable this restriction.
#
# [*security__post_login_banner*]
# Banner text to be displayed on the appliance console after login.
#
# [*security__track_unknown_users*]
# Whether to remember past login attempts from usernames that are not known to exist (should be set to false for an Admin Server accessible from the public Internet). This does not affect the audit log.
#
# [*security__ui_page_banner*]
# Banner text to be displayed on all Admin Server pages.
#
# [*session__asp_cache_size*]
# The maximum number of entries in the ASP session cache.  This is used for storing session mappings for ASP session persistence. Approximately 100 bytes will be pre-allocated per entry.
#
# [*session__ip_cache_size*]
# The maximum number of entries in the IP session cache.  This is used to provide session persistence based on the source IP address. Approximately 100 bytes will be pre-allocated per entry.
#
# [*session__j2ee_cache_size*]
# The maximum number of entries in the J2EE session cache.  This is used for storing session mappings for J2EE session persistence. Approximately 100 bytes will be pre-allocated per entry.
#
# [*session__ssl_cache_size*]
# The maximum number of entries in the SSL session persistence cache. This is used to provide session persistence based on the SSL session ID.  Approximately 200 bytes will be pre-allocated per entry.
#
# [*session__universal_cache_size*]
# The maximum number of entries in the global universal session cache.  This is used for storing session mappings for universal session persistence.  Approximately 100 bytes will be pre-allocated per entry.
#
# [*snmp__user_counters*]
# The number of user defined SNMP counters. Approximately 100 bytes will be pre-allocated at start-up per user defined SNMP counter.
#
# [*soap__idle_minutes*]
# The number of minutes that the SOAP server should remain idle before exiting.  The SOAP server has a short startup delay the first time a SOAP request is made, subsequent SOAP requests don't have this delay.
#
# [*ssl__cache_expiry*]
# How long the SSL session IDs for SSL decryption should be stored for.
#
# [*ssl__cache_per_virtualserver*]
# Whether an SSL session created by a given virtual server can only be resumed by a connection to the same virtual server.
#
# [*ssl__cache_size*]
# How many entries the SSL session ID cache should hold. This cache is used to cache SSL sessions to help speed up SSL handshakes when performing SSL decryption. To turn off SSL session resumption, set this key to the value "0". Each entry will allocate approximately 1.5kB of metadata.
#
# [*ssl__crl_mem_size*]
# How much shared memory to allocate for loading Certificate Revocation Lists. This should be at least 3 times the total size of all CRLs on disk. This is specified as either a percentage of system RAM, "1%" for example, or an absolute size such as "10MB".
#
# [*ssl__disable_stitched_cbc_hmac*]
# Enable or disable use of "stitched" CBC/HMAC mode ciphers
#
# [*ssl__honor_fallback_scsv*]
# Whether or not ssl-decrypting Virtual Servers honor the Fallback SCSV to protect connections against downgrade attacks.
#
# [*ssl__insert_extra_fragment*]
# Whether or not SSL3 and TLS1 use one-byte fragments as a BEAST countermeasure.
#
# [*ssl__max_handshake_message_size*]
# The maximum size (in bytes) of SSL handshake messages that SSL connections will accept. To accept any size of handshake message the key should be set to the value "0".
#
# [*ssl__ocsp_cache_size*]
# The maximum number of cached client certificate OCSP results stored. This cache is used to speed up OCSP checks against client certificates by caching results. Approximately 1040 bytes are pre-allocated per entry.
#
# [*ssl__ocsp_max_response_size*]
# Maximum size of OCSP response to accept when verifying client certificates during SSL decryption. 0 means unlimited.
#
# [*ssl__ocsp_stapling_default_refresh_interval*]
# How long to wait before refreshing requests on behalf of the store of certificate status responses used by OCSP stapling, if we don't have an up-to-date OCSP response.
#
# [*ssl__ocsp_stapling_maximum_refresh_interval*]
# Maximum time to wait before refreshing requests on behalf of the store of certificate status responses used by OCSP stapling. (0 means no maximum.)
#
# [*ssl__ocsp_stapling_mem_size*]
# How much shared memory to allocate for the store of certificate status responses for OCSP stapling. This should be at least 2kB times the number of certificates configured to use OCSP stapling. This is specified as either a percentage of system RAM, "1%" for example, or an absolute size such as "10MB".
#
# [*ssl__ocsp_stapling_minimum_refresh_interval*]
# The minimum number of seconds to wait between OCSP requests for the same certificate.
#
# [*ssl__ocsp_stapling_prefetch*]
# The number of seconds before an OCSP response is stale to make a new OCSP request.
#
# [*ssl__ocsp_stapling_time_tolerance*]
# How many seconds to allow the current time to be outside the validity time of an OCSP response before considering it invalid.
#
# [*ssl__ocsp_stapling_verify_response*]
# Whether the OCSP response signature should be verified before the OCSP response is cached.
#
# [*ssl__prevent_timing_side_channels*]
# Take performance degrading steps to prevent exposing timing side-channels with SSL3 and TLS.
#
# [*ssl__signature_algorithms*]
# The SSL signature algorithms preference list for SSL connections unless overridden by virtual server or pool settings. For information on supported algorithms see the online help.
#
# [*ssl__ssl3_allow_rehandshake*]
# Whether or not SSL3/TLS re-handshakes should be supported. Enabling support for re-handshakes can expose services to Man-in-the-Middle attacks. It is recommended that only "safe" handshakes be permitted, or none at all.
#
# [*ssl__ssl3_ciphers*]
# The SSL ciphers to use. For information on supported ciphers see the online help.
#
# [*ssl__ssl3_diffie_hellman_key_length*]
# The length in bits of the Diffie-Hellman key for ciphers that use Diffie-Hellman key agreement.
#
# [*ssl__ssl3_min_rehandshake_interval*]
# If SSL3/TLS re-handshakes are supported, this defines the minimum time interval (in milliseconds) between handshakes on a single SSL3/TLS connection that is permitted.  To disable the minimum interval for handshakes the key should be set to the value "0".
#
# [*ssl__support_ssl2*]
# Whether or not SSL2 support is enabled.
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
# [*ssl_hardware__accel*]
# Whether or not the SSL hardware is an "accelerator" (faster than software). By default the traffic manager will only use the SSL hardware if a key requires it (i.e. the key is stored on secure hardware and the traffic manager only has a placeholder/identifier key). With this option enabled, your traffic manager will instead try to use hardware for all SSL decrypts.
#
# [*ssl_hardware__driver_pkcs11_debug*]
# Print verbose information about the PKCS11 hardware security module to the event log.
#
# [*ssl_hardware__driver_pkcs11_lib*]
# The location of the PKCS#11 library for your SSL hardware if it is not in a standard location.  The traffic manager will search the standard locations by default.
#
# [*ssl_hardware__driver_pkcs11_slot_desc*]
# The label of the SSL Hardware slot to use. Only required if you have multiple HW accelerator slots.
#
# [*ssl_hardware__driver_pkcs11_slot_type*]
# The type of SSL hardware slot to use.
#
# [*ssl_hardware__driver_pkcs11_user_pin*]
# The User PIN for the PKCS token (PKCS#11 devices only).
#
# [*ssl_hardware__failure_count*]
# The number of consecutive failures from the SSL hardware that will be tolerated before the traffic manager assumes its session with the device is invalid and tries to log in again.  This is necessary when the device reboots following a power failure.
#
# [*ssl_hardware__library*]
# The type of SSL hardware to use. The drivers for the SSL hardware should be installed and accessible to the traffic manager software.
#
# [*trafficscript__array_elements*]
# The amount of storage that will be allocated to array elements in TrafficScript. If more elements are required then the necessary memory will be allocated during the execution of the rule.
#
# [*trafficscript__data_local_size*]
# The maximum amount of memory available to store TrafficScript "data.local.set()" information. This can be specified as a percentage of system RAM, "5%" for example; or an absolute size such as "200MB".
#
# [*trafficscript__data_size*]
# The maximum amount of memory available to store TrafficScript "data.set()" information.  This can be specified as a percentage of system RAM, "5%" for example; or an absolute size such as "200MB".
#
# [*trafficscript__execution_time_warning*]
# Raise an event if a TrafficScript rule runs for more than this number of milliseconds in a single invocation. If you get such events repeatedly, you may want to consider re-working some of your TrafficScript rules. A value of 0 means no warnings will be issued.
#
# [*trafficscript__max_instr*]
# The maximum number of instructions a TrafficScript rule will run. A rule will be aborted if it runs more than this number of instructions without yielding, preventing infinite loops.
#
# [*trafficscript__memory_warning*]
# Raise an event if a TrafficScript rule requires more than this amount of buffered network data.  If you get such events repeatedly, you may want to consider re-working some of your TrafficScript rules to use less memory or to stream the data that they process rather than storing it all in memory. This setting also limits the amount of data that can be returned by "request.GetLine()".
#
# [*trafficscript__regex_cache_size*]
# The maximum number of regular expressions to cache in TrafficScript. Regular expressions will be compiled in order to speed up their use in the future.
#
# [*trafficscript__regex_match_limit*]
# The maximum number of ways TrafficScript will attempt to match a regular expression at each position in the subject string, before it aborts the rule and reports a TrafficScript error.
#
# [*trafficscript__regex_match_warn_percentage*]
# The percentage of "regex_match_limit" at which TrafficScript reports a performance warning.
#
# [*trafficscript__variable_pool_use*]
# Allow the "pool.use" and "pool.select" TrafficScript functions to accept variables instead of requiring literal strings. <br /> Enabling this feature has the following effects
1. Your traffic manager may no longer be able to know whether a pool is in use.
2. Errors for pools that aren't in use will not be hidden.
3. Some settings displayed for a Pool may not be appropriate for the type of traffic being managed.
4. Pool usage information on the pool edit pages and config summary may not be accurate.
5. Monitors will run for all pools (with this option disabled monitors will only run for Pools that are used).
#
# [*web_cache__avg_path_length*]
# The estimated average length of the path (including query string) for resources being cached. An amount of memory equal to this figure multiplied by max_file_num will be allocated for storing the paths for cache entries. This setting can be increased if your web site makes extensive use of long URLs.
#
# [*web_cache__disk*]
# Whether or not to use a disk-backed (typically SSD) cache.  If set to "Yes" cached web pages will be stored in a file on disk.  This enables the traffic manager to use a cache that is larger than available RAM.  The "size" setting should also be adjusted to select a suitable maximum size based on your disk space. <br /> Note that the disk caching is optimized for use with SSD storage.
#
# [*web_cache__disk_dir*]
# If disk caching is enabled, this sets the directory where the disk cache file will be stored.  The traffic manager will create a file called "webcache.data" in this location. <br /> Note that the disk caching is optimized for use with SSD storage.
#
# [*web_cache__max_file_num*]
# Maximum number of entries in the cache.  Approximately 0.9 KB will be pre-allocated per entry for metadata, this is in addition to the memory reserved for the content cache and for storing the paths of the cached resources.
#
# [*web_cache__max_file_size*]
# Largest size of a cacheable object in the cache.  This is specified as either a percentage of the total cache size, "2%" for example, or an absolute size such as "20MB".
#
# [*web_cache__max_path_length*]
# The maximum length of the path (including query string) for the resource being cached. If the path exceeds this length then it will not be added to the cache.
#
# [*web_cache__normalize_query*]
# Enable normalization (lexical ordering of the parameter-assignments) of the query string.
#
# [*web_cache__size*]
# The maximum size of the HTTP web page cache.  This is specified as either a percentage of system RAM, "20%" for example, or an absolute size such as "200MB".
#
# [*web_cache__verbose*]
# Add an X-Cache-Info header to every HTTP response, showing whether the request and/or the response was cacheable.
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
  $ensure = present,
  $basic__accepting_delay                      = 50,
  $basic__afm_enabled                          = false,
  $basic__chunk_size                           = 16384,
  $basic__client_first_opt                     = false,
  $basic__max_fds                              = 1048576,
  $basic__monitor_memory_size                  = 4096,
  $basic__rate_class_limit                     = 25000,
  $basic__shared_pool_size                     = "10MB",
  $basic__slm_class_limit                      = 1024,
  $basic__so_rbuff_size                        = 0,
  $basic__so_wbuff_size                        = 0,
  $basic__socket_optimizations                 = "auto",
  $basic__tip_class_limit                      = 10000,
  $admin__honor_fallback_scsv                  = true,
  $admin__ssl3_allow_rehandshake               = "rfc5746",
  $admin__ssl3_ciphers                         = "SSL_RSA_WITH_AES_128_GCM_SHA256,SSL_RSA_WITH_AES_128_CBC_SHA256,SSL_RSA_WITH_AES_128_CBC_SHA,SSL_RSA_WITH_AES_256_GCM_SHA384,SSL_RSA_WITH_AES_256_CBC_SHA256,SSL_RSA_WITH_AES_256_CBC_SHA,SSL_RSA_WITH_3DES_EDE_CBC_SHA",
  $admin__ssl3_diffie_hellman_key_length       = "dh_2048",
  $admin__ssl3_min_rehandshake_interval        = 1000,
  $admin__ssl_insert_extra_fragment            = false,
  $admin__ssl_max_handshake_message_size       = 10240,
  $admin__ssl_prevent_timing_side_channels     = false,
  $admin__ssl_signature_algorithms             = "",
  $admin__support_ssl2                         = false,
  $admin__support_ssl3                         = false,
  $admin__support_tls1                         = true,
  $admin__support_tls11                        = true,
  $admin__support_tls12                        = true,
  $appliance__bootloader_password              = "",
  $appliance__manage_ncipher                   = true,
  $appliance__nethsm_esn                       = "",
  $appliance__nethsm_hash                      = "",
  $appliance__nethsm_ip                        = "",
  $appliance__nethsm_ncipher_rfs               = "",
  $appliance__return_path_routing_enabled      = false,
  $aptimizer__max_dependent_fetch_size         = "2MB",
  $aptimizer__max_original_content_buffer_size = "2MB",
  $aptimizer__watchdog_interval                = 300,
  $aptimizer__watchdog_limit                   = 3,
  $autoscaler__verbose                         = false,
  $cluster_comms__allow_update_default         = true,
  $cluster_comms__allowed_update_hosts         = ["127.0.0.1"],
  $cluster_comms__state_sync_interval          = 3,
  $cluster_comms__state_sync_timeout           = 6,
  $connection__idle_connections_max            = 0,
  $connection__idle_timeout                    = 10,
  $connection__listen_queue_size               = 0,
  $connection__max_accepting                   = 0,
  $connection__multiple_accept                 = false,
  $dns__max_ttl                                = 86400,
  $dns__min_ttl                                = 86400,
  $dns__negative_expiry                        = 60,
  $dns__size                                   = 10867,
  $dns__timeout                                = 12,
  $ec2__access_key_id                          = "",
  $ec2__secret_access_key                      = "",
  $ec2__verify_query_server_cert               = false,
  $eventing__mail_interval                     = 30,
  $eventing__max_attempts                      = 10,
  $fault_tolerance__arp_count                  = 10,
  $fault_tolerance__auto_failback              = true,
  $fault_tolerance__frontend_check_ips         = ["%gateway%"],
  $fault_tolerance__heartbeat_method           = "unicast",
  $fault_tolerance__igmp_interval              = 30,
  $fault_tolerance__monitor_interval           = 500,
  $fault_tolerance__monitor_timeout            = 5,
  $fault_tolerance__multicast_address          = "239.100.1.1:9090",
  $fault_tolerance__unicast_port               = 9090,
  $fault_tolerance__use_bind_ip                = false,
  $fault_tolerance__verbose                    = false,
  $fips__enabled                               = false,
  $ftp__data_bind_low                          = false,
  $glb__verbose                                = false,
  $historical_activity__keep_days              = 90,
  $ip__appliance_returnpath                    = [],
  $java__classpath                             = "",
  $java__command                               = "java -server",
  $java__enabled                               = false,
  $java__lib                                   = "",
  $java__max_connections                       = 256,
  $java__session_age                           = 86400,
  $kerberos__verbose                           = false,
  $log__error_level                            = "info",
  $log__flush_time                             = 5,
  $log__log_file                               = "%zeushome%/zxtm/log/errors",
  $log__rate                                   = 50,
  $log__reopen                                 = 30,
  $log__time                                   = 60,
  $ospfv2__area                                = "0.0.0.1",
  $ospfv2__area_type                           = "normal",
  $ospfv2__authentication_key_id_a             = 0,
  $ospfv2__authentication_key_id_b             = 0,
  $ospfv2__authentication_shared_secret_a      = "",
  $ospfv2__authentication_shared_secret_b      = "",
  $ospfv2__enabled                             = false,
  $ospfv2__hello_interval                      = 10,
  $ospfv2__router_dead_interval                = 40,
  $protection__conncount_size                  = "20MB",
  $recent_connections__max_per_process         = 500,
  $recent_connections__retain_time             = 60,
  $recent_connections__snapshot_size           = 500,
  $rest_api__auth_timeout                      = 120,
  $rest_api__enabled                           = true,
  $rest_api__http_max_header_length            = 4096,
  $rest_api__replicate_absolute                = 20,
  $rest_api__replicate_lull                    = 5,
  $rest_api__replicate_timeout                 = 10,
  $security__login_banner                      = "",
  $security__login_banner_accept               = false,
  $security__login_delay                       = 0,
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
  $security__post_login_banner                 = "",
  $security__track_unknown_users               = false,
  $security__ui_page_banner                    = "",
  $session__asp_cache_size                     = 32768,
  $session__ip_cache_size                      = 32768,
  $session__j2ee_cache_size                    = 32768,
  $session__ssl_cache_size                     = 32768,
  $session__universal_cache_size               = 32768,
  $snmp__user_counters                         = 10,
  $soap__idle_minutes                          = 10,
  $ssl__cache_expiry                           = 1800,
  $ssl__cache_per_virtualserver                = true,
  $ssl__cache_size                             = 6151,
  $ssl__crl_mem_size                           = "5MB",
  $ssl__honor_fallback_scsv                    = true,
  $ssl__insert_extra_fragment                  = false,
  $ssl__max_handshake_message_size             = 10240,
  $ssl__ocsp_cache_size                        = 2048,
  $ssl__ocsp_stapling_default_refresh_interval = 60,
  $ssl__ocsp_stapling_maximum_refresh_interval = 864000,
  $ssl__ocsp_stapling_mem_size                 = "1MB",
  $ssl__ocsp_stapling_time_tolerance           = 30,
  $ssl__ocsp_stapling_verify_response          = false,
  $ssl__prevent_timing_side_channels           = false,
  $ssl__signature_algorithms                   = "",
  $ssl__ssl3_allow_rehandshake                 = "safe",
  $ssl__ssl3_ciphers                           = "",
  $ssl__ssl3_diffie_hellman_key_length         = "dh_1024",
  $ssl__ssl3_min_rehandshake_interval          = 1000,
  $ssl__support_ssl2                           = false,
  $ssl__support_ssl3                           = false,
  $ssl__support_tls1                           = true,
  $ssl__support_tls1_1                         = true,
  $ssl__support_tls1_2                         = true,
  $ssl_hardware__accel                         = false,
  $ssl_hardware__driver_pkcs11_debug           = false,
  $ssl_hardware__driver_pkcs11_lib             = "",
  $ssl_hardware__driver_pkcs11_slot_desc       = "",
  $ssl_hardware__driver_pkcs11_slot_type       = "operator",
  $ssl_hardware__driver_pkcs11_user_pin        = "",
  $ssl_hardware__failure_count                 = 5,
  $ssl_hardware__library                       = "none",
  $trafficscript__array_elements               = 100000,
  $trafficscript__data_local_size              = "5%",
  $trafficscript__data_size                    = "5%",
  $trafficscript__execution_time_warning       = 500,
  $trafficscript__max_instr                    = 100000,
  $trafficscript__memory_warning               = 1048576,
  $trafficscript__regex_cache_size             = 57,
  $trafficscript__regex_match_limit            = 10000000,
  $trafficscript__regex_match_warn_percentage  = 5,
  $trafficscript__variable_pool_use            = false,
  $web_cache__avg_path_length                  = 512,
  $web_cache__disk                             = false,
  $web_cache__disk_dir                         = "%zeushome%/zxtm/internal",
  $web_cache__max_file_num                     = 10000,
  $web_cache__max_file_size                    = "2%",
  $web_cache__max_path_length                  = 2048,
  $web_cache__normalize_query                  = true,
  $web_cache__size                             = "20%",
  $web_cache__verbose                          = false,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring global_settings ${name}")
  vtmrest { "global_settings":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/global_settings.erb'),
    type => 'application/json',
    internal => 'global_settings',
    debug => 0,
  }
}
