class tomcat::users(
  tomcat_users = $tomcat::params::tomcat_users,
  roles        = $tomcat::params::roles
) inherits tomcat::params {

  # $tomcat_users and $roles are both used in the template
  file { "${tomcat::params::catalina_home}/conf/tomcat-users.xml":
    ensure => present,
    owner  => '0',
    group  => '0',
    mode   => '0644',
    source => 'puppet:///modules/tomcat/tomcat-users.xml',
  }
}
