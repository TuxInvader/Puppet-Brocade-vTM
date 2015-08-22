# === Define: brocadevtm::extra_files
#
# Extra File
# A user-uploaded file. Such files can be used in TrafficScript code using the "resource.get" function.
#
# === Parameters
# 
# === Examples
# 
# brocadevtm::extra_files { 'example': 
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
define brocadevtm::extra_files (
  $ensure,
  $content,
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring extra_files ${name}")
  vtmrest { "extra_files/${name}":
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => $content,
    type       => 'application/octet-stream',
    debug      => 0,
  }
}
