# === Define: brocadevtm::ssl_server_keys
#
# SSL Key Pair
# SSL Server Certificates are presented to clients by virtual servers when SSL decryption is enabled.
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
  $basic__note    = "",
  $basic__request = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring ssl_server_keys ${name}")
  vtmrest { "ssl/server_keys/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/ssl_server_keys.erb'),
    type => 'application/json',
    internal => 'ssl_server_keys',
    debug => 0,
  }
}
