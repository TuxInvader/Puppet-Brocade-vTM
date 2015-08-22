class { 'brocadevtm':
  rest_user  => 'puppet', 
  rest_pass  => 'master',
  rest_ip    => '10.1.1.22',
}

brocadevtm::pools { 'puppetPool':
  ensure             => present,
  basic__nodes_table => '[{"node":"10.1.1.1:80","priority":1,"state":"active","weight":1}]',
}

