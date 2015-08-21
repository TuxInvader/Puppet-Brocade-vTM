# === Define: brocadevtm::custom
#

define brocadevtm::custom (
  $ensure,
  $basic__string_lists = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring custom ${name}")
  vtmrest { "custom/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/custom.erb'),
    type => 'application/json',
    internal => 'custom',
    debug => 0,
  }
}
