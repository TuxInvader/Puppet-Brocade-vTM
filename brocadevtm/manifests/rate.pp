# === Define: brocadevtm::rate
#

define brocadevtm::rate (
  $ensure,
  $basic__max_rate_per_minute = 0,
  $basic__max_rate_per_second = 0,
  $basic__note                = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rate ${name}")
  vtmrest { "rate/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/rate.erb'),
    internal => 'rate',
    debug => 0,
  }
}
