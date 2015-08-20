# === Define: brocadevtm::protection_PUPPETPROBE
#

define brocadevtm::protection_PUPPETPROBE (
  $ensure,
  $basic__debug                             = false,
  $basic__enabled                           = true,
  $basic__log_time                          = 60,
  $basic__note                              = "",
  $basic__per_process_connection_count      = true,
  $basic__rule                              = "",
  $basic__testing                           = false,
  $access_restriction__allowed              = [],
  $access_restriction__banned               = [],
  $connection_limiting__max_10_connections  = 200,
  $connection_limiting__max_1_connections   = 30,
  $connection_limiting__max_connection_rate = 0,
  $connection_limiting__min_connections     = 4,
  $connection_limiting__rate_timer          = 60,
  $http__check_rfc2396                      = false,
  $http__max_body_length                    = 0,
  $http__max_header_length                  = 0,
  $http__max_request_length                 = 0,
  $http__max_url_length                     = 0,
  $http__reject_binary                      = false,
  $http__send_error_page                    = true,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring protection_PUPPETPROBE ${name}")
  vtmrest { "protection/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/protection_PUPPETPROBE.erb'),
    debug => 0,
  }
}
