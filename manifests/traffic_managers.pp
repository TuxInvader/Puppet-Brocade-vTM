# === Define: brocadevtm::traffic_managers
#
# Traffic Manager
# The "conf/zxtms" directory contains a configuration file for each traffic
# manager in your cluster.  The name of each file is the hostname of the
# traffic manager it represents.  These files contain host-specific
# configuration data and on each installation of the software, the
# "conf/../global.cfg" file is sym-linked to the host's own configuration in
# the "conf/zxtms" directory.  The files may contain a variety of
# configuration options that are configured in various locations under the
# "System" section of the Admin Server UI and the "System" section of the SOAP
# API and CLI.
#
# === Parameters
#
# [*basic__adminMasterXMLIP*]
# The Application Firewall master XML IP.
#
# [*basic__adminSlaveXMLIP*]
# The Application Firewall slave XML IP.
#
# [*basic__appliance_card*]
# The table of network cards of a hardware appliance
# Type:array
# Properties:{"name"=>{"description"=>"Network card PCI ID",
# "type"=>"string"}, "interfaces"=>{"description"=>"The order of the
# interfaces of a network card", "type"=>"array", "uniqueItems"=>false,
# "items"=>{"type"=>"string"}}, "label"=>{"description"=>"The labels of the
# installed network cards", "type"=>"string", "default"=>"-",
# "pattern"=>"^[\\w\\.:@\\-]{1,64}$"}}
#
# [*basic__appliance_sysctl*]
# Custom kernel parameters applied by the user with sysctl interface
# Type:array
# Properties:{"sysctl"=>{"description"=>"The name of the kernel parameter,
# e.g. net.ipv4.forward", "type"=>"string"},
# "description"=>{"description"=>"Associated optional description for the
# sysctl", "type"=>"string", "default"=>""}, "value"=>{"description"=>"The
# value of the kernel parameter", "type"=>"string"}}
#
# [*basic__authenticationServerIP*]
# The Application Firewall Authentication Server IP.
#
# [*basic__cloud_platform*]
# Cloud platform where the traffic manager is running.
#
# [*basic__developer_mode_accepted*]
# Whether user has accepted the Developer mode and will not be prompted for
# uploading license key
#
# [*basic__disk_serious*]
# The percentage level of disk usage that triggers a SERIOUS event log entry
#
# [*basic__disk_warn*]
# The percentage level of disk usage that triggers a WARN event log entry
#
# [*basic__kmod_policy*]
# The policy for loading and unloading kernel modules
#
# [*basic__location*]
# This is the location of the local traffic manager is in.
#
# [*basic__nameip*]
# Replace Traffic Manager name with an IP address.
#
# [*basic__num_aptimizer_threads*]
# How many worker threads the Web Accelerator process should create to
# optimise content. By default, one thread will be created for each CPU on the
# system.
#
# [*basic__num_children*]
# The number of worker processes the software will run.  By default, one child
# process will be created for each CPU on the system.  You may wish to reduce
# this to effectively "reserve" CPU(s) for other processes running on the host
# system.
#
# [*basic__numberOfCPUs*]
# The number of Application Firewall decider process to run.
#
# [*basic__restServerPort*]
# The Application Firewall REST Internal API port, this port should not be
# accessed directly
#
# [*basic__start_sysd*]
# Whether or not to start the sysd process on software installations.
# Appliance and EC2 will always run sysd regardless of this config key.
#
# [*basic__trafficip*]
# A table mapping interfaces to networks, used by the traffic manager to
# select which interface to raise a Traffic IP on.
# Type:array
# Properties:{"name"=>{"description"=>"A network interface.",
# "type"=>"string"}, "networks"=>{"description"=>"A set of IP/masks to which
# the network interface maps.", "type"=>"array", "uniqueItems"=>true,
# "items"=>{"type"=>"string"}}}
#
# [*basic__updaterIP*]
# The Application Firewall Updater IP.
#
# [*basic__use_mx*]
# Which polling method to use.  The default for your platform is almost always
# the optimal choice.
#
# [*appliance__disable_cloud_init*]
# Whether to disable the cloud-init service
#
# [*appliance__disable_kpti*]
# Whether the traffic manager appliance should run without kernel page table
# isolation (KPTI). KPTI provides protection to prevent unprivileged software
# from being potentially able to read arbitrary memory from the kernel (i.e.
# the Meltdown attack, CVE-2017-5754); however this protection incurs a
# general system performance penalty. If you are running trusted software on
# the appliance, and the trade-off between performance at the cost of 'defense
# in depth' favors the former in your deployment, you may wish to enable this
# configuration key. If you are unsure, it is recommended that you leave this
# key disabled, which is also the default.
#
# [*appliance__dnscache*]
# The DNS cache setting the appliance should use and place in
# "/etc/systemd/resolved.conf".
#
# [*appliance__dnssec*]
# The DNSSEC setting the appliance should use and place in
# "/etc/systemd/resolved.conf".
#
# [*appliance__gateway_ipv4*]
# The default gateway.
#
# [*appliance__gateway_ipv6*]
# The default IPv6 gateway.
#
# [*appliance__hostname*]
# Name (hostname.domainname) of the appliance.
#
# [*appliance__hosts*]
# A table of hostname to static ip address mappings, to be placed in the
# /etc/hosts file.
# Type:array
# Properties:{"name"=>{"description"=>"The name of a host.",
# "type"=>"string"}, "ip_address"=>{"description"=>"The static IP address of
# the host.", "type"=>"string"}}
#
# [*appliance__if*]
# A table of network interface specific settings.
# Type:array
# Properties:{"name"=>{"description"=>"A network interface name.",
# "type"=>"string"}, "autoneg"=>{"description"=>"Whether auto-negotiation
# should be enabled for the interface.", "type"=>"boolean", "default"=>true},
# "bmode"=>{"description"=>"The trunking mode used for the interface (only
# 802.3ad is currently supported).", "type"=>"string", "default"=>"802_3ad",
# "enum"=>["802_3ad", "balance_alb"]}, "bond"=>{"description"=>"The trunk of
# which the interface should be a member.", "type"=>"string", "default"=>"",
# "pattern"=>"^(bond\\d+)?$"}, "duplex"=>{"description"=>"Whether full-duplex
# should be enabled for the interface.", "type"=>"boolean", "default"=>true},
# "mode"=>{"description"=>"Set the configuriation mode of an interface, the
# interface name is used in place of the \"*\" (asterisk).", "type"=>"string",
# "default"=>"static", "enum"=>["dhcp", "static"]},
# "mtu"=>{"description"=>"The maximum transmission unit (MTU) of the
# interface.", "type"=>"integer", "minimum"=>68, "maximum"=>9216,
# "default"=>1500}, "speed"=>{"description"=>"The speed of the interface.",
# "type"=>"string", "default"=>"1000", "enum"=>["10", "100", "1000", "10000",
# "100000", "40000"]}}
#
# [*appliance__ip*]
# A table of network interfaces and their network settings.
# Type:array
# Properties:{"name"=>{"description"=>"A network interface name.",
# "type"=>"string"}, "addr"=>{"description"=>"The IP address for the
# interface.", "type"=>"string"}, "isexternal"=>{"description"=>"Whether the
# interface is externally facing.", "type"=>"boolean", "default"=>false},
# "mask"=>{"description"=>"The IP mask (netmask) for the interface.",
# "type"=>"string"}}
#
# [*appliance__ipmi_lan_access*]
# Whether IPMI LAN access should be enabled or not.
#
# [*appliance__ipmi_lan_addr*]
# The IP address of the appliance IPMI LAN channel.
#
# [*appliance__ipmi_lan_gateway*]
# The default gateway of the IPMI LAN channel.
#
# [*appliance__ipmi_lan_ipsrc*]
# The addressing mode the IPMI LAN channel operates.
#
# [*appliance__ipmi_lan_mask*]
# Set the IP netmask for the IPMI LAN channel.
#
# [*appliance__ipv4_forwarding*]
# Whether or not IPv4 forwarding is enabled.
#
# [*appliance__ipv6_forwarding*]
# Whether or not IPv6 forwarding is enabled.
#
# [*appliance__licence_agreed*]
# Whether or not the license agreement has been accepted.  This determines
# whether or not the Initial Configuration wizard is displayed.
#
# [*appliance__manageazureroutes*]
# Whether or not the software manages the Azure policy routing.
#
# [*appliance__manageec2conf*]
# Whether or not the software manages the EC2 config.
#
# [*appliance__manageiptrans*]
# Whether or not the software manages the IP transparency
#
# [*appliance__managereservedports*]
# Whether or not the software manages the system configuration for reserved
# ports
#
# [*appliance__managereturnpath*]
# Whether or not the software manages return path routing. If disabled, the
# appliance won't modify iptables / rules / routes for this feature.
#
# [*appliance__manageservices*]
# Whether or not the software manages the system services
#
# [*appliance__managesysctl*]
# Whether or not the software manages user specified sysctl keys.
#
# [*appliance__managevpcconf*]
# Whether or not the software manages the EC2-VPC secondary IPs.
#
# [*appliance__name_servers*]
# The IP addresses of the nameservers the appliance should use and place in
# "/etc/systemd/resolved.conf".
# Type:array
# Properties:
#
# [*appliance__ntpservers*]
# The NTP servers the appliance should use to synchronize its clock.
# Type:array
# Properties:
#
# [*appliance__routes*]
# A table of destination IP addresses and routing details to reach them.
# Type:array
# Properties:{"name"=>{"description"=>"A destination IP address.",
# "type"=>"string"}, "gw"=>{"description"=>"The gateway IP to configure for
# the route.", "type"=>"string"}, "if"=>{"description"=>"The network interface
# to configure for the route.", "type"=>"string"},
# "mask"=>{"description"=>"The netmask to apply to the IP address.",
# "type"=>"string"}}
#
# [*appliance__search_domains*]
# The search domains the appliance should use and place in
# "/etc/systemd/resolved.conf".
# Type:array
# Properties:
#
# [*appliance__ssh_enabled*]
# Whether or not the SSH server is enabled on the appliance.
#
# [*appliance__ssh_password_allowed*]
# Whether or not the SSH server allows password based login.
#
# [*appliance__ssh_port*]
# The port that the SSH server should listen on.
#
# [*appliance__timezone*]
# The timezone the appliance should use.  This must be a path to a timezone
# file that exists under "/usr/share/zoneinfo/".
#
# [*appliance__vlans*]
# The VLANs the software should raise.  A VLAN should be configured using the
# format "<dev>.<vlanid>", where "<dev>" is the name of a network device that
# exists in the host system, "eth0.100" for example.
# Type:array
# Properties:
#
# [*autodiscover__product_id*]
# This key overrides the product ID used by traffic manager instances to
# discover each other when clustering. Traffic managers will only discover
# each other if their product IDs are the same and their versions are
# compatible.
#
# [*cluster_comms__allow_update*]
# Whether or not this instance of the software can send configuration updates
# to other members of the cluster.  When not clustered this key is ignored.
# When clustered the value can only be changed by another machine in the
# cluster that has "allow_update" set to "true".  If set to "false" then it
# will not be possible to log into the admin server for this instance.
#
# [*cluster_comms__bind_ip*]
# The IP address that the software should bind to for internal administration
# communications.  See also "port".  If the software is not part of a cluster
# the default is to use "127.0.0.1" and there should be no reason to touch
# this setting.  If the software is part of a cluster then the default is to
# listen on all raised IPs, in this case an alternative configuration is to
# listen on a single IP address.  This may be useful if you have a separate
# management network and wish to restrict control messages to it.  It is
# important to ensure that the "allowed_update_hosts" (in the "Global
# Settings" resource) is compatible with the IP configured here.
#
# [*cluster_comms__external_ip*]
# This is the optional external ip of the traffic manager, which is used to
# circumvent natting when traffic managers in a cluster span different
# networks.
#
# [*cluster_comms__port*]
# The port that the software should listen on for internal administration
# communications.  See also "bind_ip".
#
# [*ec2__availability_zone*]
# The availability zone of this EC2 instance, should be set when the appliance
# is first booted. Not required for non-EC2 systems.
#
# [*ec2__instanceid*]
# The EC2 instance ID of this EC2 virtual appliance, should be set when the
# appliance is first booted. Not required for non-EC2 systems.
#
# [*ec2__trafficips_public_enis*]
# List of MAC addresses of interfaces which the traffic manager can use to
# associate the EC2 elastic IPs (Traffic IPs) to the instance.
# Type:array
# Properties:
#
# [*ec2__vpcid*]
# The ID of the VPC the instance is in, should be set when the appliance is
# first booted. Not required for non-VPC EC2 or non-EC2 systems.
#
# [*fault_tolerance__bgp_router_id*]
# The BGP router id
# If set to empty, then the IPv4 address used to communicate with the default
# IPv4 gateway is used instead.
# Specifying 0.0.0.0 will stop the traffic manager routing software from
# running the BGP protocol.
#
# [*fault_tolerance__ospfv2_ip*]
# The traffic manager's permanent IPv4 address which the routing software will
# use for peering and transit traffic, and as its OSPF router ID.
# If set to empty, then the address used to communicate with the default IPv4
# gateway is used instead.
# Specifying 0.0.0.0 will stop the traffic manager routing software from
# running the OSPF protocol.
#
# [*fault_tolerance__ospfv2_neighbor_addrs*]
# The IP addresses of routers which are expected to be found as OSPFv2
# neighbors of the traffic manager. A warning will be reported if some of the
# expected routers are not peered, and an error will be reported if none of
# the expected routers are peered. An empty list disables monitoring. The
# special value %gateway% is a placeholder for the default gateway.
# Type:array
# Properties:
#
# [*fault_tolerance__rhi_support*]
# This key does nothing.
#
# [*fault_tolerance__routing_sw_log_level*]
# The routing software log level. Values are: 0 - emergency 1 - alert 2 -
# critical 3 - error 4 - warning 5 - notification 6 - informational 7 - debug
# Messages with priority less or equal to the set level will be logged.
#
# [*iptables__config_enabled*]
# Whether the Traffic Manager should configure the iptables built-in chains to
# call Traffic Manager defined rules (e.g. the IP transparency chain). This
# should only be disabled in case of conflict with other software that manages
# iptables, e.g. firewalls. When disabled, you will need to add rules manually
# to use these features - see the user manual for details.
#
# [*iptrans__chain*]
# The iptables named chain to use for IP transparency rules.
#
# [*iptrans__fwmark*]
# The netfilter forwarding mark to use for IP transparency rules
#
# [*iptrans__iptables_enabled*]
# Whether IP transparency may be used via netfilter/iptables. This requires
# Linux 2.6.24 and the iptables socket extension. For older Linux versions,
# the "ztrans" kernel module may be used instead.
#
# [*iptrans__routing_table*]
# The special routing table ID to use for IP transparency rules
#
# [*java__port*]
# The port the Java Extension handler process should listen on.  This port
# will be bound for localhost communications only.
#
# [*kerberos__hostname*]
# The hostname to use in Kerberos principal names.
#
# [*kerberos__num_kpt_threads*]
# How many worker threads the Kerberos Protocol Transition helper process will
# use.
#
# [*remote_licensing__email_address*]
# The e-mail address sent as part of a remote licensing request.
#
# [*remote_licensing__message*]
# A free-text field sent as part of a remote licensing request.
#
# [*rest_api__bind_ips*]
# A list of IP Addresses which the REST API will listen on for connections.
# The list should contain IP addresses (IPv4 or IPv6) or a single entry
# containing an asterisk (*). This indicates that the REST API should listen
# on all IP Addresses.
# Type:array
# Properties:
#
# [*rest_api__port*]
# The port on which the REST API should listen for requests.
#
# [*snmp__allow*]
# Restrict which IP addresses can access the SNMP command responder service.
# The value can be "all", "localhost", or a list of IP CIDR subnet masks.  For
# example "10.100.0.0/16" would allow connections from any IP address
# beginning with "10.100".
# Type:array
# Properties:
#
# [*snmp__auth_password*]
# The authentication password. Required (minimum length 8 characters) if
# "security_level" includes authentication.
#
# [*snmp__bind_ip*]
# The IP address the SNMP service should bind its listen port to.  The value
# "*" (asterisk) means SNMP will listen on all IP addresses.
#
# [*snmp__community*]
# The community string required for SNMPv1 and SNMPv2c commands.  (If empty,
# all SNMPv1 and SNMPv2c commands will be rejected).
#
# [*snmp__enabled*]
# Whether or not the SNMP command responder service should be enabled on this
# traffic manager.
#
# [*snmp__hash_algorithm*]
# The hash algorithm for authenticated SNMPv3 communications.
#
# [*snmp__port*]
# The port the SNMP command responder service should listen on. The value
# "default" denotes port 161 if the software is running with root privileges,
# and 1161 otherwise.
#
# [*snmp__priv_password*]
# The privacy password. Required (minimum length 8 characters) if
# "security_level" includes privacy (message encryption).
#
# [*snmp__security_level*]
# The security level for SNMPv3 communications.
#
# [*snmp__username*]
# The username required for SNMPv3 commands.  (If empty, all SNMPv3 commands
# will be rejected).
#
# === Examples
#
# brocadevtm::traffic_managers { 'example':
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
define brocadevtm::traffic_managers (
  $ensure,
  $basic__adminMasterXMLIP                = '0.0.0.0',
  $basic__adminSlaveXMLIP                 = '0.0.0.0',
  $basic__appliance_card                  = '[]',
  $basic__appliance_sysctl                = '[]',
  $basic__authenticationServerIP          = '0.0.0.0',
  $basic__cloud_platform                  = undef,
  $basic__location                        = undef,
  $basic__nameip                          = undef,
  $basic__num_aptimizer_threads           = 0,
  $basic__num_children                    = 0,
  $basic__numberOfCPUs                    = 0,
  $basic__restServerPort                  = 0,
  $basic__trafficip                       = '[]',
  $basic__updaterIP                       = '0.0.0.0',
  $appliance__disable_kpti                = false,
  $appliance__dnscache                    = true,
  $appliance__dnssec                      = 'no',
  $appliance__gateway_ipv4                = undef,
  $appliance__gateway_ipv6                = undef,
  $appliance__hostname                    = undef,
  $appliance__hosts                       = '[]',
  $appliance__if                          = '[]',
  $appliance__ip                          = '[]',
  $appliance__ipmi_lan_access             = false,
  $appliance__ipmi_lan_addr               = undef,
  $appliance__ipmi_lan_gateway            = undef,
  $appliance__ipmi_lan_ipsrc              = 'static',
  $appliance__ipmi_lan_mask               = undef,
  $appliance__ipv4_forwarding             = false,
  $appliance__ipv6_forwarding             = false,
  $appliance__licence_agreed              = false,
  $appliance__manageazureroutes           = true,
  $appliance__manageec2conf               = true,
  $appliance__manageiptrans               = true,
  $appliance__managereservedports         = true,
  $appliance__managereturnpath            = true,
  $appliance__manageservices              = true,
  $appliance__managevpcconf               = true,
  $appliance__name_servers                = '[]',
  $appliance__ntpservers                  = '["0.zeus.pool.ntp.org","1.zeus.pool.ntp.org","2.zeus.pool.ntp.org","3.zeus.pool.ntp.org"]',
  $appliance__routes                      = '[]',
  $appliance__search_domains              = '[]',
  $appliance__ssh_enabled                 = true,
  $appliance__ssh_password_allowed        = true,
  $appliance__ssh_port                    = 22,
  $appliance__timezone                    = 'US/Pacific',
  $appliance__vlans                       = '[]',
  $cluster_comms__allow_update            = true,
  $cluster_comms__bind_ip                 = '*',
  $cluster_comms__external_ip             = undef,
  $cluster_comms__port                    = 9080,
  $ec2__trafficips_public_enis            = '[]',
  $fault_tolerance__bgp_router_id         = undef,
  $fault_tolerance__ospfv2_ip             = undef,
  $fault_tolerance__ospfv2_neighbor_addrs = '["%gateway%"]',
  $iptables__config_enabled               = true,
  $iptrans__fwmark                        = 320,
  $iptrans__iptables_enabled              = true,
  $iptrans__routing_table                 = 320,
  $java__port                             = 9060,
  $remote_licensing__email_address        = undef,
  $remote_licensing__message              = undef,
  $rest_api__bind_ips                     = '["*"]',
  $rest_api__port                         = 9070,
  $snmp__allow                            = '["all"]',
  $snmp__auth_password                    = undef,
  $snmp__bind_ip                          = '*',
  $snmp__community                        = 'public',
  $snmp__enabled                          = false,
  $snmp__hash_algorithm                   = 'md5',
  $snmp__port                             = 'default',
  $snmp__priv_password                    = undef,
  $snmp__security_level                   = 'noauthnopriv',
  $snmp__username                         = undef,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring traffic_managers ${name}")
  vtmrest { "traffic_managers/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/traffic_managers.erb'),
    type     => 'application/json',
    internal => 'traffic_managers',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/traffic_managers", {ensure => present})
    file_line { "traffic_managers/${name}":
      line => "traffic_managers/${name}",
      path => "${purge_state_dir}/traffic_managers",
    }
  }
}
