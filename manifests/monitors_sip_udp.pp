# === class: brocadevtm::monitors_sip_udp
#
# This class is a direct implementation of brocadvtm::monitors
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::monitors_sip_udp (
  $ensure                = present,
  $basic__back_off       = true,
  $basic__delay          = 5,
  $basic__failures       = 5,
  $basic__health_only    = false,
  $basic__machine        = undef,
  $basic__note           = undef,
  $basic__scope          = 'pernode',
  $basic__timeout        = 10,
  $basic__type           = 'sip',
  $basic__use_ssl        = false,
  $basic__verbose        = false,
  $http__authentication  = undef,
  $http__body_regex      = undef,
  $http__host_header     = undef,
  $http__path            = '/',
  $http__status_regex    = '^[234][0-9][0-9]$',
  $rtsp__body_regex      = undef,
  $rtsp__path            = '/',
  $rtsp__status_regex    = '^[234][0-9][0-9]$',
  $script__arguments     = '[]',
  $script__program       = undef,
  $sip__body_regex       = undef,
  $sip__status_regex     = '^[234][0-9][0-9]$',
  $sip__transport        = 'udp',
  $tcp__close_string     = undef,
  $tcp__max_response_len = 2048,
  $tcp__response_regex   = '.+',
  $tcp__write_string     = undef,
  $udp__accept_all       = false,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring monitors_sip_udp ${name}")
  vtmrest { 'monitors/SIP%20UDP':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/8.3/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/monitors.erb'),
    type     => 'application/json',
    internal => 'monitors_sip_udp',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/monitors", {ensure => present})
    file_line { 'monitors/SIP%20UDP':
      line => 'monitors/SIP%20UDP',
      path => "${purge_state_dir}/monitors",
    }
  }
}
