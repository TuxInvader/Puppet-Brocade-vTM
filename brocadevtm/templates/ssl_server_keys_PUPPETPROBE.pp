# === Define: brocadevtm::ssl_server_keys_PUPPETPROBE
#

define brocadevtm::ssl_server_keys_PUPPETPROBE (
  $ensure,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring ssl_server_keys_PUPPETPROBE ${name}")
  vtmrest { "ssl/server_keys/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/ssl_server_keys_PUPPETPROBE.erb'),
    debug => 0,
  }
}
