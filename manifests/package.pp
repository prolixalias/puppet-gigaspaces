class gigaspaces::package {
  
  file { 'oracle_jdk':
    ensure  => present,
    path    => '/opt/jdk-7u71-linux-x64.rpm',
    source  => "puppet:///modules/${module_name}/jdk-7u71-linux-x64.rpm",
  }

  exec { 'install_oracle_jdk':
    path    => '/bin',
    cwd     => '/opt',
    command => 'rpm -iv jdk-7u71-linux-x64.rpm',
    creates => '/usr/java/',
    require => File['oracle_jdk'],
  }

  package { 'unzip':
    ensure => present,
  }

  $gs_basename = 'gigaspaces-xap-premium'

  file { 'gigaspaces_zip':
    ensure  => file,
    path    => "/opt/${gs_basename}-${package_version}-ga-${package_build}.zip",
    source  => "puppet:///modules/${module_name}/${gs_basename}-${package_version}-ga-${package_build}.zip",
    notify  => Exec['unzip_gigaspaces'],
    require => Package['unzip'],
  }
  exec { 'unzip_gigaspaces':
    command => "unzip /opt/${gs_basename}-${package_version}-ga-${package_build}.zip",
    cwd     => '/opt/',
    path    => '/usr/bin',
    creates => "/opt/${gs_basename}-${package_version}-ga",
    require => File['gigaspaces_zip'],
  }

  file { 'gigaspaces':
    ensure => link,
    name   => '/opt/gigaspaces',
    target => "/opt/${gs_basename}-${package_version}-ga"
  }
}
