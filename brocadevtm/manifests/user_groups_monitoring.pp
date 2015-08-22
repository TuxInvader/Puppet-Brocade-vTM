# === Class: brocadevtm::user_groups_monitoring
#
# This class is a direct implementation of brocadvtm::user_groups
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::user_groups_monitoring (
  $ensure = present,
  $basic__description          = "Access only to config summary / monitoring pages",
  $basic__password_expire_time = 0,
  $basic__permissions          = [{"name"=>"Web_Cache", "access_level"=>"full"}, {"name"=>"Java", "access_level"=>"none"}, {"name"=>"Event_Log", "access_level"=>"full"}, {"name"=>"Monitors", "access_level"=>"none"}, {"name"=>"Configure", "access_level"=>"none"}, {"name"=>"Wizard", "access_level"=>"none"}, {"name"=>"Security", "access_level"=>"none"}, {"name"=>"Shutdown", "access_level"=>"none"}, {"name"=>"Web_Cache!Clear", "access_level"=>"none"}, {"name"=>"Traffic_Managers", "access_level"=>"none"}, {"name"=>"DateTime", "access_level"=>"none"}, {"name"=>"Log_Viewer", "access_level"=>"full"}, {"name"=>"Bandwidth", "access_level"=>"none"}, {"name"=>"Request_Logs", "access_level"=>"none"}, {"name"=>"SNMP", "access_level"=>"none"}, {"name"=>"Access_Management!LocalUsers!Edit", "access_level"=>"full"}, {"name"=>"Reboot", "access_level"=>"none"}, {"name"=>"Connections", "access_level"=>"full"}, {"name"=>"Virtual_Servers", "access_level"=>"none"}, {"name"=>"SOAP_API", "access_level"=>"none"}, {"name"=>"Networking", "access_level"=>"none"}, {"name"=>"Pools", "access_level"=>"none"}, {"name"=>"Support", "access_level"=>"none"}, {"name"=>"Access_Management!LocalUsers!EditOtherUsers", "access_level"=>"none"}, {"name"=>"Global_Settings", "access_level"=>"none"}, {"name"=>"Catalog", "access_level"=>"none"}, {"name"=>"Java!Edit", "access_level"=>"none"}, {"name"=>"Appliance_Console", "access_level"=>"none"}, {"name"=>"SLM", "access_level"=>"none"}, {"name"=>"SSL", "access_level"=>"none"}, {"name"=>"Monitoring", "access_level"=>"full"}, {"name"=>"Service_Protection", "access_level"=>"none"}, {"name"=>"Persistence", "access_level"=>"none"}, {"name"=>"Alerting", "access_level"=>"none"}, {"name"=>"Audit_Log", "access_level"=>"none"}, {"name"=>"Backup", "access_level"=>"none"}, {"name"=>"Extra_Files", "access_level"=>"none"}, {"name"=>"Statd", "access_level"=>"full"}, {"name"=>"Rate", "access_level"=>"none"}, {"name"=>"Help", "access_level"=>"full"}, {"name"=>"Restart", "access_level"=>"none"}, {"name"=>"Custom", "access_level"=>"none"}, {"name"=>"Aptimizer", "access_level"=>"none"}, {"name"=>"Event_Log!Clear", "access_level"=>"none"}, {"name"=>"Rules", "access_level"=>"none"}, {"name"=>"Traffic_IP_Groups", "access_level"=>"none"}, {"name"=>"Draining", "access_level"=>"full"}, {"name"=>"License_Keys", "access_level"=>"none"}, {"name"=>"Diagnose", "access_level"=>"ro"}, {"name"=>"Access_Management", "access_level"=>"none"}, {"name"=>"NAT", "access_level"=>"none"}, {"name"=>"Config_Summary", "access_level"=>"full"}, {"name"=>"MainIndex", "access_level"=>"ro"}],
  $basic__timeout              = 30,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring user_groups_monitoring ${name}")
  vtmrest { "user_groups/Monitoring":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/user_groups.erb'),
    type => 'application/json',
    internal => 'user_groups_monitoring',
    debug => 0,
  }
}
