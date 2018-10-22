# === Define: brocadevtm::traffic_ip_groups
#
# Traffic IP Group
# Traffic IP groups are sets of IP addresses that are distributed across a
# cluster for fault tolerance.
#
# === Parameters
#
# [*basic__enabled*]
# If set to "No", the traffic IP group will be disabled and none of the
# traffic IP addresses will be raised.
#
# [*basic__hash_source_port*]
# Whether or not the source port should be taken into account when deciding
# which traffic manager should handle a request.
#
# [*basic__ip_assignment_mode*]
# Configure how traffic IPs are assigned to traffic managers in Single-Hosted
# mode
#
# [*basic__ip_mapping*]
# A table assigning traffic IP addresses to machines that should host them.
# Traffic IP addresses not specified in this table will automatically be
# assigned to a machine.
# Type:array
# Properties:{"ip"=>{"description"=>"A traffic IP address (from the
# ipaddresses property).", "type"=>"string"},
# "traffic_manager"=>{"description"=>"The name of the traffic manager that
# should host the IP address.", "type"=>"string",
# "pattern"=>"^[A-Za-z0-9._-]*$"}}
#
# [*basic__ipaddresses*]
# The IP addresses that belong to the Traffic IP group.
# Type:array
# Properties:
#
# [*basic__keeptogether*]
# If set to "Yes" then all the traffic IPs will be raised on a single traffic
# manager.  By default they're distributed across all active traffic managers
# in the traffic IP group.
#
# [*basic__location*]
# The location in which the Traffic IP group is based.
#
# [*basic__machines*]
# The traffic managers that can host the traffic IP group's IP addresses.
# Type:array
# Properties:
#
# [*basic__mode*]
# The method used to distribute traffic IPs across machines in the cluster. If
# "multihosted" is used then "multicast" must be set to an appropriate
# multicast IP address.
#
# [*basic__multicast*]
# The multicast IP address used to duplicate traffic to all traffic managers
# in the group.
#
# [*basic__note*]
# A note, used to describe this Traffic IP Group
#
# [*basic__rhi_bgp_metric_base*]
# The base BGP routing metric for this Traffic IP group. This is the
# advertised routing cost for the active traffic manager in the cluster. It
# can be used to set up inter-cluster failover.
#
# [*basic__rhi_bgp_passive_metric_offset*]
# The BGP routing metric offset for this Traffic IP group. This is the
# difference between the advertised routing cost for the active and passive
# traffic manager in the cluster.
#
# [*basic__rhi_ospfv2_metric_base*]
# The base OSPFv2 routing metric for this Traffic IP group. This is the
# advertised routing cost for the active traffic manager in the cluster. It
# can be used to set up inter-cluster failover.
#
# [*basic__rhi_ospfv2_passive_metric_offset*]
# The OSPFv2 routing metric offset for this Traffic IP group. This is the
# difference between the advertised routing cost for the active and passive
# traffic manager in the cluster.
#
# [*basic__rhi_protocols*]
# A list of protocols to be used for RHI. Currently must be 'ospf' or 'bgp' or
# both. The default, if empty, is 'ospf', which means that it is not possible
# to specify no protocol.
#
# [*basic__slaves*]
# A list of traffic managers that are in 'passive' mode. This means that in a
# fully working environment, they will not have any traffic IP addresses
# assigned to them.
# Type:array
# Properties:
#
# === Examples
#
# brocadevtm::traffic_ip_groups { 'example':
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
define brocadevtm::traffic_ip_groups (
  $ensure,
  $basic__enabled                          = true,
  $basic__hash_source_port                 = false,
  $basic__ip_assignment_mode               = 'balanced',
  $basic__ip_mapping                       = '[]',
  $basic__ipaddresses                      = '[]',
  $basic__keeptogether                     = false,
  $basic__location                         = 0,
  $basic__machines                         = '[]',
  $basic__mode                             = 'singlehosted',
  $basic__multicast                        = undef,
  $basic__note                             = undef,
  $basic__rhi_bgp_metric_base              = 10,
  $basic__rhi_bgp_passive_metric_offset    = 10,
  $basic__rhi_ospfv2_metric_base           = 10,
  $basic__rhi_ospfv2_passive_metric_offset = 10,
  $basic__rhi_protocols                    = 'ospf',
  $basic__slaves                           = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring traffic_ip_groups ${name}")
  vtmrest { "traffic_ip_groups/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/traffic_ip_groups.erb'),
    type     => 'application/json',
    internal => 'traffic_ip_groups',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/traffic_ip_groups", {ensure => present})
    file_line { "traffic_ip_groups/${name}":
      line => "traffic_ip_groups/${name}",
      path => "${purge_state_dir}/traffic_ip_groups",
    }
  }
}
