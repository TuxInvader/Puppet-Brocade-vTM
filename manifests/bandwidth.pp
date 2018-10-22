# === Define: brocadevtm::bandwidth
#
# Bandwidth Class
# A Bandwidth class, which can be assigned to a virtual server or pool in
# order to limit the number of bytes per second used by inbound or outbound
# traffic.
#
# === Parameters
#
# [*basic__maximum*]
# The maximum bandwidth to allocate to connections that are associated with
# this bandwidth class (in kbits/second).
#
# [*basic__note*]
# A description of this bandwidth class.
#
# [*basic__sharing*]
# The scope of the bandwidth class.
#
# === Examples
#
# brocadevtm::bandwidth { 'example':
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
define brocadevtm::bandwidth (
  $ensure,
  $basic__maximum = 10000,
  $basic__note    = undef,
  $basic__sharing = 'cluster',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring bandwidth ${name}")
  vtmrest { "bandwidth/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/bandwidth.erb'),
    type     => 'application/json',
    internal => 'bandwidth',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/bandwidth", {ensure => present})
    file_line { "bandwidth/${name}":
      line => "bandwidth/${name}",
      path => "${purge_state_dir}/bandwidth",
    }
  }
}
