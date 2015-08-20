# === Class: brocadevtm::event_types_Resource%20Starvation
#

class brocadevtm::event_types_Resource%20Starvation (
  $ensure = present,
  $basic__actions               = [],
  $basic__built_in              = true,
  $basic__note                  = "Events triggered when we have run out of system resources or hit a configured limit in the Stingray Traffic Manager.",
  $cloudcredentials__event_tags = [],
  $cloudcredentials__objects    = [],
  $config__event_tags           = [],
  $faulttolerance__event_tags   = [],
  $general__event_tags          = ["fewfreefds"],
  $glb__event_tags              = [],
  $glb__objects                 = [],
  $java__event_tags             = [],
  $licensekeys__event_tags      = [],
  $licensekeys__objects         = [],
  $locations__event_tags        = [],
  $locations__objects           = [],
  $monitors__event_tags         = [],
  $monitors__objects            = [],
  $pools__event_tags            = [],
  $pools__objects               = [],
  $protection__event_tags       = [],
  $protection__objects          = [],
  $rules__event_tags            = ["rulebufferlarge"],
  $rules__objects               = ["*"],
  $slm__event_tags              = [],
  $slm__objects                 = [],
  $ssl__event_tags              = [],
  $sslhw__event_tags            = [],
  $trafficscript__event_tags    = [],
  $vservers__event_tags         = ["maxclientbufferdrop", "responsetoolarge", "rtspstreamnoports", "sipstreamnoports"],
  $vservers__objects            = ["*"],
  $zxtms__event_tags            = [],
  $zxtms__objects               = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring event_types_Resource%20Starvation ${name}")
  vtmrest { "event_types/Resource%20Starvation":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/event_types_Resource%20Starvation.erb'),
    internal => 'event_types_Resource%20Starvation',
    debug => 0,
  }
}
