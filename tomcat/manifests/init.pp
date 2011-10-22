# Class: tomcat
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2010-08-05
#   Status: This class is working and properly starts the tomcat service.
#
#   This class models the tomcat service in Puppet
#   Developed and tested on CentOS 5.5 x86_64
#
#   Once the service is running, connect to:
#   http://<ipaddress>:8080/
#
# Actions:
#
#   Unpacks tomcat into /usr/apache-tomcat-<version>
#   Links /usr/tomcat to /usr/apache/tomcat-<version>
#   Manages the tomcat service using the system service manager
#
# Requires:
#
#   Java Runtime.  Available in class tomcat::sunjdk within this module
#   If another java runtime is to be used, modify the $java_runtime_class
#   variable at the top of the tomcat class model.
#
#   Class["${java_runtime_class}"] provided by class { "tomcat::sunjdk": }
#
# Sample Usage:
#
#   include tomcat::sunjdk
#   include tomcat
#
class tomcat(
  $tomcat_version   = $tomcat::params::tomcat_version,
  $tomcat_installer = $tomcat::params::tomcat_installer
) inherits tomcat::params {

  # Resource defaults.
  File {
    owner => '0',
    group => '0',
    mode  => '0644',
  }

  Exec {
    path => '/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  }

  file { "/var/tmp/${tomcat_installer}":
    source  => "puppet:///modules/tomcat/${tomcat_installer}",
  }

  exec { 'unpack-tomcat':
    command => "tar -C /usr -x -z -f /var/tmp/${tomcat_installer}",
    creates => "/usr/apache-tomcat-${tomcat_version}",
    require => File["/var/tmp/${tomcat_installer}"],
  }

  file { '/usr/tomcat':
    ensure  => symlink,
    target  => "/usr/apache-tomcat-${tomcat_version}",
    require => Exec["unpack-tomcat"],
  }

  file { '/etc/init.d/tomcat':
    mode    => '0755',
    source  => 'puppet:///modules/tomcat/tomcat-init-script',
    require => File['/usr/tomcat'],
  }

  file { '/opt/tomcat':
    ensure       => directory,
    purge        => true,
    recurse      => true,
    force        => true,
    recurselimit => 3,
    backup       => false,
  }

  exec { 'tomcat_restart':
    command     => '/etc/init.d/tomcat stop && sleep 3 && /etc/init.d/tomcat start',
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    logoutput   => true,
    refreshonly => true,
    subscribe   => File['/opt/tomcat'],
  }
}
