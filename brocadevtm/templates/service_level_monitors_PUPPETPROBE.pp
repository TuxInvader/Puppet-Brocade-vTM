# === Define: brocadevtm::service_level_monitors_PUPPETPROBE
#

define brocadevtm::service_level_monitors_PUPPETPROBE (
  $ensure,
  $basic__note              = "",
  $basic__response_time     = 1000,
  $basic__serious_threshold = 0,
  $basic__warning_threshold = 50,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring service_level_monitors_PUPPETPROBE ${name}")
  vtmrest { "service_level_monitors/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/service_level_monitors_PUPPETPROBE.erb'),
    debug => 0,
  }
}
