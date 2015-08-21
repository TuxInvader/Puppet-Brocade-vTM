# === Class: brocadevtm::monitors_dns
#

class brocadevtm::monitors_dns (
  $ensure = present,
  $basic__back_off       = true,
  $basic__delay          = 5,
  $basic__failures       = 3,
  $basic__machine        = "",
  $basic__note           = "",
  $basic__scope          = "pernode",
  $basic__timeout        = 5,
  $basic__type           = "program",
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
  $script__arguments     = [{"name"=>"response_addr", "description"=>"Address to expect in DNS response", "value"=>""}, {"name"=>"request_host", "description"=>"The DNS monitor sends a DNS query to the DNS server running on port 53 on the monitored node.<br>Hostname to look up in DNS:", "value"=>""}],
  $script__program       = "dns.pl",
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

  info ("Configuring monitors_dns ${name}")
  vtmrest { "monitors/DNS":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/monitors.erb'),
    type => 'application/json',
    internal => 'monitors_dns',
    debug => 0,
  }
}
