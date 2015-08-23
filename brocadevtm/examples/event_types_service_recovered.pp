class { 'brocadevtm':
  rest_user => 'puppet', 
  rest_pass => 'master',
  rest_ip   => '10.1.1.22',
}

include brocadevtm::event_types_service_recovered

