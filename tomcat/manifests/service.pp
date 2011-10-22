# Class: tomcat::service
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2010-08-13
#
#   This class models the tomcat service itself.
#
# Requires:
#
#   Class["tomcat"]
#   Class["${java_runtime_class}"]
#
class tomcat::service {
  File {
    owner => '0',
    group => '0',
    mode  => '0644',
  }

  Exec {
    path => '/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  }

  service { 'tomcat':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class['tomcat', 'tomcat::sunjdk'],
  }

  file { '/usr/bin/tomcat-check-script':
    mode    => '0755',
    source  => 'puppet:///modules/tomcat/tomcat-check-script',
    require => Service['tomcat'],
  }

  exec { 'tomcat-check-script':
    command => '/usr/bin/tomcat-check-script',
    unless  => '/usr/sbin/lsof -n -i :8080',
    require => File['/usr/bin/tomcat-check-script'],
  }
}
