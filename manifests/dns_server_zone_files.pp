# === Define: brocadevtm::dns_server_zone_files
#
# DNS Zone File
# The "conf/dnsserver/zonefiles/" directory contains files that define DNS
# zones.
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
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring dns_server_zone_files ${name}")
  vtmrest { "dns_server/zone_files/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/dns_server_zone_files", {ensure => present})
    file_line { "dns_server/zone_files/${name}":
      line => "dns_server/zone_files/${name}",
      path => "${purge_state_dir}/dns_server_zone_files",
    }
  }
}
