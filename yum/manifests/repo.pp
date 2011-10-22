define yum::repo(
  $reponame,
  $baseurl        = $yum::params::baseurl,
  $mirrorlist     = $yum::params::mirrorlist,
  $failovermethod = $yum::params::failovermethod,
  $enabled        = $yum::params::enabled,
  $protect        = $yum::params::protect,
  $gpgcheck       = $yum::params::gpgcheck,
  $gpgkey         = $yum::params::gpgkey,
  $repo_directory = $yum::params::repo_directory
) {
  file { "${repo_directory}/${name}.repo":
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template('yum/repo.erb'),
    notify  => Exec['refresh_cache'],
  }
}
