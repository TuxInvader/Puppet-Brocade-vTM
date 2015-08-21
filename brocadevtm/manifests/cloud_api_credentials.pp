# === Define: brocadevtm::cloud_api_credentials
#

define brocadevtm::cloud_api_credentials (
  $ensure,
  $basic__api_server        = "",
  $basic__cloud_api_timeout = 200,
  $basic__cred1             = "",
  $basic__cred2             = "",
  $basic__cred3             = "",
  $basic__script            = "",
  $basic__update_interval   = 30,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring cloud_api_credentials ${name}")
  vtmrest { "cloud_api_credentials/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/cloud_api_credentials.erb'),
    type => 'application/json',
    internal => 'cloud_api_credentials',
    debug => 0,
  }
}
