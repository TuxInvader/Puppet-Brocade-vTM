# === Define: brocadevtm::actions
#
# Alerting Action
# A response to an event occurring in your traffic manager. An example of an
# action might be sending an email or writing a line to a log file.
#
# === Parameters
#
# [*basic__note*]
# A description of the action.
#
# [*basic__syslog_msg_len_limit*]
# Maximum length in bytes of a message sent to the remote syslog. Messages
# longer than this will be truncated before they are sent.
#
# [*basic__timeout*]
# How long the action can run for before it is stopped automatically (set to 0
# to disable timeouts).
#
# [*basic__type*]
# The action type.
#
# [*basic__verbose*]
# Enable or disable verbose logging for this action.
#
# [*email__from*]
# The e-mail address from which messages will appear to originate.
#
# [*email__server*]
# The SMTP server to which messages should be sent. This must be a valid IPv4
# address or resolvable hostname (with optional port).
#
# [*email__to*]
# A set of e-mail addresses to which messages will be sent.
# Type:array
# Properties:
#
# [*log__file*]
# The full path of the file to log to. The text "%zeushome%" will be replaced
# with the location where the software is installed.
#
# [*program__arguments*]
# A table containing arguments and argument values to be passed to the event
# handling program.
# Type:array
# Properties:{"name"=>{"description"=>"The name of the argument to be passed
# to the event handling program.", "type"=>"string"},
# "value"=>{"description"=>"The value of the argument to be passed to the
# event handling program.", "type"=>"string"},
# "description"=>{"description"=>"A description for the argument provided to
# the program.", "type"=>"string", "default"=>""}}
#
# [*program__program*]
# The program to run.
#
# [*soap__additional_data*]
# Additional information to send with the SOAP call.
#
# [*soap__password*]
# The password for HTTP basic authentication.
#
# [*soap__proxy*]
# The address of the server implementing the SOAP interface (For example,
# https://example.com).
#
# [*soap__username*]
# Username for HTTP basic authentication. Leave blank if you do not wish to
# use authentication.
#
# [*syslog__sysloghost*]
# The host and optional port to send syslog messages to (if empty, messages
# will be sent to localhost).
#
# [*trap__auth_password*]
# The authentication password for sending a Notify over SNMPv3. Blank to send
# unauthenticated traps.
#
# [*trap__community*]
# The community string to use when sending a Trap over SNMPv1 or a Notify over
# SNMPv2c.
#
# [*trap__hash_algorithm*]
# The hash algorithm for SNMPv3 authentication.
#
# [*trap__priv_password*]
# The encryption password to encrypt a Notify message for SNMPv3. Requires
# that authentication also be configured. Blank to send unencrypted traps.
#
# [*trap__traphost*]
# The hostname or IPv4 address and optional port number that should receive
# traps.
#
# [*trap__username*]
# The SNMP username to use to send the Notify over SNMPv3.
#
# [*trap__version*]
# The SNMP version to use to send the Trap/Notify.
#
# === Examples
#
# brocadevtm::actions { 'example':
#     ensure => present,
#     basic__type => 'foo'
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
define brocadevtm::actions (
  $ensure,
  $basic__type,
  $basic__note                 = undef,
  $basic__syslog_msg_len_limit = 1024,
  $basic__timeout              = 60,
  $basic__verbose              = false,
  $email__from                 = 'vTM@%hostname%',
  $email__server               = undef,
  $email__to                   = '[]',
  $log__file                   = undef,
  $program__arguments          = '[]',
  $program__program            = undef,
  $soap__additional_data       = undef,
  $soap__password              = undef,
  $soap__proxy                 = undef,
  $soap__username              = undef,
  $syslog__sysloghost          = undef,
  $trap__auth_password         = undef,
  $trap__community             = undef,
  $trap__hash_algorithm        = 'md5',
  $trap__priv_password         = undef,
  $trap__traphost              = undef,
  $trap__username              = undef,
  $trap__version               = 'snmpv1',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring actions ${name}")
  vtmrest { "actions/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/actions.erb'),
    type     => 'application/json',
    internal => 'actions',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/actions", {ensure => present})
    file_line { "actions/${name}":
      line => "actions/${name}",
      path => "${purge_state_dir}/actions",
    }
  }
}
