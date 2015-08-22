# === Define: brocadevtm::rules
#
# Rule
# TrafficScript rules allow traffic inspection and modification.
#
# === Parameters
# 
# === Examples
# 
# brocadevtm::rules { 'example': 
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
define brocadevtm::rules (
  $ensure,
  $content,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rules ${name}")
  vtmrest { "rules/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => $content,
    type => 'application/octet-stream',
    debug => 0,
  }
}
