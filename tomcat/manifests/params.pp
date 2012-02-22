##  Parameter Class for Tomcat Module
#
class tomcat::params {
  #$tomcat_version     = "5.5.30"
  #$tomcat_installer   = "apache-tomcat-${tomcat_version}.tar.gz"
  #$architecture_real  = $::architecture ? {
  #  "x86_64" => "x64",
  #  "i386"   => "i586",
  #  default  => $::architecture,
  #}
  #$jdk_installer      = "jdk-6u21-linux-${architecture_real}-rpm.bin"
  #$war_source      = 'puppet:///modules/tomcat/war'
  #$tomcat_stage_dir   = "/opt/tomcat"
  #$tomcat_target_dir  = "/usr/tomcat/webapps"
  #$catalina_home      = '/usr/tomcat'
  $tomcat_users       = {'gary' => 'puppet', 'demouser' => 'test'}
  $roles              = {'gary' => 'manager,tomcat', 'demouser' => 'tomcat'}

  $tomcat_version     = hiera("tomcat_version")
  $tomcat_installer   = hiera("tomcat_installer")
  $architecture_real  = hiera("architecture_real")
  $jdk_installer      = hiera("jdk_installer")
  $war_source         = hiera("war_source")
  $tomcat_stage_dir   = hiera("tomcat_stage_dir")
  $tomcat_target_dir  = hiera("tomcat_target_dir")
  $catalina_home      = hiera("catalina_home")

  file { '/tmp/variables':
    ensure  => present,
    content => template('tomcat/variables.erb'),
  }
}

