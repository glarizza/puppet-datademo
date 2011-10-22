# Define: yum::repo
#
#   yum repo.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define yum::repo(
  $reponame,
  $baseurl        = '',
  $mirrorlist     = '',
  $failovermethod = priority,
  $enabled        = 1,
  $protect        = '',
  $gpgcheck       = 1,
  $gpgkey         = '',
  $directory      = '/etc/yum.repos.d'
) {
  file { "${directory}/${name}.repo":
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template('yum/repo.erb'),
  }
}
