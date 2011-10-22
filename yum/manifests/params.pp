class yum::params {
  $repo_directory = '/etc/yum.repos.d'
  $baseurl        = ''
  $mirrorlist     = ''
  $failovermethod = priority
  $enabled        = 1
  $protect        = ''
  $gpgcheck       = 1
  $gpgkey         = ''
}