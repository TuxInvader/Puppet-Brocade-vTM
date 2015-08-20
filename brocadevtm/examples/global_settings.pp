class { 'brocadevtm':
	rest_user => 'puppet', 
	rest_pass => 'master',
}

include brocadevtm::global_settings

