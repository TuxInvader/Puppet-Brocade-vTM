# === Class: brocadevtm::user_groups_Demo
#

class brocadevtm::user_groups_Demo (
  $ensure = present,
  $basic__description          = "Full access, except to user management / system",
  $basic__password_expire_time = 0,
  $basic__permissions          = [{"name"=>"Web_Cache", "access_level"=>"full"}, {"name"=>"Wizard!ClusterJoin", "access_level"=>"none"}, {"name"=>"Java", "access_level"=>"full"}, {"name"=>"Event_Log", "access_level"=>"full"}, {"name"=>"Monitors", "access_level"=>"full"}, {"name"=>"Configure", "access_level"=>"full"}, {"name"=>"Wizard", "access_level"=>"full"}, {"name"=>"Wizard!FreeDiskSpace", "access_level"=>"none"}, {"name"=>"Traffic_Managers!Upgrade", "access_level"=>"none"}, {"name"=>"Security", "access_level"=>"ro"}, {"name"=>"Wizard!Restore", "access_level"=>"none"}, {"name"=>"Shutdown", "access_level"=>"ro"}, {"name"=>"Web_Cache!Clear", "access_level"=>"none"}, {"name"=>"Traffic_Managers", "access_level"=>"full"}, {"name"=>"DateTime", "access_level"=>"ro"}, {"name"=>"Log_Viewer", "access_level"=>"full"}, {"name"=>"Bandwidth", "access_level"=>"full"}, {"name"=>"Request_Logs", "access_level"=>"full"}, {"name"=>"SNMP", "access_level"=>"ro"}, {"name"=>"Reboot", "access_level"=>"ro"}, {"name"=>"Connections", "access_level"=>"full"}, {"name"=>"Virtual_Servers", "access_level"=>"full"}, {"name"=>"SOAP_API", "access_level"=>"none"}, {"name"=>"Networking", "access_level"=>"ro"}, {"name"=>"Pools", "access_level"=>"full"}, {"name"=>"Support", "access_level"=>"full"}, {"name"=>"Global_Settings", "access_level"=>"full"}, {"name"=>"Catalog", "access_level"=>"full"}, {"name"=>"Java!Edit", "access_level"=>"full"}, {"name"=>"Appliance_Console", "access_level"=>"none"}, {"name"=>"SLM", "access_level"=>"full"}, {"name"=>"SSL", "access_level"=>"full"}, {"name"=>"Monitoring", "access_level"=>"full"}, {"name"=>"Service_Protection", "access_level"=>"full"}, {"name"=>"Persistence", "access_level"=>"full"}, {"name"=>"Alerting", "access_level"=>"full"}, {"name"=>"Audit_Log", "access_level"=>"full"}, {"name"=>"Backup", "access_level"=>"ro"}, {"name"=>"Extra_Files", "access_level"=>"full"}, {"name"=>"Statd", "access_level"=>"full"}, {"name"=>"Rate", "access_level"=>"full"}, {"name"=>"Help", "access_level"=>"full"}, {"name"=>"Restart", "access_level"=>"ro"}, {"name"=>"Wizard!Backup", "access_level"=>"none"}, {"name"=>"Custom", "access_level"=>"full"}, {"name"=>"Aptimizer", "access_level"=>"full"}, {"name"=>"Traffic_Managers!AddRemove", "access_level"=>"none"}, {"name"=>"Event_Log!Clear", "access_level"=>"none"}, {"name"=>"Rules", "access_level"=>"full"}, {"name"=>"Traffic_IP_Groups", "access_level"=>"full"}, {"name"=>"Draining", "access_level"=>"full"}, {"name"=>"License_Keys", "access_level"=>"ro"}, {"name"=>"Diagnose", "access_level"=>"full"}, {"name"=>"Access_Management", "access_level"=>"ro"}, {"name"=>"NAT", "access_level"=>"ro"}, {"name"=>"Config_Summary", "access_level"=>"full"}, {"name"=>"MainIndex", "access_level"=>"full"}],
  $basic__timeout              = 30,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring user_groups_Demo ${name}")
  vtmrest { "user_groups/Demo":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/user_groups_Demo.erb'),
    internal => 'user_groups_Demo',
    debug => 0,
  }
}
