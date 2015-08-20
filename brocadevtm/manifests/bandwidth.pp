# === Define: brocadevtm::bandwidth
#

define brocadevtm::bandwidth (
  $ensure,
  $basic__maximum = 10000,
  $basic__note    = "",
  $basic__sharing = "cluster",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring bandwidth ${name}")
  vtmrest { "bandwidth/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/bandwidth.erb'),
    internal => 'bandwidth',
    debug => 0,
  }
}
