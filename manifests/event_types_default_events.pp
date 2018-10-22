# === class: brocadevtm::event_types_default_events
#
# This class is a direct implementation of brocadvtm::event_types
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::event_types_default_events (
  $ensure                       = present,
  $basic__actions               = '[]',
  $basic__built_in              = true,
  $basic__note                  = undef,
  $cloudcredentials__event_tags = '[]',
  $cloudcredentials__objects    = '[]',
  $config__event_tags           = '[]',
  $faulttolerance__event_tags   = '["allmachinesok","flipperbackendsworking","dropipinfo","dropipwarn","flipperfrontendsworking","machineok","machinetimeout","pingfrontendfail","pinggwfail","flipperipexists","machinefail","flipperraiselocalworking","flipperraiseosdrop","flipperraiseothersdead","flipperdadreraise","pingbackendfail","flipperrecovered","activatedautomatically","activatealldead","ec2flipperraiselocalworking","ec2flipperraiseothersdead","dropec2ipwarn","ec2nopublicip"]',
  $general__event_tags          = '["appliance"]',
  $glb__event_tags              = '[]',
  $glb__objects                 = '[]',
  $java__event_tags             = '[]',
  $licensekeys__event_tags      = '["expiresoon","expired","unlicensed"]',
  $licensekeys__objects         = '["*"]',
  $locations__event_tags        = '[]',
  $locations__objects           = '[]',
  $monitors__event_tags         = '["monitorok","monitorfail"]',
  $monitors__objects            = '["*"]',
  $pools__event_tags            = '["poolok","pooldied","nodeworking","nodefail"]',
  $pools__objects               = '["*"]',
  $protection__event_tags       = '["triggersummary"]',
  $protection__objects          = '["*"]',
  $rules__event_tags            = '[]',
  $rules__objects               = '[]',
  $slm__event_tags              = '["slmnodeinfo","slmrecoveredserious","slmfallenbelowserious"]',
  $slm__objects                 = '["*"]',
  $ssl__event_tags              = '[]',
  $sslhw__event_tags            = '["sslhwrestart","sslhwstart","sslhwfail"]',
  $trafficscript__event_tags    = '[]',
  $vservers__event_tags         = '[]',
  $vservers__objects            = '[]',
  $zxtms__event_tags            = '[]',
  $zxtms__objects               = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring event_types_default_events ${name}")
  vtmrest { 'event_types/Default%20Events':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/event_types.erb'),
    type     => 'application/json',
    internal => 'event_types_default_events',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/event_types", {ensure => present})
    file_line { 'event_types/Default%20Events':
      line => 'event_types/Default%20Events',
      path => "${purge_state_dir}/event_types",
    }
  }
}
