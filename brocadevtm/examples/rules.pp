class { 'brocadevtm':
   rest_user => 'puppet',
   rest_pass => 'master',
   rest_ip   => '10.1.1.22',
}

brocadevtm::rules { 'testRuleCorrect':
   ensure => present,
   file => 'brocadevtm/testrule.zts',
}

