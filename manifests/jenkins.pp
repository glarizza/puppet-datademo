# Class: tomcat::jenkins
#
#   This class models the Jenkins Continuous Integration
#   service in Puppet.
#
class tomcat::jenkins(
  $jenkins_version   = $tomcat::params::jenkins_version,
  $jenkins_installer = $tomcat::params::jenkins_installer,
  $ensure            = 'present'
) inherits tomcat::params {

  File {
    owner => "0",
    group => "0",
    mode  => "0644",
  }

  if $ensure == 'absent' {
    file { '/usr/tomcat/webapps/jenkins':
      ensure => absent,
      purge  => true,
      force  => true,
      backup => false,
    }

    exec {'stop-tomcat-jenkins':
      command => '/usr/bin/stop_tomcat.sh',
      onlyif  => '/bin/ls /usr/tomcat/webapps/jenkins.war',
      before  => [ File['/usr/tomcat/webapps/jenkins.war'], File['/usr/tomcat/webapps/jenkins'] ],
      require => File['/usr/bin/stop_tomcat.sh'],
    }

    file { '/usr/bin/stop_tomcat.sh':
      source => 'puppet:///modules/tomcat/stop_tomcat.sh',
      mode   => '0755',
    }
  } 

  file { "/usr/tomcat/webapps/jenkins.war":
    ensure  => $ensure ? {
      'absent' => absent,
      default  => present,
    },
    source  => "puppet:///modules/tomcat/war/${jenkins_installer}",
    require => File['/usr/tomcat'],
    before  => Class['tomcat::service'],
    backup  => false,
    notify  => Service['tomcat'],
  }
}
