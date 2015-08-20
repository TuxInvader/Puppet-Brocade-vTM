# === Define: brocadevtm::aptimizer_scopes_PUPPETPROBE
#

define brocadevtm::aptimizer_scopes_PUPPETPROBE (
  $ensure,
  $basic__canonical_hostname = "",
  $basic__hostnames          = [],
  $basic__root               = "/",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring aptimizer_scopes_PUPPETPROBE ${name}")
  vtmrest { "aptimizer/scopes/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/aptimizer_scopes_PUPPETPROBE.erb'),
    debug => 0,
  }
}
