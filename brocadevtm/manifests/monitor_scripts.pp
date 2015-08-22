# === Define: brocadevtm::monitor_scripts
#
# Monitor Program
# An executable program that can be used to by external program monitors to report the health of backend services.
#
# === Parameters
# 
# === Examples
# 
# brocadevtm::monitor_scripts { 'example': 
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
define brocadevtm::monitor_scripts (
  $ensure,
  $content,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring monitor_scripts ${name}")
  vtmrest { "monitor_scripts/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => $content,
    type => 'application/octet-stream',
    debug => 0,
  }
}
