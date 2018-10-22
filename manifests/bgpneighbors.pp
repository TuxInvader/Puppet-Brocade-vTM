# === Define: brocadevtm::bgpneighbors
#
# BGP Neighbor
# The "conf/bgpneighbors" directory contains configuration files for BGP
# neighbors.  The name of a file is the name of the neighbor configuration
# that it defines.  BGP neighbors can be managed under the "System > Fault
# Tolerance > BGP Neighbors" section of the Admin UI, or by using functions
# under the "BGPNeighbors" section of the SOAP API and CLI.
#
# === Parameters
#
# [*basic__address*]
# The IP address of the BGP neighbor
#
# [*basic__advertisement_interval*]
# The minimum interval between the sending of BGP routing updates to
# neighbors. Note that as a result of jitter, as defined for BGP, the interval
# during which no advertisements are sent will be between 75% and 100% of this
# value.
#
# [*basic__as_number*]
# The AS number for the BGP neighbor
#
# [*basic__authentication_password*]
# The password to be used for authentication of sessions with neighbors
#
# [*basic__holdtime*]
# The period after which the BGP session with the neighbor is deemed to have
# become idle - and requires re-establishment - if the neighbor falls silent.
#
# [*basic__keepalive*]
# The interval at which messages are sent to the BGP neighbor to keep the
# mutual BGP session established.
#
# [*basic__machines*]
# The traffic managers that are to use this neighbor
# Type:array
# Properties:
#
# === Examples
#
# brocadevtm::bgpneighbors { 'example':
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
define brocadevtm::bgpneighbors (
  $ensure,
  $basic__address                 = undef,
  $basic__advertisement_interval  = 5,
  $basic__as_number               = 65534,
  $basic__authentication_password = undef,
  $basic__holdtime                = 90,
  $basic__keepalive               = 30,
  $basic__machines                = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring bgpneighbors ${name}")
  vtmrest { "bgpneighbors/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/bgpneighbors.erb'),
    type     => 'application/json',
    internal => 'bgpneighbors',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/bgpneighbors", {ensure => present})
    file_line { "bgpneighbors/${name}":
      line => "bgpneighbors/${name}",
      path => "${purge_state_dir}/bgpneighbors",
    }
  }
}
