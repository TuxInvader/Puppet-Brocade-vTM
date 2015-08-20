# === Define: brocadevtm::dns_server_zones
#

define brocadevtm::dns_server_zones (
  $ensure,
  $basic__origin,
  $basic__zonefile,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring dns_server_zones ${name}")
  vtmrest { "dns_server/zones/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/dns_server_zones.erb'),
    internal => 'dns_server_zones',
    debug => 0,
  }
}
