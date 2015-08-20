# === Define: brocadevtm::event_types_Routing%20Software
#

define brocadevtm::event_types_Routing%20Software (
  $ensure,
  $basic__actions               = [],
  $basic__built_in              = true,
  $basic__note                  = "Events relating to the integrated routing software used for Route Health Injection",
  $cloudcredentials__event_tags = [],
  $cloudcredentials__objects    = [],
  $config__event_tags           = [],
  $faulttolerance__event_tags   = ["routingswoperational", "routingswfailurelimitreached", "routingswfailed", "routingswstartfailed", "ospfneighborsok", "ospfneighborsfailed", "ospfneighborsdegraded"],
  $general__event_tags          = [],
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
  $rules__event_tags            = [],
  $rules__objects               = [],
  $slm__event_tags              = [],
  $slm__objects                 = [],
  $ssl__event_tags              = [],
  $sslhw__event_tags            = [],
  $trafficscript__event_tags    = [],
  $vservers__event_tags         = [],
  $vservers__objects            = [],
  $zxtms__event_tags            = [],
  $zxtms__objects               = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring event_types_Routing%20Software ${name}")
  vtmrest { "event_types/Routing%20Software/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/event_types_Routing%20Software.erb'),
    internal => 'event_types_Routing%20Software',
    debug => 0,
  }
}
