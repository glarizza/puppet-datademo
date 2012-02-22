define tomcat::war(
  $war_source        = $tomcat::params::war_source,
  $tomcat_stage_dir  = $tomcat::params::tomcat_stage_dir,
  $tomcat_target_dir = $tomcat::params::tomcat_target_dir,
  $filename
) {

  file { "${tomcat_stage_dir}/war":
    ensure => directory,
  }

  file { "${tomcat_target_dir}/apps":
    ensure       => directory,
    #purge        => true,
    #force        => true,
    #recurse      => true,
    #recurselimit => 1,
    backup       => false,
  }

  file { "${tomcat_stage_dir}/war/${filename}":
    source  => "${war_source}/${filename}",
    backup  => false,
    notify  => Service['tomcat'],
  }

  exec { "extract_${name}":
    command     => "unzip ${tomcat_stage_dir}/war/${filename} -d ${tomcat_target_dir}/apps/${filename}",
    path        => '/bin:/usr/bin',
    refresh     => "rm -Rf ${tomcat_target_dir}/apps/${filename} && unzip ${tomcat_stage_dir}/war/${filename} -d ${tomcat_target_dir}/apps/${filename}",
    require     => File["${tomcat_target_dir}/apps"],
    subscribe   => File["${tomcat_stage_dir}/war/${filename}"],
    refreshonly => true,
    notify      => Service['tomcat'],
  }

  file { "${tomcat_target_dir}/apps/${filename}":
    ensure => directory,
  }

  file { "${tomcat_target_dir}/webapps/${name}":
    ensure  => symlink,
    target  => "${tomcat_target_dir}/apps/${filename}",
    require => File["${tomcat_target_dir}/apps/${filename}"],
    notify  => Service['tomcat'],
  }
}

