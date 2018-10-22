# === Define: brocadevtm::kerberos_krb5confs
#
# Kerberos Configuration File
# A Kerberos krb5.conf file that provides the raw configuration for a Kerberos
# principal.
#
# === Parameters
#
# === Examples
#
# brocadevtm::kerberos_krb5confs { 'example':
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
define brocadevtm::kerberos_krb5confs (
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

  info ("Configuring kerberos_krb5confs ${name}")
  vtmrest { "kerberos/krb5confs/${name}":
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
    ensure_resource('file', "${purge_state_dir}/kerberos_krb5confs", {ensure => present})
    file_line { "kerberos/krb5confs/${name}":
      line => "kerberos/krb5confs/${name}",
      path => "${purge_state_dir}/kerberos_krb5confs",
    }
  }
}
