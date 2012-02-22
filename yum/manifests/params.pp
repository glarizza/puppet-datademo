class yum::params {
  $repo_directory = hiera('repo_directory', nil)
  $baseurl        = hiera('baseurl', nil)
  $mirrorlist     = hiera('mirrorlist', nil)
  $failovermethod = hiera('failovermethod', nil)
  $enabled        = hiera('enabled', nil)
  $protect        = hiera('protect', nil)
  $gpgcheck       = hiera('gpgcheck', nil)
  $gpgkey         = hiera('gpgkey', nil)
}
