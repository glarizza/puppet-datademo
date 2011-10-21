# Class: tomcat::sunjdk
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2010-08-05
#
#   This class models the Sun Java Development Kit in Puppet
#
class tomcat::sunjdk(
  $architechture_real = $tomcat::params::architechture_real,
  $jdk_installer      = $tomcat::params::jdk_installer
) inherits tomcat::params {

	File {
    owner => "0",
    group => "0",
    mode  => "0644",
  }

  Exec {
    path => "/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
  }

  file { "/var/tmp/${jdk_installer}":
		mode   => "0755",
		source => "puppet:///modules/tomcat/${jdk_installer}",
		notify => Exec["install-jdk"],
  }

  exec { "install-jdk":
    command => "/var/tmp/${jdk_installer} -noregister",
    cwd     => "/var/tmp",
    creates => "/usr/java",
  }

# Provide an anchor for resource relationships
	file { "/usr/java":
		require => Exec["install-jdk"],
		ensure  => "directory";
	}
}
