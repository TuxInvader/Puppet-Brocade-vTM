# === Class: brocadevtm::user_groups_guest
#
# This class is a direct implementation of brocadvtm::user_groups
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::user_groups_guest (
  $ensure                      = present,
  $basic__description          = 'Read-only access',
  $basic__password_expire_time = 0,
  $basic__permissions          = '[{"name":"Web_Cache","access_level":"full"},{"name":"Event_Log","access_level":"full"},{"name":"Monitors","access_level":"ro"},{"name":"Configure","access_level":"ro"},{"name":"Wizard","access_level":"ro"},{"name":"Traffic_Managers!Upgrade","access_level":"none"},{"name":"Security","access_level":"ro"},{"name":"Shutdown","access_level":"ro"},{"name":"Web_Cache!Clear","access_level":"none"},{"name":"Traffic_Managers","access_level":"ro"},{"name":"DateTime","access_level":"ro"},{"name":"Log_Viewer","access_level":"full"},{"name":"Bandwidth","access_level":"ro"},{"name":"Request_Logs","access_level":"ro"},{"name":"SNMP","access_level":"ro"},{"name":"Reboot","access_level":"ro"},{"name":"Connections","access_level":"full"},{"name":"Virtual_Servers","access_level":"ro"},{"name":"SOAP_API","access_level":"none"},{"name":"Networking","access_level":"ro"},{"name":"Pools","access_level":"ro"},{"name":"Support","access_level":"ro"},{"name":"Monitoring!Edit","access_level":"ro"},{"name":"Global_Settings","access_level":"ro"},{"name":"Catalog","access_level":"ro"},{"name":"Appliance_Console","access_level":"none"},{"name":"SLM","access_level":"ro"},{"name":"SSL","access_level":"ro"},{"name":"Monitoring","access_level":"full"},{"name":"Service_Protection","access_level":"ro"},{"name":"Persistence","access_level":"ro"},{"name":"Alerting","access_level":"ro"},{"name":"Audit_Log","access_level":"none"},{"name":"Backup","access_level":"ro"},{"name":"Extra_Files","access_level":"ro"},{"name":"Statd","access_level":"full"},{"name":"Rate","access_level":"ro"},{"name":"Help","access_level":"ro"},{"name":"Restart","access_level":"ro"},{"name":"Custom","access_level":"ro"},{"name":"Aptimizer","access_level":"ro"},{"name":"Traffic_Managers!AddRemove","access_level":"none"},{"name":"Event_Log!Clear","access_level":"none"},{"name":"Rules","access_level":"ro"},{"name":"Traffic_IP_Groups","access_level":"ro"},{"name":"Draining","access_level":"ro"},{"name":"License_Keys","access_level":"ro"},{"name":"Diagnose","access_level":"ro"},{"name":"Access_Management","access_level":"ro"},{"name":"NAT","access_level":"ro"},{"name":"Config_Summary","access_level":"ro"},{"name":"MainIndex","access_level":"ro"}]',
  $basic__timeout              = 30,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring user_groups_guest ${name}")
  vtmrest { 'user_groups/Guest':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.4/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/user_groups.erb'),
    type     => 'application/json',
    internal => 'user_groups_guest',
    failfast => $brocadevtm::failfast,
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/user_groups", {ensure => present})
    file_line { 'user_groups/Guest':
      line => 'user_groups/Guest',
      path => "${purge_state_dir}/user_groups",
    }
  }
}
