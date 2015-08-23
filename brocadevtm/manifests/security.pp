# === Class: brocadevtm::security
#
# Security Settings
# Security settings that restrict remote administration for the cluster.
# Additional security options can be found in Global Settings.
#
# === Parameters
#
# [*basic__access*]
# Access to the admin server and REST API is restricted by usernames and
# passwords. You can further restrict access to just trusted IP addresses,
# CIDR IP subnets or DNS wildcards. These access restrictions are also used
# when another traffic manager initially joins the cluster, after joining the
# cluster these restrictions are no longer used. Care must be taken when
# changing this setting, as it can cause the administration server to become
# inaccessable.</br>Access to the admin UI will not be affected until it is
# restarted.
# Type:array
# Properties:
#
# === Examples
#
# class {'brocadevtm::security':
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
class brocadevtm::security (
  $ensure = present,
  $basic__access = '[]',
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring security ${name}")
  vtmrest { 'security':
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => template('brocadevtm/security.erb'),
    type       => 'application/json',
    internal   => 'security',
    debug      => 0,
  }
}
