# === Define: brocadevtm::locations
#

define brocadevtm::locations (
  $ensure,
  $basic__id,
  $basic__latitude  = 0.0,
  $basic__longitude = 0.0,
  $basic__note      = "",
  $basic__type      = "config",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring locations ${name}")
  vtmrest { "locations/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/locations.erb'),
    internal => 'locations',
    debug => 0,
  }
}
