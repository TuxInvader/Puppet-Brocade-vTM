# === Define: brocadevtm::persistence_PUPPETPROBE
#

define brocadevtm::persistence_PUPPETPROBE (
  $ensure,
  $basic__cookie       = "",
  $basic__delete       = true,
  $basic__failure_mode = "new_node",
  $basic__note         = "",
  $basic__type         = "ip",
  $basic__url          = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring persistence_PUPPETPROBE ${name}")
  vtmrest { "persistence/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/persistence_PUPPETPROBE.erb'),
    debug => 0,
  }
}
