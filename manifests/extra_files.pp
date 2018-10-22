# === Define: brocadevtm::extra_files
#
# Extra File
# A user-uploaded file. Such files can be used in TrafficScript code using the
# "resource.get" function.
#
# === Parameters
#
# === Examples
#
# brocadevtm::extra_files { 'example':
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
define brocadevtm::extra_files (
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

  info ("Configuring extra_files ${name}")
  vtmrest { "extra_files/${name}":
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
    ensure_resource('file', "${purge_state_dir}/extra_files", {ensure => present})
    file_line { "extra_files/${name}":
      line => "extra_files/${name}",
      path => "${purge_state_dir}/extra_files",
    }
  }
}
