class yum (
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

  # yum repository defaults.
  Yum::Repo {
    enabled        => 1,
    gpgcheck       => 1,
    repo_directory => $repo_directory,
  }
}
