# === Define: brocadevtm::event_types
#
# Event Type
# Configuration that ties actions to a set of events that trigger them.
#
# === Parameters
#
# [*basic__actions*]
# The actions triggered by events matching this event type, as a list of
# action references.
# Type:array
# Properties:
#
# [*basic__built_in*]
# If set to "Yes" this indicates that this configuration is built-in (provided
# as part of the software) and must not be deleted or edited.
#
# [*basic__log2mainlog*]
# Whether or not the triggering of this event type will be logged to the main
# event log.
#
# [*basic__note*]
# A description of this event type.
#
# [*cloudcredentials__event_tags*]
# Cloud credentials event tags
# Type:array
# Properties:
#
# [*cloudcredentials__objects*]
# Cloud credentials object names
# Type:array
# Properties:
#
# [*config__event_tags*]
# Configuration file event tags
# Type:array
# Properties:
#
# [*faulttolerance__event_tags*]
# Fault tolerance event tags
# Type:array
# Properties:
#
# [*general__event_tags*]
# General event tags
# Type:array
# Properties:
#
# [*glb__event_tags*]
# GLB service event tags
# Type:array
# Properties:
#
# [*glb__objects*]
# GLB service object names
# Type:array
# Properties:
#
# [*java__event_tags*]
# Java event tags
# Type:array
# Properties:
#
# [*licensekeys__event_tags*]
# License key event tags
# Type:array
# Properties:
#
# [*licensekeys__objects*]
# License key object names
# Type:array
# Properties:
#
# [*locations__event_tags*]
# Location event tags
# Type:array
# Properties:
#
# [*locations__objects*]
# Location object names
# Type:array
# Properties:
#
# [*monitors__event_tags*]
# Monitor event tags
# Type:array
# Properties:
#
# [*monitors__objects*]
# Monitors object names
# Type:array
# Properties:
#
# [*pools__event_tags*]
# Pool key event tags
# Type:array
# Properties:
#
# [*pools__objects*]
# Pool object names
# Type:array
# Properties:
#
# [*protection__event_tags*]
# Service protection class event tags
# Type:array
# Properties:
#
# [*protection__objects*]
# Service protection class object names
# Type:array
# Properties:
#
# [*rules__event_tags*]
# Rule event tags
# Type:array
# Properties:
#
# [*rules__objects*]
# Rule object names
# Type:array
# Properties:
#
# [*slm__event_tags*]
# SLM class event tags
# Type:array
# Properties:
#
# [*slm__objects*]
# SLM class object names
# Type:array
# Properties:
#
# [*ssl__event_tags*]
# SSL event tags
# Type:array
# Properties:
#
# [*sslhw__event_tags*]
# SSL hardware event tags
# Type:array
# Properties:
#
# [*trafficscript__event_tags*]
# TrafficScript event tags
# Type:array
# Properties:
#
# [*vservers__event_tags*]
# Virtual server event tags
# Type:array
# Properties:
#
# [*vservers__objects*]
# Virtual server object names
# Type:array
# Properties:
#
# [*zxtms__event_tags*]
# Traffic manager event tags
# Type:array
# Properties:
#
# [*zxtms__objects*]
# Traffic manager object names
# Type:array
# Properties:
#
# === Examples
#
# brocadevtm::event_types { 'example':
#     ensure => present,
# }
#
#
# === Authors
#
# Mark Boddington <mbodding@brocade>
#
# === Copyright
#
# Copyright 2015 Brocade
#
define brocadevtm::event_types (
  $ensure,
  $basic__actions               = '[]',
  $basic__built_in              = false,
  $basic__note                  = undef,
  $cloudcredentials__event_tags = '[]',
  $cloudcredentials__objects    = '[]',
  $config__event_tags           = '[]',
  $faulttolerance__event_tags   = '[]',
  $general__event_tags          = '[]',
  $glb__event_tags              = '[]',
  $glb__objects                 = '[]',
  $java__event_tags             = '[]',
  $licensekeys__event_tags      = '[]',
  $licensekeys__objects         = '[]',
  $locations__event_tags        = '[]',
  $locations__objects           = '[]',
  $monitors__event_tags         = '[]',
  $monitors__objects            = '[]',
  $pools__event_tags            = '[]',
  $pools__objects               = '[]',
  $protection__event_tags       = '[]',
  $protection__objects          = '[]',
  $rules__event_tags            = '[]',
  $rules__objects               = '[]',
  $slm__event_tags              = '[]',
  $slm__objects                 = '[]',
  $ssl__event_tags              = '[]',
  $sslhw__event_tags            = '[]',
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

  info ("Configuring event_types ${name}")
  vtmrest { "event_types/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/event_types.erb'),
    type     => 'application/json',
    internal => 'event_types',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/event_types", {ensure => present})
    file_line { "event_types/${name}":
      line => "event_types/${name}",
      path => "${purge_state_dir}/event_types",
    }
  }
}
