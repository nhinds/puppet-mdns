# Type: mdns::service
#
# This type publishes a service using avahi mdns
#
# Parameters:
#   $name:
#     The service name.
#     May make use of wildcards such as %h to be replaced with the hostname
#   $type:
#     The service type.
#     This should be a valid mdns subtype and type
#     e.g. _myservice._tcp or _myservice._udp
#   $port:
#     The port that the service listens on
#   $txt:
#     An array of txt records to store with the service record
#     Defaults to no txt records
#   $subtype:
#     An array of additional mdns subtypes for the service
#     Defaults to no additional subtypes
#   $domainname:
#     The domain name this service should be registered under
#     Defaults to the default domain of the avahi daemon (.local)
#   $hostname:
#     The host name of the host that provides this service.
#     This should be a fully-qualified hostname
#     Defaults to the current host
#
# Actions:
#   Creates a service file named with the name passed in
#   Also installs the avahi daemon if not there already via the mdns class
#
# Sample Usage:
#   mdns::service {'myservice-%h':
#     type => '_myservice._tcp', 
#     port => '1234';
#   }
#
#  or
#
#   mdns::service {'myservice-%h':
#     type => '_myservice._tcp', 
#     port => '1234',
#     txt  => ['some text', 'some more text'];
#   }
#
define mdns::service (
  $type,
  $port,
  $txt=[],
  $subtype=[],
  $domainname=undef,
  $hostname=undef
  ){

  $mdns_service_name = $name
  $mdns_service_type = $type
  $mdns_service_port = $port
  $mdns_service_txt  = $txt
  $mdns_service_subtype  = $subtype
  $mdns_service_domainname  = $domainname
  $mdns_service_hostname  = $hostname

  include mdns

  file {"/etc/avahi/services/${mdns_service_name}.service":
    ensure  => 'present',
    content => template('mdns/avahi-service'),
    require => Class['mdns'];
  }

}
