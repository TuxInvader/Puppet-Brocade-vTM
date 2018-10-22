# === Define: brocadevtm::monitor_scripts
#
# Monitor Program
# An executable program that can be used to by external program monitors to
# report the health of backend services.
#
# === Parameters
#
# === Examples
#
# brocadevtm::monitor_scripts { 'example':
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
define brocadevtm::monitor_scripts (
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

  info ("Configuring monitor_scripts ${name}")
  vtmrest { "monitor_scripts/${name}":
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
    ensure_resource('file', "${purge_state_dir}/monitor_scripts", {ensure => present})
    file_line { "monitor_scripts/${name}":
      line => "monitor_scripts/${name}",
      path => "${purge_state_dir}/monitor_scripts",
    }
  }
}
