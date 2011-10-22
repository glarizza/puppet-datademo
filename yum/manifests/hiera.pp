class yum::hiera (
  $repo_directory = $yum::params::repo_directory
) inherits yum::params {
  File {
    # uid 0, gid 0 avoids implicit dependencies.
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { $repo_directory:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  exec { 'refresh_cache':
    command     => '/bin/echo "yum makecache goes here"',
    refreshonly => true,
  }

  # CentOS repos are just deployed as files
  file { "${repo_directory}/CentOS-Base.repo":
    source => 'puppet:///modules/yum/CentOS-Base.repo',
  }
  file { "${repo_directory}/CentOS-Debuginfo.repo":
    source => 'puppet:///modules/yum/CentOS-Debuginfo.repo',
  }
  file { "${repo_directory}/CentOS-Media.repo":
    source => 'puppet:///modules/yum/CentOS-Media.repo',
  }
  file { "${repo_directory}/CentOS-Vault.repo":
    source => 'puppet:///modules/yum/CentOS-Vault.repo',
  }

  # yum repository defaults.
  Yum::Repo {
    enabled        => 1,
    gpgcheck       => 1,
    repo_directory => $repo_directory,
  }

  $yumrepos = hiera_hash('yumrepos')
  # epel repos
  create_resources ('yum::repo', $yumrepos)
}
