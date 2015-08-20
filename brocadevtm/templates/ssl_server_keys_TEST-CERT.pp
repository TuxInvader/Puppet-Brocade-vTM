# === Define: brocadevtm::ssl_server_keys_TEST-CERT
#

define brocadevtm::ssl_server_keys_TEST-CERT (
  $ensure,
  $basic__note    = "",
  $basic__private = "xAohBi+UWUNF7R2wEUY/3Ya4GYFblk+k8GDx+6MHcfc=",
  $basic__public  = "-----BEGIN CERTIFICATE-----
MIIDFjCCAf4CCQD4M1+rCABUDjANBgkqhkiG9w0BAQsFADBNMQswCQYDVQQGEwJH
QjESMBAGA1UEBxMJQ2FtYnJpZGdlMRAwDgYDVQQKEwdCcm9jYWRlMRgwFgYDVQQD
Ew93d3cuYnJvY2FkZS5jb20wHhcNMTUwODIwMTQ1MzQ3WhcNMTYwODE5MTQ1MzQ3
WjBNMQswCQYDVQQGEwJHQjESMBAGA1UEBxMJQ2FtYnJpZGdlMRAwDgYDVQQKEwdC
cm9jYWRlMRgwFgYDVQQDEw93d3cuYnJvY2FkZS5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCyJkPncoKtw3evjIBbobCQhNgRDLODVtsM/x+JG9pY
nE6BG0T/wTgpEN16o4K5XVg24tpOx8KQXfhPim8jTTBnmVJ1cGdWsSJ7j2KnvPRA
1D9bia8POQND85yHWVF69+UCElR+CJWLMLENvEl9HqhKKndEB4ZqsEiGntOV8spC
Pth2cjIVE5wcgyQtntqru1TNW9waifPlheuYMMoWga9tomc0LRICIzRokiiY6V7F
CYvhyAiFBDViWsX2Ge6VJtk3bTM3Px9J4nVSbJSCtiouDMtdRvnimorVoaDitA0i
rCgBvKqJurNzas7+joxeARv3PMXADIcjfyem0Ts52IL7AgMBAAEwDQYJKoZIhvcN
AQELBQADggEBAJcuRIh3ngpFz0nHym5z56tbzHBrjF3frwp75Nknz3kuyCjdG7Nr
PF5WvDl7lb1WX9EgAn/vJznYCmMxbjnUhHTMIMWbyIoTKJIIHCsrDyiK21NoI3nY
u/9V1TADGdkqGSag00UqygF4nVkbvKJcjXHq9t0zz56xAvCamBvlNCkJ0/mQN3Qd
5r/HgiRX69MSG1RRAFB+rkZInGekedLumBYCuALFCY5SB1+ns9XtGGJGRMh74oUp
gjE62k/mEGPhLaXGJRupY07ezQKJOMBLRN1+HzIETsdH68FDdowFLzcH8fOn9HIg
Cuhlcpfk5VfCaeIqdqYEsrxY+KADA8ss06M=
-----END CERTIFICATE-----
",
  $basic__request = "-----BEGIN NEW CERTIFICATE REQUEST-----
MIICkjCCAXoCAQAwTTELMAkGA1UEBhMCR0IxEjAQBgNVBAcTCUNhbWJyaWRnZTEQ
MA4GA1UEChMHQnJvY2FkZTEYMBYGA1UEAxMPd3d3LmJyb2NhZGUuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsiZD53KCrcN3r4yAW6GwkITYEQyz
g1bbDP8fiRvaWJxOgRtE/8E4KRDdeqOCuV1YNuLaTsfCkF34T4pvI00wZ5lSdXBn
VrEie49ip7z0QNQ/W4mvDzkDQ/Och1lRevflAhJUfgiVizCxDbxJfR6oSip3RAeG
arBIhp7TlfLKQj7YdnIyFROcHIMkLZ7aq7tUzVvcGonz5YXrmDDKFoGvbaJnNC0S
AiM0aJIomOlexQmL4cgIhQQ1YlrF9hnulSbZN20zNz8fSeJ1UmyUgrYqLgzLXUb5
4pqK1aGg4rQNIqwoAbyqibqzc2rO/o6MXgEb9zzFwAyHI38nptE7OdiC+wIDAQAB
oAAwDQYJKoZIhvcNAQELBQADggEBAGnf+2VPIY8zW6IE2htseeLHxH5SlNc6GJsI
kGmc9WG72yV97EakpzwsIgsz06QXwCh+HloNUPZQAQ9KcUFhskLXxLE7PYXKnPLr
MMAvA7aqCGPhb3/p738tT+G9IKUQfkbYmvY4ROIk56XzWT0ufVTw11jrIglQXo+g
WdJt2MbNC6f/1+NVL85q9pRBvFSeBk7D43U/B+KkM/7wmB+5fMB6DJfRAHCvjOEI
X56MyO4UJXsvs9jriDHLoqpAu3IkV1oxGzdaE/dRveqq21q1hz5S2PaOU5jPzetH
Ara3APjd55zS5EGex8t82ZJbI3aru2lPl6ztfErSWQLGNrxbVlE=
-----END NEW CERTIFICATE REQUEST-----
",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring ssl_server_keys_TEST-CERT ${name}")
  vtmrest { "ssl/server_keys/TEST-CERT/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/ssl_server_keys_TEST-CERT.erb'),
    resource => 'ssl_server_keys_TEST-CERT'),
    debug => 0,
  }
}
