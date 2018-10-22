# === Define: brocadevtm::ssl_client_keys
#
# SSL Client Key Pair
# SSL Client Certificates are used when connecting to backend nodes that
# require client certificate authentication.
#
# === Parameters
#
# [*basic__public*]
# Public certificate
#
# [*basic__request*]
# Certificate Signing Request for certificate
#
# [*basic__private*]
# Private key for certificate
#
# [*basic__note*]
# Notes for this certificate
#
# === Examples
#
# brocadevtm::ssl_client_keys { 'example':
#     ensure => present,
#     basic__public => 'foo'
#     basic__request => 'foo'
#     basic__private => 'foo'
#     basic__note => 'foo'
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
define brocadevtm::ssl_client_keys (
  $ensure,
  $basic__public,
  $basic__private,
  $basic__note    = undef,
  $basic__request = undef,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring ssl_client_keys ${name}")
  vtmrest { "ssl/client_keys/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/ssl_client_keys.erb'),
    type     => 'application/json',
    internal => 'ssl_client_keys',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/ssl_client_keys", {ensure => present})
    file_line { "ssl/client_keys/${name}":
      line => "ssl/client_keys/${name}",
      path => "${purge_state_dir}/ssl_client_keys",
    }
  }
}
