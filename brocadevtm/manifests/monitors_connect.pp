# === Class: brocadevtm::monitors_connect
#

class brocadevtm::monitors_connect (
  $ensure = present,
  $basic__back_off       = true,
  $basic__delay          = 2,
  $basic__failures       = 3,
  $basic__machine        = "",
  $basic__note           = "",
  $basic__scope          = "pernode",
  $basic__timeout        = 5,
  $basic__type           = "connect",
  $basic__use_ssl        = false,
  $basic__verbose        = false,
  $http__authentication  = "",
  $http__body_regex      = "",
  $http__host_header     = "",
  $http__path            = "/",
  $http__status_regex    = "^[234][0-9][0-9]\\\$",
  $rtsp__body_regex      = "",
  $rtsp__path            = "/",
  $rtsp__status_regex    = "^[234][0-9][0-9]\\\$",
  $script__arguments     = [],
  $script__program       = "",
  $sip__body_regex       = "",
  $sip__status_regex     = "^[234][0-9][0-9]\\\$",
  $sip__transport        = "udp",
  $tcp__close_string     = "",
  $tcp__max_response_len = 2048,
  $tcp__response_regex   = ".+",
  $tcp__write_string     = "",
  $udp__accept_all       = false,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring monitors_connect ${name}")
  vtmrest { "monitors/Connect":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/monitors.erb'),
    type => 'application/json',
    internal => 'monitors_connect',
    debug => 0,
  }
}
