# === Define: brocadevtm::glb_services
#

define brocadevtm::glb_services (
  $ensure,
  $basic__algorithm              = "hybrid",
  $basic__all_monitors_needed    = true,
  $basic__autorecovery           = true,
  $basic__chained_auto_failback  = false,
  $basic__chained_location_order = [],
  $basic__disable_on_failure     = false,
  $basic__dnssec_keys            = [],
  $basic__domains                = [],
  $basic__enabled                = false,
  $basic__geo_effect             = 50,
  $basic__last_resort_response   = [],
  $basic__location_draining      = [],
  $basic__location_settings      = [],
  $basic__return_ips_on_fail     = true,
  $basic__rules                  = [],
  $basic__ttl                    = -1,
  $log__enabled                  = false,
  $log__filename                 = "%zeushome%/zxtm/log/services/%g.log",
  $log__format                   = "%t, %s, %l, %q, %g, %n, %d, %a",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring glb_services ${name}")
  vtmrest { "glb_services/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/glb_services.erb'),
    internal => 'glb_services',
    debug => 0,
  }
}
