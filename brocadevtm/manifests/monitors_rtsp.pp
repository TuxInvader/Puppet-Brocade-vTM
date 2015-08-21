# === Class: brocadevtm::monitors_rtsp
#

class brocadevtm::monitors_rtsp (
  $ensure = present,
  $basic__back_off       = true,
  $basic__delay          = 5,
  $basic__failures       = 5,
  $basic__machine        = "",
  $basic__note           = "",
  $basic__scope          = "pernode",
  $basic__timeout        = 10,
  $basic__type           = "rtsp",
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

  info ("Configuring monitors_rtsp ${name}")
  vtmrest { "monitors/RTSP":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/monitors.erb'),
    type => 'application/json',
    internal => 'monitors_rtsp',
    debug => 0,
  }
}
