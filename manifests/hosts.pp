# Class: mdns::hosts
#
# This class manages /etc/avahi/hosts based on hosts registered by avahi:;host
# resources. Note that this will replace any existing contents of that file.
#
# Actions:
#   Causes /etc/avahi/hosts to be managed by puppet
#   Also installs the avahi daemon if not there already via the mdns class
#
class mdns::hosts {
  $hosts_file = '/etc/avahi/hosts'

  include mdns

  concat{$hosts_file:
    warn => true,
    require => Class['mdns'];
  }
}