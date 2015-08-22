# === Define: brocadevtm::dns_server_zone_files
#
# DNS Zone File
# The "conf/dnsserver/zonefiles/" directory contains files that define DNS zones.
#
# === Parameters
# 
# === Examples
# 
# brocadevtm::dns_server_zone_files { 'example': 
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
define brocadevtm::dns_server_zone_files (
  $ensure,
  $content,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring dns_server_zone_files ${name}")
  vtmrest { "dns_server/zone_files/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => $content,
    type => 'application/octet-stream',
    debug => 0,
  }
}
