# === Define: brocadevtm::protection
#
# Protection Class
# A protection class specifies the level of protection against network attacks
# for a virtual server.
#
# === Parameters
#
# [*basic__debug*]
# Whether or not to output verbose logging.
#
# [*basic__enabled*]
# Enable or disable this service protection class.
#
# [*basic__linger_time*]
# After sending a HTTP error message to a client, wait up to this time before
# closing the connection.
#
# [*basic__log_time*]
# Log service protection messages at these intervals. If set to "0" no
# messages will be logged and no alerts will be sent.
#
# [*basic__note*]
# A description of the service protection class.
#
# [*basic__rule*]
# A TrafficScript rule that will be run on the connection after the service
# protection criteria have been evaluated.  This rule will be executed prior
# to normal rules configured for the virtual server.
#
# [*basic__testing*]
# Place the service protection class into testing mode. (Log when this class
# would have dropped a connection, but allow all connections through).
#
# [*access_restriction__allowed*]
# Always allow access to these IP addresses. This overrides the connection
# limits for these machines, but does not stop other restrictions such as HTTP
# validity checks.
# Type:array
# Properties:
#
# [*access_restriction__banned*]
# Disallow access to these IP addresses.
# Type:array
# Properties:
#
# [*concurrent_connections__max_10_connections*]
# Additional limit on maximum concurrent connections from the top 10 busiest
# connecting IP addresses combined.  The value should be between 1 and 10
# times the "max_1_connections" limit.
# (This limit is disabled if "per_process_connection_count" is "No", or
# "max_1_connections" is "0", or "min_connections" is "0".)
#
# [*concurrent_connections__max_1_connections*]
# Maximum concurrent connections each connecting IP address is allowed. Set to
# "0" to disable this limit.
#
# [*concurrent_connections__min_connections*]
# Entry threshold for the "max_10_connections" limit: the "max_10_connections"
# limit is not applied to connecting IP addresses with this many or fewer
# concurrent connections.
# Setting to "0" disables both the "max_1_connections" and
# "max_10_connections" limits, if "per_process_connection_count" is "Yes". (If
# "per_process_connection_count" is "No", this setting is ignored.)
#
# [*concurrent_connections__per_process_connection_count*]
# Whether concurrent connection counting and limits are per-process. (Each
# Traffic Manager typically has several processes: one process per available
# CPU core.)
# If "Yes", a connecting IP address may make that many connections to each
# process within a Traffic Manager. If "No", a connecting IP address may make
# that many connections to each Traffic Manager as a whole.
#
# [*connection_rate__max_connection_rate*]
# Maximum number of new connections each connecting IP address is allowed to
# make in the "rate_timer" interval.  Set to "0" to disable this limit. If
# applied to an HTTP Virtual Server each request sent on a connection that is
# kept alive counts as a new connection.  The rate limit is per process: each
# process within a Traffic Manager accepts new connections from the connecting
# IP address at this rate. (Each Traffic Manager typically has several
# processes: one process per available CPU core).
#
# [*connection_rate__rate_timer*]
# How frequently the "max_connection_rate" is assessed. For example, a value
# of "1" (second) will impose a limit of "max_connection_rate" connections per
# second; a value of "60" will impose a limit of "max_connection_rate"
# connections per minute. The valid range is 1-99999 seconds.
#
# [*http__check_rfc2396*]
# Whether or not requests with poorly-formed URLs be should be rejected. This
# tests URL compliance as defined in RFC2396.  Note that enabling this may
# block some older, non-conforming web browsers.
#
# [*http__max_body_length*]
# Maximum permitted length of HTTP request body data, set to "0" to disable
# the limit.
#
# [*http__max_header_length*]
# Maximum permitted length of a single HTTP request header (key and value),
# set to "0" to disable the limit.
#
# [*http__max_request_length*]
# Maximum permitted size of all the HTTP request headers, set to "0" to
# disable the limit.
#
# [*http__max_url_length*]
# Maximum permitted URL length, set to "0" to disable the limit.
#
# [*http__reject_binary*]
# Whether or not URLs and HTTP request headers that contain binary data (after
# decoding) should be rejected.
#
# [*http__send_error_page*]
# This setting tells the traffic manager to send an HTTP error message if a
# connection fails the service protection tests, instead of just dropping it.
# Details of which HTTP response will be sent when particular tests fail can
# be found in the Help section for this page.
#
# === Examples
#
# brocadevtm::protection { 'example':
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
define brocadevtm::protection (
  $ensure,
  $basic__debug                                         = false,
  $basic__enabled                                       = true,
  $basic__log_time                                      = 60,
  $basic__note                                          = undef,
  $basic__rule                                          = undef,
  $basic__testing                                       = false,
  $access_restriction__allowed                          = '[]',
  $access_restriction__banned                           = '[]',
  $concurrent_connections__max_10_connections           = 200,
  $concurrent_connections__max_1_connections            = 30,
  $concurrent_connections__min_connections              = 4,
  $concurrent_connections__per_process_connection_count = true,
  $connection_rate__max_connection_rate                 = 0,
  $connection_rate__rate_timer                          = 60,
  $http__check_rfc2396                                  = false,
  $http__max_body_length                                = 0,
  $http__max_header_length                              = 0,
  $http__max_request_length                             = 0,
  $http__max_url_length                                 = 0,
  $http__reject_binary                                  = false,
  $http__send_error_page                                = true,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring protection ${name}")
  vtmrest { "protection/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/8.3/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/protection.erb'),
    type     => 'application/json',
    internal => 'protection',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/protection", {ensure => present})
    file_line { "protection/${name}":
      line => "protection/${name}",
      path => "${purge_state_dir}/protection",
    }
  }
}
