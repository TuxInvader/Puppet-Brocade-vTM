# === Class: brocadevtm::aptimizer_scopes_any_hostname_or_path
#

class brocadevtm::aptimizer_scopes_any_hostname_or_path (
  $ensure = present,
  $basic__canonical_hostname = "",
  $basic__hostnames          = [],
  $basic__root               = "/",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring aptimizer_scopes_any_hostname_or_path ${name}")
  vtmrest { "aptimizer/scopes/Any%20hostname%20or%20path":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/aptimizer_scopes.erb'),
    type => 'application/json',
    internal => 'aptimizer_scopes_any_hostname_or_path',
    debug => 0,
  }
}
