# === Define: brocadevtm::servicediscovery
#
# Service Discovery Plugins
# The "conf/servicediscovery" directory contains plugins for use with Service
# Discovery for pool nodes.
#
# === Parameters
#
# === Examples
#
# brocadevtm::servicediscovery { 'example':
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
define brocadevtm::servicediscovery (
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

  info ("Configuring servicediscovery ${name}")
  vtmrest { "servicediscovery/${name}":
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
    ensure_resource('file', "${purge_state_dir}/servicediscovery", {ensure => present})
    file_line { "servicediscovery/${name}":
      line => "servicediscovery/${name}",
      path => "${purge_state_dir}/servicediscovery",
    }
  }
}
