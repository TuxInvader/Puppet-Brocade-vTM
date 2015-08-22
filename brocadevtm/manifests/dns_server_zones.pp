# === Define: brocadevtm::dns_server_zones
#
# DNS Zone
# The "conf/dnsserver/zones/" file contains zone metadata
#
# === Parameters
#
# [*basic__origin*]
# The domain origin of this Zone.
#
# [*basic__zonefile*]
# The Zone File encapsulated by this Zone.
# 
# === Examples
# 
# brocadevtm::dns_server_zones { 'example': 
#     ensure => present,
#     basic__origin => 'foo'
#     basic__zonefile => 'foo'
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
define brocadevtm::dns_server_zones (
  $ensure,
  $basic__origin,
  $basic__zonefile,
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring dns_server_zones ${name}")
  vtmrest { "dns_server/zones/${name}":
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => template('brocadevtm/dns_server_zones.erb'),
    type       => 'application/json',
    internal   => 'dns_server_zones',
    debug      => 0,
  }
}
