# === Class: brocadevtm::security
#

class brocadevtm::security (
  $ensure = present,
  $basic__access = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring security ${name}")
  vtmrest { "security":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/security.erb'),
    type => 'application/json',
    internal => 'security',
    debug => 0,
  }
}
