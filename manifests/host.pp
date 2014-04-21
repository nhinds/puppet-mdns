# Type: mdns::host
#
# This type adds a static host <-> IP address mapping to /etc/avahi/hosts
#
# Parameters:
#   $name:
#     The host name.
#     This should be a fully-qualified hostname, i.e. ending in .local
#   $address:
#     The IP address of the host.
#
# Actions:
#   Adds a line to /etc/avahi/hosts with the provided mapping
#   Causes /etc/avahi/hosts to be managed by puppet via the mdns::hosts class
#   Also installs the avahi daemon if not there already via the mdns class
#
# Sample Usage:
#   mdns::host {'server.local':
#     address => '10.1.1.1';
#   }
#
define mdns::host (
  $address
  ){

  include mdns::hosts

  concat::fragment {"mdns::host::$name":
    target => $mdns::hosts::hosts_file,
    content => "$address $name\n";
  }
}