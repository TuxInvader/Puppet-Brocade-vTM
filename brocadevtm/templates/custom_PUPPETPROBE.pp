# === Define: brocadevtm::custom_PUPPETPROBE
#

define brocadevtm::custom_PUPPETPROBE (
  $ensure,
  $basic__string_lists = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring custom_PUPPETPROBE ${name}")
  vtmrest { "custom/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/custom_PUPPETPROBE.erb'),
    debug => 0,
  }
}
