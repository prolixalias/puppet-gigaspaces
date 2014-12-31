class gigaspaces::config {

  if $manage_user {

    user { 'gigaspaces':
      ensure   => present,
      password => $::gigaspaces::user_password,
      home     => $::gigaspaces::home_dir,
    }

    File {
      owner => gigaspaces,
      group => gigaspaces,
    }
  }

  if $manage_license {
    file { 'gslicense':
      ensure  => present,
      path    => "${::gigaspaces_home}/gslicense.xml",
      content => template("${module_name}/gslicense.xml.erb"),
    }
  }

  file { 'gigaspaces_environment.sh':
    ensure  => present,
    path    => "${::gigaspaces_home}/environment.sh",
    content => template("${module_name}/gs_environment.erb"),

  }

  file { 'gigaspaces_limits.d_conf':
    ensure => file,
    path   => '/etc/security/limits.d/10-gigaspaces.conf',
    source => "puppet:///modules/${module_name}/gigaspaces_limits.conf",
    mode   => '0644',
    owner  => root,
    group  => root,
  }

  file { $gigaspaces_lib_dir:
    ensure => directory,
    mode   => '0755',
  }

  file { "${gigaspaces_lib_dir}/work":
    ensure => directory,
  }
}
