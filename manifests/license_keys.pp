# === Define: brocadevtm::license_keys
#
# License
# A license key is a encoded text file that controls what functionality is
# available from each traffic manager in the cluster. Every production traffic
# manager must have a valid licence key in order to function; a traffic
# manager without a license will operate in developer mode, allowing
# developers to trial a wide range of functionality, but placing restrictions
# on bandwidth.
#
# === Parameters
#
# === Examples
#
# brocadevtm::license_keys { 'example':
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
define brocadevtm::license_keys (
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

  info ("Configuring license_keys ${name}")
  vtmrest { "license_keys/${name}":
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
    ensure_resource('file', "${purge_state_dir}/license_keys", {ensure => present})
    file_line { "license_keys/${name}":
      line => "license_keys/${name}",
      path => "${purge_state_dir}/license_keys",
    }
  }
}
