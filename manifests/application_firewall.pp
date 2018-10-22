# === class: brocadevtm::application_firewall
#
# Pulse Secure Virtual Web Application Firewall
# The "conf/zeusafm.conf" file contains configuration files for the
# application firewall. Some keys present in the "zeusafm.conf" are not
# documented here. Refer to the Pulse Secure Web Application Firewall
# documentation for further details. The configuration can be edited under the
# "System > Application Firewall" section of the Administration Server or by
# using functions under the "AFM" section of the SOAP API and CLI.
#
# === Parameters
#
# === Examples
#
# class {'brocadevtm::application_firewall':
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
class brocadevtm::application_firewall (
  $ensure  = present,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring application_firewall ${name}")
  vtmrest { 'application_firewall':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/application_firewall.erb'),
    type     => 'application/json',
    internal => 'application_firewall',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/application_firewall", {ensure => present})
    file_line { 'application_firewall':
      line => 'application_firewall',
      path => "${purge_state_dir}/application_firewall",
    }
  }
}
