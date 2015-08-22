# === Define: brocadevtm::bandwidth
#
# Bandwidth Class
# A Bandwidth class, which can be assigned to a virtual server or pool in order to limit the number of bytes per second used by inbound or outbound traffic.
#
# === Parameters
#
# [*basic__maximum*]
# The maximum bandwidth to allocate to connections that are associated with this bandwidth class (in kbits/second).
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
  $basic__note    = "",
  $basic__sharing = "cluster",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring bandwidth ${name}")
  vtmrest { "bandwidth/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/bandwidth.erb'),
    type => 'application/json',
    internal => 'bandwidth',
    debug => 0,
  }
}
