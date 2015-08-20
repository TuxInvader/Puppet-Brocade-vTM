# === Define: brocadevtm::aptimizer_scopes
#

define brocadevtm::aptimizer_scopes (
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

  info ("Configuring aptimizer_scopes ${name}")
  vtmrest { "aptimizer/scopes/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/aptimizer_scopes.erb'),
    internal => 'aptimizer_scopes',
    debug => 0,
  }
}
