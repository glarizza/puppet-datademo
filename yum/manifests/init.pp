# Class: yum
#
#   class description goes here.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class yum (
  $directory = '/etc/yum.repos.d'
){
  File {
    # uid 0, gid 0 avoids implicit dependencies.
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { $directory:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  # CentOS repos are just deployed as files
  file { "${directory}/CentOS-Base.repo":
    source => 'puppet:///modules/yum/CentOS-Base.repo',
  }
  file { "${directory}/CentOS-Debuginfo.repo":
    source => 'puppet:///modules/yum/CentOS-Debuginfo.repo',
  }
  file { "${directory}/CentOS-Media.repo":
    source => 'puppet:///modules/yum/CentOS-Media.repo',
  }
  file { "${directory}/CentOS-Vault.repo":
    source => 'puppet:///modules/yum/CentOS-Vault.repo',
  }

  # yum repository defaults.
  Yum::Repo {
    enabled  => 1,
    gpgcheck => 1,
    directory => $directory,
  }

  # epel repos
  yum::repo { 'epel':
    reponame   => 'Extra Packages for Enterprise Linux 5 - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch',
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  yum::repo { 'epel-debuginfo':
    reponame   => 'Extra Packages for Enterprise Linux 5 - $basearch - Debug',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-5&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  yum::repo { 'epel-source':
    reponame   => 'Extra Packages for Enterprise Linux 5 - $basearch - Source',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-5&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  yum::repo { 'epel-testing':
    reponame   => 'Extra Packages for Enterprise Linux 5 - Testing - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  yum::repo { 'epel-testing-debuginfo':
    reponame   => 'Extra Packages for Enterprise Linux 5 - Testing - $basearch - Debug',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  yum::repo { 'epel-testing-source':
    reponame   => 'Extra Packages for Enterprise Linux 5 - Testing - $basearch - Source',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
  }

  # ius repos
  yum::repo { 'ius':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5&arch=$basearch',
    gpgcheck   => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-debuginfo':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Debug',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-debuginfo&arch=$basearch',
    enabled    => 0,
    gpgcheck   => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-source':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Source',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-source&arch=$basearch',
    enabled    => 0,
    gpgcheck   => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-dev':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Dev',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-dev&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-dev-debuginfo':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Dev Debug Info',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-dev-debuginfo&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-dev-source':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Dev Source',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-dev-source&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-testing':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Testing',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-testing&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-testing-debuginfo':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Testing Debug',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-testing-debuginfo&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  yum::repo { 'ius-testing-source':
    reponame   => 'IUS Community Packages for Enterprise Linux 5 - $basearch - Testing Source',
    mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el5-testing-source&arch=$basearch',
    enabled    => 0,
    gpgkey     => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
  }

  # rpmforge files
  file { "${directory}/mirrors-rpmforge":
    ensure => file,
  }
  file { "${directory}/mirrors-rpmforge-extras":
    ensure => file,
  }
  file { "${directory}/mirrors-rpmforge-testing":
    ensure => file,
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
