class gigaspaces::package {
  
  $unpack_dir    = dirname($gigaspaces::home_dir)
  $file_name     = "${gigaspaces::package_base_name}-${gigaspaces::package_version}-ga-${gigaspaces::package_build}.zip"
  $install_path  = "${unpack_dir}/${gigaspaces::package_base_name}-${gigaspaces::package_version}-ga"
  
  if $gigaspaces::manage_java {
    package { 'java':
      ensure => installed,
    }
  }
  
  if ($gigaspaces::manage_package and $gigaspaces::package_provider == 'zip') {
    package { 'unzip':
      ensure => present,
    }

    file { 'gigaspaces_zip':
      ensure  => file,
      path    => "${install_path}-${gigaspaces::package_build}.zip",
      source  => "puppet:///modules/${module_name}/${file_name}",
      notify  => Exec['unzip_gigaspaces'],
      require => Package['unzip'],
    }

    exec { 'unzip_gigaspaces':
      command => "unzip ${unpack_dir}/${file_name}",
      cwd     => $unpack_dir,
      path    => '/usr/bin',
      creates => $install_path,
      require => File['gigaspaces_zip'],
    }

  } elsif ($gigaspaces::manage_package and $gigaspaces::package_provider == 'os_package') {

    package { 'gigaspaces':
      ensure => present,
    }
  } else {
    notice ("You have opted out of managing the ${module_name} package from this module.")
  }
  

  file { 'gigaspaces':
    ensure => link,
    name   => $gigaspaces::home_dir,
    target => $install_path,
  }
}
