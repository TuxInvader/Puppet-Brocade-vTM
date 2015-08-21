class { 'brocadevtm':
   rest_user => 'puppet',
   rest_pass => 'master',
   rest_ip   => '10.1.1.22',
}

include brocadevtm::rules_application_firewall_enforcer

