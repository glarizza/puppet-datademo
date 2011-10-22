# Class: tomcat::hudson
#
#   This class models the Hudson Continuous Integration
#   service in Puppet.
#
class tomcat::hudson {
  $hudson_version = '1.369'
  $installer = "hudson-${hudson_version}.war"

  File {
    owner => '0',
    group => '0',
    mode  => '0644',
  }

	file { '/usr/tomcat/webapps/hudson.war':
    source  => "puppet:///modules/tomcat/${installer}",
    require => File['/usr/tomcat'],
    before  => Class['tomcat::service'],
    notify  => Service['tomcat'],
	}
}
