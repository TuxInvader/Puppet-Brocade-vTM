# === Define: brocadevtm::ssl_server_keys
#

define brocadevtm::ssl_server_keys (
  $ensure,
  $basic__public,
  $basic__private,
  $basic__note    = "",
  $basic__request = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring ssl_server_keys ${name}")
  vtmrest { "ssl/server_keys/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/ssl_server_keys.erb'),
    internal => 'ssl_server_keys',
    debug => 0,
  }
}
