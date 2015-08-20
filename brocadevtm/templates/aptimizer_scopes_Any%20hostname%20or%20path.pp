# === Define: brocadevtm::aptimizer_scopes_Any%20hostname%20or%20path
#

define brocadevtm::aptimizer_scopes_Any%20hostname%20or%20path (
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

  info ("Configuring aptimizer_scopes_Any%20hostname%20or%20path ${name}")
  vtmrest { "aptimizer/scopes/Any%20hostname%20or%20path/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/aptimizer_scopes_Any%20hostname%20or%20path.erb'),
    internal => 'aptimizer_scopes_Any%20hostname%20or%20path',
    debug => 0,
  }
}
