define tomcat::war(
  $war_source        = $tomcat::params::war_source,
  $tomcat_stage_dir  = $tomcat::params::tomcat_stage_dir,
  $tomcat_target_dir = $tomcat::params::tomcat_target_dir,
  $filename
) {

  if !defined(File[$tomcat_stage_dir]) {
    file { $tomcat_stage_dir:
      ensure => directory,
    }
  }

  if !defined(File["${tomcat_stage_dir}/war"]) {
    file { "${tomcat_stage_dir}/war":
      ensure => directory,
    }
  }

  if !defined(File[$tomcat_target_dir]) {
    file { $tomcat_target_dir:
      ensure => directory,
    }

    file { "${tomcat_target_dir}/apps":
      ensure       => directory,
      purge        => true,
      force        => true,
      recurse      => true,
      recurselimit => 1,
      backup       => false,
    }
  }

  file { "${tomcat_stage_dir}/war/${name}.war":
    source => "${war_source}/${filename}",
    backup => false,
    notify => Exec['stop_tomcat'],
  }

  exec { "extract_${name}":
    command     => "unzip ${tomcat_stage_dir}/war/${name}.war -d ${tomcat_target_dir}/apps/${name}",
    path        => '/bin:/usr/bin',
    refresh     => "rm -Rf ${tomcat_target_dir}/apps/${name} && unzip ${tomcat_stage_dir}/war/${name}.war -d ${tomcat_target_dir}/apps/${name}",
    require     => File["${tomcat_target_dir}/apps"],
    subscribe   => File["${tomcat_stage_dir}/war/${name}.war"],
    refreshonly => true,
    notify      => Exec['start_tomcat'],
  }

  file { '/usr/bin/stop_tomcat':
    ensure => present,
    mode   => '0755',
    source => 'puppet:///modules/tomcat/stop_tomcat.sh',
  }

  exec { 'stop_tomcat':
    command     => '/usr/bin/stop_tomcat',
    refreshonly => true,
    require     => File['/usr/bin/stop_tomcat'],
    before      => Exec["extract_${name}"],
  }

  exec { 'start_tomcat':
    command     => '/etc/init.d/tomcat start',
    refreshonly => true,
  }

  file { "${tomcat_target_dir}/apps/${name}":
    ensure  => directory,
    require => Exec["extract_${name}"],
  }

  file { "${tomcat_target_dir}/${name}":
    ensure   => symlink,
    target   => "${tomcat_target_dir}/apps/${name}",
    #require => Exec["extract_${name}"],
    require  => File["${tomcat_target_dir}/apps/${name}"],
  }
}
