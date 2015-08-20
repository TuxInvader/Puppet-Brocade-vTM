# === Define: brocadevtm::user_groups
#

define brocadevtm::user_groups (
  $ensure,
  $basic__description          = "",
  $basic__password_expire_time = 0,
  $basic__permissions          = [],
  $basic__timeout              = 30,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring user_groups ${name}")
  vtmrest { "user_groups/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/user_groups.erb'),
    internal => 'user_groups',
    debug => 0,
  }
}
