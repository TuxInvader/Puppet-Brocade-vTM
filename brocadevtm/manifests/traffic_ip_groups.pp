# === Define: brocadevtm::traffic_ip_groups
#

define brocadevtm::traffic_ip_groups (
  $ensure,
  $basic__enabled                          = true,
  $basic__hash_source_port                 = false,
  $basic__ip_mapping                       = [],
  $basic__ipaddresses                      = [],
  $basic__keeptogether                     = false,
  $basic__location                         = 0,
  $basic__machines                         = [],
  $basic__mode                             = "singlehosted",
  $basic__multicast                        = "",
  $basic__note                             = "",
  $basic__rhi_ospfv2_metric_base           = 10,
  $basic__rhi_ospfv2_passive_metric_offset = 10,
  $basic__slaves                           = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring traffic_ip_groups ${name}")
  vtmrest { "traffic_ip_groups/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/traffic_ip_groups.erb'),
    type => 'application/json',
    internal => 'traffic_ip_groups',
    debug => 0,
  }
}
