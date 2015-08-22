# === Define: brocadevtm::kerberos_krb5confs
#
# Kerberos Configuration File
# A Kerberos krb5.conf file that provides the raw configuration for a Kerberos principal.
#
# === Parameters
# 
# === Examples
# 
# brocadevtm::kerberos_krb5confs { 'example': 
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
define brocadevtm::kerberos_krb5confs (
  $ensure,
  $content,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring kerberos_krb5confs ${name}")
  vtmrest { "kerberos/krb5confs/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => $content,
    type => 'application/octet-stream',
    debug => 0,
  }
}
