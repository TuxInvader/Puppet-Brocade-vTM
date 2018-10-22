# === Define: brocadevtm::kerberos_principals
#
# Kerberos Principal
# A Kerberos principal can be used by the traffic manager to participate in a
# Kerberos realm.
#
# === Parameters
#
# [*basic__kdcs*]
# A list of "<hostname/ip>:<port>" pairs for Kerberos key distribution center
# (KDC) services to be explicitly used for the realm of the principal.  If no
# KDCs are explicitly configured, DNS will be used to discover the KDC(s) to
# use.
# Type:array
# Properties:
#
# [*basic__keytab*]
# The name of the Kerberos keytab file containing suitable credentials to
# authenticate as the specified Kerberos principal.
#
# [*basic__krb5conf*]
# The name of an optional Kerberos configuration file (krb5.conf).
#
# [*basic__realm*]
# The Kerberos realm where the principal belongs.
#
# [*basic__service*]
# The service name part of the Kerberos principal name the traffic manager
# should use to authenticate itself.
#
# === Examples
#
# brocadevtm::kerberos_principals { 'example':
#     ensure => present,
#     basic__keytab => 'foo'
#     basic__service => 'foo'
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
define brocadevtm::kerberos_principals (
  $ensure,
  $basic__keytab,
  $basic__service,
  $basic__kdcs     = '[]',
  $basic__krb5conf = undef,
  $basic__realm    = undef,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring kerberos_principals ${name}")
  vtmrest { "kerberos/principals/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/kerberos_principals.erb'),
    type     => 'application/json',
    internal => 'kerberos_principals',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/kerberos_principals", {ensure => present})
    file_line { "kerberos/principals/${name}":
      line => "kerberos/principals/${name}",
      path => "${purge_state_dir}/kerberos_principals",
    }
  }
}
