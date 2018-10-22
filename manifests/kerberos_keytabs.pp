# === Define: brocadevtm::kerberos_keytabs
#
# Kerberos Keytab
# A Kerberos keytab file contains credentials to authenticate as (a number of)
# Kerberos principals.
#
# === Parameters
#
# === Examples
#
# brocadevtm::kerberos_keytabs { 'example':
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
define brocadevtm::kerberos_keytabs (
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

  info ("Configuring kerberos_keytabs ${name}")
  vtmrest { "kerberos/keytabs/${name}":
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
    ensure_resource('file', "${purge_state_dir}/kerberos_keytabs", {ensure => present})
    file_line { "kerberos/keytabs/${name}":
      line => "kerberos/keytabs/${name}",
      path => "${purge_state_dir}/kerberos_keytabs",
    }
  }
}
