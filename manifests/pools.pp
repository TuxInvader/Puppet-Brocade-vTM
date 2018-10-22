# === Define: brocadevtm::pools
#
# Pool
# The "conf/pools" directory contains configuration files for backend node
# pools.  The name of a file is the name of the pool it defines.  Pools can be
# configured under the "Services > Pools" section of the Admin Server UI or by
# using functions under the "Pool" section of the SOAP API and CLI.
#
# === Parameters
#
# [*basic__bandwidth_class*]
# The Bandwidth Management Class this pool uses, if any.
#
# [*basic__failure_pool*]
# If all of the nodes in this pool have failed, then requests can be diverted
# to another pool.
#
# [*basic__lard_size*]
# The size of the LARD cache. This is used when recording unique URLs to
# provide request affinity, where the same request is sent to the same node.
#
# [*basic__max_connection_attempts*]
# The maximum number of nodes to which the traffic manager will attempt to
# send a request before returning an error to the client. Requests that are
# non-retryable will be attempted against only one node. Zero signifies no
# limit.
#
# [*basic__max_idle_connections_pernode*]
# The maximum number of unused HTTP keepalive connections that should be
# maintained to an individual node.  Zero signifies no limit.
#
# [*basic__max_timed_out_connection_attempts*]
# The maximum number of connection attempts the traffic manager will make
# where the server fails to respond within the time limit defined by the
# "max_reply_time" setting. Zero signifies no limit.
#
# [*basic__monitors*]
# The monitors assigned to this pool, used to detect failures in the back end
# nodes.
# Type:array
# Properties:
#
# [*basic__node_close_with_rst*]
# Whether or not connections to the back-end nodes should be closed with a RST
# packet, rather than a FIN packet. This avoids the TIME_WAIT state, which on
# rare occasions allows wandering duplicate packets to be safely ignored.
#
# [*basic__node_connection_attempts*]
# The number of times the software will attempt to connect to the same
# back-end node before marking it as failed.  This is only used when
# "passive_monitoring" is enabled.
#
# [*basic__node_delete_behavior*]
# Specify the deletion behavior for nodes in this pool.
#
# [*basic__node_drain_to_delete_timeout*]
# The maximum time that a node will be allowed to remain in a draining state
# after it has been deleted. A value of 0 means no maximum time.
#
# [*basic__nodes_table*]
# A table of all nodes in this pool. A node should be specified as a
# "<ip>:<port>" pair, and has a state, weight and priority.
# Type:array
# Properties:{"node"=>{"description"=>"A node is a combination of an ip
# address and port", "type"=>"string"}, "priority"=>{"description"=>"The
# priority of the node, higher values signify higher priority. If a priority
# is not specified for a node it is assumed to be \"1\".", "type"=>"integer",
# "minimum"=>0, "default"=>1}, "state"=>{"description"=>"The state of the
# pool, which can either be Active, Draining or Disabled", "type"=>"string",
# "default"=>"active", "enum"=>["active", "disabled", "draining"]},
# "weight"=>{"description"=>"Weight for the node. The actual value in
# isolation does not matter: As long as it is a valid integer 1-100, the
# per-node weightings are calculated on the relative values between the
# nodes.", "type"=>"integer", "minimum"=>1, "maximum"=>100, "default"=>1},
# "source_ip"=>{"description"=>"The source address the Traffic Manager uses to
# connect to this node.", "type"=>"string", "default"=>""}}
#
# [*basic__note*]
# A description of the pool.
#
# [*basic__passive_monitoring*]
# Whether or not the software should check that 'real' requests (i.e. not
# those from monitors) to this pool appear to be working.  This should
# normally be enabled, so that when a node is refusing connections, responding
# too slowly, or sending back invalid data, it can mark that node as failed,
# and stop sending requests to it. <br>If this is disabled, you should ensure
# that suitable health monitors are configured to check your servers instead,
# otherwise failed requests will not be detected and subsequently retried.
#
# [*basic__persistence_class*]
# The default Session Persistence class this pool uses, if any.
#
# [*basic__transparent*]
# Whether or not connections to the back-ends appear to originate from the
# source client IP address.
#
# [*auto_scaling__addnode_delaytime*]
# The time in seconds from the creation of the node which the traffic manager
# should wait before adding the node to the autoscaled pool. Set this to allow
# applications on the newly created node time to intialize before being sent
# traffic.
#
# [*auto_scaling__cloud_credentials*]
# The Cloud Credentials object containing authentication credentials to use in
# cloud API calls.
#
# [*auto_scaling__cluster*]
# The ESX host or ESX cluster name to put the new virtual machine instances on.
#
# [*auto_scaling__data_center*]
# The name of the logical datacenter on the vCenter server. Virtual machines
# will be scaled up and down under the datacenter root folder.
#
# [*auto_scaling__data_store*]
# The name of the datastore to be used by the newly created virtual machine.
#
# [*auto_scaling__enabled*]
# Are the nodes of this pool subject to autoscaling?  If yes, nodes will be
# automatically added and removed from the pool by the chosen autoscaling
# mechanism.
#
# [*auto_scaling__external*]
# Whether or not autoscaling is being handled by an external system. Set this
# value to Yes if all aspects of autoscaling are handled by an external
# system, such as RightScale. If set to No, the traffic manager will determine
# when to scale the pool and will communicate with the cloud provider to
# create and destroy nodes as necessary.
#
# [*auto_scaling__extraargs*]
# Any extra arguments to the autoscaling API. Each argument can be separated
# by comma. E.g in case of EC2, it can take extra parameters to the Amazon's
# RunInstance API say DisableApiTermination=false,Placement.Tenancy=default.
#
# [*auto_scaling__hysteresis*]
# The time period in seconds for which a change condition must persist before
# the change is actually instigated.
#
# [*auto_scaling__imageid*]
# The identifier for the image of the instances to create.
#
# [*auto_scaling__ips_to_use*]
# Which type of IP addresses on the node to use.  Choose private IPs if the
# traffic manager is in the same cloud as the nodes, otherwise choose public
# IPs.
#
# [*auto_scaling__last_node_idle_time*]
# The time in seconds for which the last node in an autoscaled pool must have
# been idle before it is destroyed.  This is only relevant if min_nodes is 0.
#
# [*auto_scaling__max_nodes*]
# The maximum number of nodes in this autoscaled pool.
#
# [*auto_scaling__min_nodes*]
# The minimum number of nodes in this autoscaled pool.
#
# [*auto_scaling__name*]
# The beginning of the name of nodes in the cloud that are part of this
# autoscaled pool.
#
# [*auto_scaling__port*]
# The port number to use for each node in this autoscaled pool.
#
# [*auto_scaling__refractory*]
# The time period in seconds after the instigation of a re-size during which
# no further changes will be made to the pool size.
#
# [*auto_scaling__response_time*]
# The expected response time of the nodes in ms.  This time is used as a
# reference when deciding whether a node's response time is conforming.  All
# responses from all the nodes will be compared to this reference and the
# percentage of conforming responses is the base for decisions about scaling
# the pool up or down.
#
# [*auto_scaling__scale_down_level*]
# The fraction, in percent, of conforming requests above which the pool size
# is decreased.  If the percentage of conforming requests exceeds this value,
# the pool is scaled down.
#
# [*auto_scaling__scale_up_level*]
# The fraction, in percent, of conforming requests below which the pool size
# is increased.  If the percentage of conforming requests drops below this
# value, the pool is scaled up.
#
# [*auto_scaling__securitygroupids*]
# List of security group IDs to associate to the new EC2 instance.
# Type:array
# Properties:
#
# [*auto_scaling__size_id*]
# The identifier for the size of the instances to create.
#
# [*auto_scaling__subnetids*]
# List of subnet IDs where the new EC2-VPC instance(s) will be launched.
# Instances will be evenly distributed among the subnets. If the list is
# empty, instances will be launched inside EC2-Classic.
# Type:array
# Properties:
#
# [*connection__max_connect_time*]
# How long the pool should wait for a connection to a node to be established
# before giving up and trying another node.
#
# [*connection__max_connections_per_node*]
# The maximum number of concurrent connections allowed to each back-end node
# in this pool per machine. A value of 0 means unlimited connections.
#
# [*connection__max_queue_size*]
# The maximum number of connections that can be queued due to connections
# limits. A value of 0 means unlimited queue size.
#
# [*connection__max_reply_time*]
# How long the pool should wait for a response from the node before either
# discarding the request or trying another node (retryable requests only).
#
# [*connection__queue_timeout*]
# The maximum time to keep a connection queued in seconds.
#
# [*dns_autoscale__enabled*]
# When enabled, the Traffic Manager will periodically resolve the hostnames in
# the "hostnames" list using a DNS query, and use the results to automatically
# add, remove or update the IP addresses of the nodes in the pool.
#
# [*dns_autoscale__hostnames*]
# A list of hostnames which will be used for DNS-derived autoscaling
# Type:array
# Properties:
#
# [*dns_autoscale__port*]
# The port number to use for each node when using DNS-derived autoscaling
#
# [*ftp__support_rfc_2428*]
# Whether or not the backend IPv4 nodes understand the EPRT and EPSV command
# from RFC 2428.  It is always assumed that IPv6 nodes support these commands.
#
# [*http__keepalive*]
# Whether or not the pool should maintain HTTP keepalive connections to the
# nodes.
#
# [*http__keepalive_non_idempotent*]
# Whether or not the pool should maintain HTTP keepalive connections to the
# nodes for non-idempotent requests.
#
# [*kerberos_protocol_transition__principal*]
# The Kerberos principal the traffic manager should use when performing
# Kerberos Protocol Transition.
#
# [*kerberos_protocol_transition__target*]
# The Kerberos principal name of the service this pool targets.
#
# [*load_balancing__algorithm*]
# The load balancing algorithm that this pool uses to distribute load across
# its nodes.
#
# [*load_balancing__priority_enabled*]
# Enable priority lists.
#
# [*load_balancing__priority_nodes*]
# Minimum number of highest-priority active nodes.
#
# [*node__close_on_death*]
# Close all connections to a node once we detect that it has failed.
#
# [*node__retry_fail_time*]
# The amount of time, in seconds, that a traffic manager will wait before
# re-trying a node that has been marked as failed by passive monitoring.
#
# [*service_discovery__enabled*]
# Are the nodes of this pool determined by a Service Discovery plugin? If yes,
# nodes will be automatically added and removed from the pool by the traffic
# manager.
#
# [*service_discovery__interval*]
# The minimum time before rerunning the Service Discovery plugin
#
# [*service_discovery__plugin*]
# The plugin script a Service Discovery autoscaled pool should use to retrieve
# the list of nodes.
#
# [*service_discovery__plugin_args*]
# The arguments for the script specified in "service_discovery!plugin", e.g. a
# common instance tag, or name of a managed group of cloud instances.
#
# [*service_discovery__timeout*]
# The maximum time a plugin should be allowed to run before timing out. Set to
# 0 for no timeout.
#
# [*smtp__send_starttls*]
# If we are encrypting traffic for an SMTP connection, should we upgrade to
# SSL using STARTTLS.
#
# [*ssl__cipher_suites*]
# The SSL/TLS cipher suites to allow for connections to a back-end node.
# Leaving this empty will make the pool use the globally configured cipher
# suites, see configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!cipher_su
# ites"> "ssl!cipher_suites"</a> in the Global Settings section of the System
# tab.  See there for how to specify SSL/TLS cipher suites.
#
# [*ssl__client_auth*]
# Whether or not a suitable certificate and private key from the SSL Client
# Certificates catalog be used if the back-end server requests client
# authentication.
#
# [*ssl__common_name_match*]
# A list of names against which the 'common name' of the certificate is
# matched; these names are used in addition to the node's hostname or IP
# address as specified in the config file or added by the autoscaler process.
# Type:array
# Properties:
#
# [*ssl__elliptic_curves*]
# The SSL elliptic curve preference list for SSL connections from this pool
# using TLS version 1.0 or higher. Leaving this empty will make the pool use
# the globally configured preference list. The named curves P256, P384 and
# P521 may be configured.
# Type:array
# Properties:
#
# [*ssl__enable*]
# Whether or not the pool should encrypt data before sending it to a back-end
# node.
#
# [*ssl__enhance*]
# SSL protocol enhancements allow your traffic manager to prefix each new SSL
# connection with information about the client. This enables Pulse Secure
# Virtual Traffic Manager virtual servers referenced by this pool to discover
# the original client's IP address. Only enable this if you are using nodes
# for this pool which are Pulse Secure vTMs, whose virtual servers have the
# "ssl_trust_magic" setting enabled.
#
# [*ssl__send_close_alerts*]
# Whether or not to send an SSL/TLS "close alert" when initiating a socket
# disconnection.
#
# [*ssl__server_name*]
# Whether or not the software should use the TLS 1.0 server_name extension,
# which may help the back-end node provide the correct certificate. Enabling
# this setting will force the use of at least TLS 1.0.
#
# [*ssl__session_cache_enabled*]
# Whether or not the SSL client cache will be used for this pool. Choosing the
# global setting means the value of the configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!client_ca
# che!enabled"> "ssl!client_cache!enabled"</a> from the Global Settings
# section of the System tab will be enforced.
#
# [*ssl__session_tickets_enabled*]
# Whether or not SSL session tickets will be used for this pool if the session
# cache is also enabled. Choosing the global setting means the value of the
# configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!client_ca
# che!tickets_enabled"> "ssl!client_cache!enabled"</a> from the Global
# Settings section of the System tab will be enforced.
#
# [*ssl__signature_algorithms*]
# The SSL signature algorithms preference list for SSL connections from this
# pool using TLS version 1.2 or higher. Leaving this empty will make the pool
# use the globally configured preference list, "signature_algorithms" in the
# "ssl" section of the "global_settings" resource.  See there and in the
# online help for how to specify SSL signature algorithms.
#
# [*ssl__strict_verify*]
# Whether or not strict certificate verification should be performed. This
# will turn on checks to disallow server certificates that don't match the
# server name or a name in the ssl_common_name_match list, are self-signed,
# expired, revoked, or have an unknown CA.
#
# [*ssl__support_ssl3*]
# Whether or not SSLv3 is enabled for this pool. Choosing the global setting
# means the value of the configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_s
# sl3"> "ssl!support_ssl3"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__support_tls1*]
# Whether or not TLSv1.0 is enabled for this pool. Choosing the global setting
# means the value of the configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1"> "ssl!support_tls1"</a> from the Global Settings section of the System
# tab will be enforced.
#
# [*ssl__support_tls1_1*]
# Whether or not TLSv1.1 is enabled for this pool. Choosing the global setting
# means the value of the configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1_1"> "ssl!support_tls1_1"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*ssl__support_tls1_2*]
# Whether or not TLSv1.2 is enabled for this pool. Choosing the global setting
# means the value of the configuration key <a
# href="?fold_open=SSL%20Configuration&section=Global%20Settings#a_ssl!support_t
# ls1_2"> "ssl!support_tls1_2"</a> from the Global Settings section of the
# System tab will be enforced.
#
# [*tcp__nagle*]
# Whether or not Nagle's algorithm should be used for TCP connections to the
# back-end nodes.
#
# [*udp__accept_from*]
# The IP addresses and ports from which responses to UDP requests should be
# accepted.
# If set to accept responses from a specific set of IP addresses, you will
# need to enter a CIDR Mask (such as 10.100.0.0/16).
#
# [*udp__accept_from_mask*]
# The CIDR mask that matches IPs we want to receive responses from.
#
# [*udp__response_timeout*]
# The maximum length of time that a node is permitted to take after receiving
# a UDP request packet before sending a reply packet. Zero indicates that
# there is no maximum, preventing a node that does not send replies from being
# presumed to have failed.
#
# === Examples
#
# brocadevtm::pools { 'example':
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
define brocadevtm::pools (
  $ensure,
  $basic__bandwidth_class                   = undef,
  $basic__failure_pool                      = undef,
  $basic__max_connection_attempts           = 0,
  $basic__max_idle_connections_pernode      = 50,
  $basic__max_timed_out_connection_attempts = 2,
  $basic__monitors                          = '[]',
  $basic__node_close_with_rst               = false,
  $basic__node_connection_attempts          = 3,
  $basic__node_delete_behavior              = 'immediate',
  $basic__node_drain_to_delete_timeout      = 0,
  $basic__nodes_table                       = '[]',
  $basic__note                              = undef,
  $basic__passive_monitoring                = true,
  $basic__persistence_class                 = undef,
  $basic__transparent                       = false,
  $auto_scaling__addnode_delaytime          = 0,
  $auto_scaling__cloud_credentials          = undef,
  $auto_scaling__cluster                    = undef,
  $auto_scaling__data_center                = undef,
  $auto_scaling__data_store                 = undef,
  $auto_scaling__enabled                    = false,
  $auto_scaling__external                   = true,
  $auto_scaling__extraargs                  = undef,
  $auto_scaling__hysteresis                 = 20,
  $auto_scaling__imageid                    = undef,
  $auto_scaling__ips_to_use                 = 'publicips',
  $auto_scaling__last_node_idle_time        = 3600,
  $auto_scaling__max_nodes                  = 4,
  $auto_scaling__min_nodes                  = 1,
  $auto_scaling__name                       = undef,
  $auto_scaling__port                       = 80,
  $auto_scaling__refractory                 = 180,
  $auto_scaling__response_time              = 1000,
  $auto_scaling__scale_down_level           = 95,
  $auto_scaling__scale_up_level             = 40,
  $auto_scaling__securitygroupids           = '[]',
  $auto_scaling__size_id                    = undef,
  $auto_scaling__subnetids                  = '[]',
  $connection__max_connect_time             = 4,
  $connection__max_connections_per_node     = 0,
  $connection__max_queue_size               = 0,
  $connection__max_reply_time               = 30,
  $connection__queue_timeout                = 10,
  $dns_autoscale__enabled                   = false,
  $dns_autoscale__hostnames                 = '[]',
  $dns_autoscale__port                      = 80,
  $ftp__support_rfc_2428                    = false,
  $http__keepalive                          = true,
  $http__keepalive_non_idempotent           = false,
  $kerberos_protocol_transition__principal  = undef,
  $kerberos_protocol_transition__target     = undef,
  $load_balancing__algorithm                = 'round_robin',
  $load_balancing__priority_enabled         = false,
  $load_balancing__priority_nodes           = 1,
  $node__close_on_death                     = false,
  $node__retry_fail_time                    = 60,
  $service_discovery__enabled               = false,
  $service_discovery__interval              = 10,
  $service_discovery__plugin                = undef,
  $service_discovery__plugin_args           = undef,
  $service_discovery__timeout               = 0,
  $smtp__send_starttls                      = true,
  $ssl__cipher_suites                       = undef,
  $ssl__client_auth                         = false,
  $ssl__common_name_match                   = '[]',
  $ssl__elliptic_curves                     = '[]',
  $ssl__enable                              = false,
  $ssl__enhance                             = false,
  $ssl__send_close_alerts                   = true,
  $ssl__server_name                         = false,
  $ssl__session_cache_enabled               = 'use_default',
  $ssl__session_tickets_enabled             = 'use_default',
  $ssl__signature_algorithms                = undef,
  $ssl__strict_verify                       = false,
  $ssl__support_ssl3                        = 'use_default',
  $ssl__support_tls1                        = 'use_default',
  $ssl__support_tls1_1                      = 'use_default',
  $ssl__support_tls1_2                      = 'use_default',
  $tcp__nagle                               = true,
  $udp__accept_from                         = 'dest_only',
  $udp__accept_from_mask                    = undef,
  $udp__response_timeout                    = 0,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring pools ${name}")
  vtmrest { "pools/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/pools.erb'),
    type     => 'application/json',
    internal => 'pools',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/pools", {ensure => present})
    file_line { "pools/${name}":
      line => "pools/${name}",
      path => "${purge_state_dir}/pools",
    }
  }
}
