# === Define: brocadevtm::custom
#
# Custom configuration set
# Custom configuration sets store arbitrary named values. These values can be
# read by SOAP or REST clients.
#
# === Parameters
#
# [*basic__string_lists*]
# This table contains named lists of strings
# Type:array
# Properties:{"name"=>{"description"=>"Name of list", "type"=>"string"},
# "value"=>{"description"=>"Named list of user-specified strings.",
# "type"=>"array", "uniqueItems"=>false, "items"=>{"type"=>"string"}}}
#
# === Examples
#
# brocadevtm::custom { 'example':
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
define brocadevtm::custom (
  $ensure,
  $basic__string_lists = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring custom ${name}")
  vtmrest { "custom/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/custom.erb'),
    type     => 'application/json',
    internal => 'custom',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/custom", {ensure => present})
    file_line { "custom/${name}":
      line => "custom/${name}",
      path => "${purge_state_dir}/custom",
    }
  }
}
