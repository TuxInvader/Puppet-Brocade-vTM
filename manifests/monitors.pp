# === Define: brocadevtm::monitors
#
# Monitor
# Monitors check important remote services are running, by periodically
# sending them traffic and checking the response is correct. They are used by
# virtual servers to detect the failure of backend nodes.
#
# === Parameters
#
# [*basic__back_off*]
# Should the monitor slowly increase the delay after it has failed?
#
# [*basic__can_edit_ssl*]
# Whether or not SSL configuration is available via the Admin Server UI for
# this monitor.  This is for use by monitors pre-packaged with the software.
#
# [*basic__can_use_ssl*]
# Whether or not monitors of this type are capable of using SSL.
#
# [*basic__delay*]
# The minimum time between calls to a monitor.
#
# [*basic__editable_keys*]
# Which of the monitor's configuration keys may be edited via the Admin Server
# UI.
# Type:array
# Properties:
#
# [*basic__factory*]
# Whether or not this monitor is provided as part of the software release.
#
# [*basic__failures*]
# The number of times in a row that a node must fail execution of the monitor
# before it is classed as unavailable.
#
# [*basic__health_only*]
# Should this monitor only report health (ignore load)?
#
# [*basic__machine*]
# The machine to monitor, where relevant this should be in the form
# "<hostname>:<port>", for "ping" monitors the ":<port>" part must not be
# specified.
#
# [*basic__note*]
# A description of the monitor.
#
# [*basic__scope*]
# A monitor can either monitor each node in the pool separately and disable an
# individual node if it fails, or it can monitor a specific machine and
# disable the entire pool if that machine fails. GLB location monitors must
# monitor a specific machine.
#
# [*basic__timeout*]
# The maximum runtime for an individual instance of the monitor.
#
# [*basic__type*]
# The internal monitor implementation of this monitor.
#
# [*basic__use_ssl*]
# Whether or not the monitor should connect using SSL.
#
# [*basic__verbose*]
# Whether or not the monitor should emit verbose logging. This is useful for
# diagnosing problems.
#
# [*http__authentication*]
# The HTTP basic-auth "<user>:<password>" to use for the test HTTP request.
#
# [*http__body_regex*]
# A regular expression that the HTTP response body must match.  If the
# response body content doesn't matter then set this to ".*" (match anything).
#
# [*http__host_header*]
# The host header to use in the test HTTP request.
#
# [*http__path*]
# The path to use in the test HTTP request.  This must be a string beginning
# with a "/" (forward slash).
#
# [*http__status_regex*]
# A regular expression that the HTTP status code must match.  If the status
# code doesn't matter then set this to ".*" (match anything).
#
# [*rtsp__body_regex*]
# The regular expression that the RTSP response body must match.
#
# [*rtsp__path*]
# The path to use in the RTSP request (some servers will return 500 Internal
# Server Error unless this is a valid media file).
#
# [*rtsp__status_regex*]
# The regular expression that the RTSP response status code must match.
#
# [*script__arguments*]
# A table containing arguments and argument values to be passed to the monitor
# program.
# Type:array
# Properties:{"name"=>{"description"=>"The name of the argument to be passed
# to the monitor program.", "type"=>"string"}, "value"=>{"description"=>"The
# value of the argument to be passed to the monitor program.",
# "type"=>"string"}, "description"=>{"description"=>"A description for the
# argument provided to the program.", "type"=>"string", "default"=>""}}
#
# [*script__program*]
# The program to run.  This must be an executable file, either within the
# monitor scripts directory or specified as an absolute path to some other
# location on the filesystem.
#
# [*sip__body_regex*]
# The regular expression that the SIP response body must match.
#
# [*sip__status_regex*]
# The regular expression that the SIP response status code must match.
#
# [*sip__transport*]
# Which transport protocol the SIP monitor will use to query the server.
#
# [*tcp__close_string*]
# An optional string to write to the server before closing the connection.
#
# [*tcp__max_response_len*]
# The maximum amount of data to read back from a server, use 0 for unlimited.
# Applies to TCP and HTTP monitors.
#
# [*tcp__response_regex*]
# A regular expression to match against the response from the server. Applies
# to TCP monitors only.
#
# [*tcp__write_string*]
# The string to write down the TCP connection.
#
# [*udp__accept_all*]
# If this monitor uses UDP, should it accept responses from any IP and port?
#
# === Examples
#
# brocadevtm::monitors { 'example':
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
define brocadevtm::monitors (
  $ensure,
  $basic__back_off       = true,
  $basic__delay          = 3,
  $basic__failures       = 3,
  $basic__health_only    = false,
  $basic__machine        = undef,
  $basic__note           = undef,
  $basic__scope          = 'pernode',
  $basic__timeout        = 3,
  $basic__type           = 'ping',
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

  info ("Configuring monitors ${name}")
  vtmrest { "monitors/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/monitors.erb'),
    type     => 'application/json',
    internal => 'monitors',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/monitors", {ensure => present})
    file_line { "monitors/${name}":
      line => "monitors/${name}",
      path => "${purge_state_dir}/monitors",
    }
  }
}
