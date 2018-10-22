# === Define: brocadevtm::ssl_server_keys
#
# SSL Key Pair
# SSL Server Certificates are presented to clients by virtual servers when SSL
# decryption is enabled.
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
# brocadevtm::ssl_server_keys { 'example':
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
define brocadevtm::ssl_server_keys (
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

  info ("Configuring ssl_server_keys ${name}")
  vtmrest { "ssl/server_keys/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/ssl_server_keys.erb'),
    type     => 'application/json',
    internal => 'ssl_server_keys',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/ssl_server_keys", {ensure => present})
    file_line { "ssl/server_keys/${name}":
      line => "ssl/server_keys/${name}",
      path => "${purge_state_dir}/ssl_server_keys",
    }
  }
}
