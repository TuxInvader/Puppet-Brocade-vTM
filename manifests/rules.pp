# === Define: brocadevtm::rules
#
# Rule
# TrafficScript rules allow traffic inspection and modification.
#
# === Parameters
#
# === Examples
#
# brocadevtm::rules { 'example':
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
define brocadevtm::rules (
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

  info ("Configuring rules ${name}")
  vtmrest { "rules/${name}":
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
    ensure_resource('file', "${purge_state_dir}/rules", {ensure => present})
    file_line { "rules/${name}":
      line => "rules/${name}",
      path => "${purge_state_dir}/rules",
    }
  }
}
