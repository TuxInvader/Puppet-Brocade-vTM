# === Define: brocadevtm::action_programs
#
# Action Program
# This is a program or script that can be referenced and used by actions of
# type 'Program'
#
# === Parameters
#
# === Examples
#
# brocadevtm::action_programs { 'example':
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
define brocadevtm::action_programs (
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

  info ("Configuring action_programs ${name}")
  vtmrest { "action_programs/${name}":
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
    ensure_resource('file', "${purge_state_dir}/action_programs", {ensure => present})
    file_line { "action_programs/${name}":
      line => "action_programs/${name}",
      path => "${purge_state_dir}/action_programs",
    }
  }
}
