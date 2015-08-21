class { 'brocadevtm':
   rest_user => 'admin', 
   rest_pass => 'DOXQg05SPzi',
   rest_ip   => '172.17.42.4',
}

include brocadevtm::monitors_Full_HTTP

