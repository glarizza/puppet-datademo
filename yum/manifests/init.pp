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

  # epel repos
  yum::repo { 'epel':
    reponame   => 'Extra Packages for Enterprise Linux 5 - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch',
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  # rpmforge repos
  yum::repo { 'rpmforge':
    reponame   => 'RHEL $releasever - RPMforge.net - dag',
    baseurl    => 'http://apt.sw.be/redhat/el5/en/$basearch/rpmforge',
    mirrorlist => 'http://apt.sw.be/redhat/el5/en/mirrors-rpmforge',
    protect    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }

  yum::repo { 'rpmforge-extras':
    reponame   => 'RHEL $releasever - RPMforge.net - extras',
    baseurl    => 'http://apt.sw.be/redhat/el5/en/$basearch/extras',
    mirrorlist => 'http://apt.sw.be/redhat/el5/en/mirrors-rpmforge-extras',
    enabled    => 0,
    protect    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }

  yum::repo { 'rpmforge-testing':
    reponame   => 'RHEL $releasever - RPMforge.net - testing',
    baseurl    => 'http://apt.sw.be/redhat/el5/en/$basearch/testing',
    mirrorlist => 'http://apt.sw.be/redhat/el5/en/mirrors-rpmforge-testing',
    enabled    => 0,
    protect    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }
}
