# Class: mdns
#
# This class includes the common components for mdns installation
#
# Parameters:
#   $purge_services:
#     Whether to remove existing service files from /etc/avahi/services.
#     Defaults to false.
#
# Actions:
#
# Sample Usage:
#   include mdns
#
class mdns($purge_services=false) {
  package {['avahi-daemon', 'avahi-utils']:}

  file {'/etc/avahi/services':
    ensure => directory,
    recurse => true,
    purge => $purge_services,
    require => Package['avahi-daemon'];
  }
}
