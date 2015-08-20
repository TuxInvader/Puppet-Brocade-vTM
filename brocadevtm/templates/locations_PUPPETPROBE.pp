# === Define: brocadevtm::locations_PUPPETPROBE
#

define brocadevtm::locations_PUPPETPROBE (
  $ensure,
  $basic__id        = 1,
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

  info ("Configuring locations_PUPPETPROBE ${name}")
  vtmrest { "locations/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/locations_PUPPETPROBE.erb'),
    debug => 0,
  }
}
