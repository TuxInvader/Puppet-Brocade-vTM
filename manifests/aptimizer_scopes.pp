# === Define: brocadevtm::aptimizer_scopes
#
# Aptimizer Application Scope
# Application scopes define criteria that match URLs to specific logical web
# applications hosted by a virtual server.
#
# === Parameters
#
# [*basic__canonical_hostname*]
# If the hostnames for this scope are aliases of each other, the canonical
# hostname will be used for requests to the server.
#
# [*basic__hostnames*]
# The hostnames to limit acceleration to.
# Type:array
# Properties:
#
# [*basic__root*]
# The root path of the application defined by this application scope.
#
# === Examples
#
# brocadevtm::aptimizer_scopes { 'example':
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
define brocadevtm::aptimizer_scopes (
  $ensure,
  $basic__canonical_hostname = undef,
  $basic__hostnames          = '[]',
  $basic__root               = '/',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring aptimizer_scopes ${name}")
  vtmrest { "aptimizer/scopes/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/aptimizer_scopes.erb'),
    type     => 'application/json',
    internal => 'aptimizer_scopes',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/aptimizer_scopes", {ensure => present})
    file_line { "aptimizer/scopes/${name}":
      line => "aptimizer/scopes/${name}",
      path => "${purge_state_dir}/aptimizer_scopes",
    }
  }
}
