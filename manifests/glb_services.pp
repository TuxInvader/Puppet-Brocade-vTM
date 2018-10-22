# === Define: brocadevtm::glb_services
#
# GLB Service
# A global load balancing service is used by a virtual server to modify DNS
# requests in order load balance data across different GLB locations.
#
# === Parameters
#
# [*basic__algorithm*]
# Defines the global load balancing algorithm to be used.
#
# [*basic__all_monitors_needed*]
# Do all monitors assigned to a location need to report success in order for
# it to be considered healthy?
#
# [*basic__autorecovery*]
# The last location to fail will be available as soon as it recovers.
#
# [*basic__chained_auto_failback*]
# Enable/Disable automatic failback mode.
#
# [*basic__chained_location_order*]
# The locations this service operates for and defines the order in which
# locations fail.
# Type:array
# Properties:
#
# [*basic__disable_on_failure*]
# Locations recovering from a failure will become disabled.
#
# [*basic__dnssec_keys*]
# A table mapping domains to the private keys that authenticate them
# Type:array
# Properties:{"domain"=>{"description"=>"A domain authenticated by the
# associated private keys.", "type"=>"string"},
# "ssl_key"=>{"description"=>"Private keys that authenticate the associated
# domain.", "type"=>"array", "uniqueItems"=>true, "items"=>{"type"=>"string"}}}
#
# [*basic__domains*]
# The domains shown here should be a list of Fully Qualified Domain Names that
# you would like to balance globally. Responses from the back end DNS servers
# for queries that do not match this list will be forwarded to the client
# unmodified. Note: "*" may be used as a wild card.
# Type:array
# Properties:
#
# [*basic__enabled*]
# Enable/Disable our response manipulation of DNS.
#
# [*basic__geo_effect*]
# How much should the locality of visitors affect the choice of location used?
# This value is a percentage, 0% means that no locality information will be
# used, and 100% means that locality will always control which location is
# used. Values between the two extremes will act accordingly.
#
# [*basic__last_resort_response*]
# The response to be sent in case there are no locations available.
# Type:array
# Properties:
#
# [*basic__location_draining*]
# This is the list of locations for which this service is draining. A location
# that is draining will never serve any of its service IP addresses for this
# domain. This can be used to take a location off-line.
# Type:array
# Properties:
#
# [*basic__location_settings*]
# Table containing location specific settings.
# Type:array
# Properties:{"location"=>{"description"=>"Location to which the associated
# settings apply.", "type"=>"string"}, "weight"=>{"description"=>"Weight for
# this location, for use by the weighted random algorithm.",
# "type"=>"integer", "minimum"=>1, "maximum"=>100, "default"=>1},
# "ips"=>{"description"=>"The IP addresses that are present in a location. If
# the Global Load Balancer decides to direct a DNS query to this location,
# then it will filter out all IPs that are not in this list.",
# "type"=>"array", "uniqueItems"=>true, "items"=>{"type"=>"string"}},
# "monitors"=>{"description"=>"The monitors that are present in a location.",
# "type"=>"array", "default"=>[], "uniqueItems"=>true,
# "items"=>{"type"=>"string"}}}
#
# [*basic__optimistic_location_health*]
# Is location health optimistic? Set true to treat a location as healthy if
# any peer reports it as healthy, set false to treat a location as failed if
# any peer reports a monitor failure.
#
# [*basic__peer_health_timeout*]
# Peer reported monitor state timeout in seconds.
#
# [*basic__return_ips_on_fail*]
# Return all or none of the IPs under complete failure.
#
# [*basic__rules*]
# Response rules to be applied in the context of the service, in order, comma
# separated.
# Type:array
# Properties:
#
# [*basic__ttl*]
# The TTL for the DNS resource records handled by the GLB service.
#
# [*log__enabled*]
# Log connections to this GLB service?
#
# [*log__filename*]
# The filename the verbose query information should be logged to. Appliances
# will ignore this.
#
# [*log__format*]
# The format of the log lines.
#
# === Examples
#
# brocadevtm::glb_services { 'example':
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
define brocadevtm::glb_services (
  $ensure,
  $basic__algorithm              = 'hybrid',
  $basic__all_monitors_needed    = true,
  $basic__autorecovery           = true,
  $basic__chained_auto_failback  = false,
  $basic__chained_location_order = '[]',
  $basic__disable_on_failure     = false,
  $basic__dnssec_keys            = '[]',
  $basic__domains                = '[]',
  $basic__enabled                = false,
  $basic__geo_effect             = 50,
  $basic__last_resort_response   = '[]',
  $basic__location_draining      = '[]',
  $basic__location_settings      = '[]',
  $basic__return_ips_on_fail     = true,
  $basic__rules                  = '[]',
  $basic__ttl                    = -1,
  $log__enabled                  = false,
  $log__filename                 = '%zeushome%/zxtm/log/services/%g.log',
  $log__format                   = '%t, %s, %l, %q, %g, %n, %d, %a',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring glb_services ${name}")
  vtmrest { "glb_services/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/glb_services.erb'),
    type     => 'application/json',
    internal => 'glb_services',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/glb_services", {ensure => present})
    file_line { "glb_services/${name}":
      line => "glb_services/${name}",
      path => "${purge_state_dir}/glb_services",
    }
  }
}
