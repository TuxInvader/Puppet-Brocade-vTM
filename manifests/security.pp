# === class: brocadevtm::security
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
# inaccessible.</br>Access to the admin UI will not be affected until it is
# restarted.
# Type:array
# Properties:
#
# [*ssh_intrusion__bantime*]
# The amount of time in seconds to ban an offending host for.
#
# [*ssh_intrusion__blacklist*]
# The list of hosts to permanently ban, identified by IP address or DNS
# hostname in a space-separated list.
# Type:array
# Properties:
#
# [*ssh_intrusion__enabled*]
# Whether or not the SSH Intrusion Prevention tool is enabled.
#
# [*ssh_intrusion__findtime*]
# The window of time in seconds the maximum number of connection attempts
# applies to. More than (maxretry) failed attempts in this time span will
# trigger a ban.
#
# [*ssh_intrusion__maxretry*]
# The number of failed connection attempts a host can make before being banned.
#
# [*ssh_intrusion__whitelist*]
# The list of hosts to never ban, identified by IP address, DNS hostname or
# subnet mask, in a space-separated list.
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
  $ensure                   = present,
  $basic__access            = '[]',
  $ssh_intrusion__bantime   = 600,
  $ssh_intrusion__blacklist = '[]',
  $ssh_intrusion__enabled   = false,
  $ssh_intrusion__findtime  = 600,
  $ssh_intrusion__maxretry  = 6,
  $ssh_intrusion__whitelist = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring security ${name}")
  vtmrest { 'security':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/security.erb'),
    type     => 'application/json',
    internal => 'security',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/security", {ensure => present})
    file_line { 'security':
      line => 'security',
      path => "${purge_state_dir}/security",
    }
  }
}
