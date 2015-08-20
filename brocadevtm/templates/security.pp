# === Define: brocadevtm::security
#

define brocadevtm::security (
  $ensure,
  $basic__access = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring security ${name}")
  vtmrest { "security/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/security.erb'),
    internal => 'security',
    debug => 0,
  }
}
