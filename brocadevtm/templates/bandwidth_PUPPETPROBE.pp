# === Define: brocadevtm::bandwidth_PUPPETPROBE
#

define brocadevtm::bandwidth_PUPPETPROBE (
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

  info ("Configuring bandwidth_PUPPETPROBE ${name}")
  vtmrest { "bandwidth/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/bandwidth_PUPPETPROBE.erb'),
    debug => 0,
  }
}
