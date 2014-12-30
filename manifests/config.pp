#
class gigaspaces::config (
  $gigaspaces_home    = '/opt/gigaspaces',
  $gigaspaces_lib_dir = '/var/lib/gigaspaces',
  $java_home          = '/usr/java/default',
  $gs_license         = 'Sep 30, 2044~IntJoors_AB@NAETVOKRP6Z7OOYGk4NP#PREMIUM^10.0XAPPremium%UNBOUND+UNLIMITED',
  # Lookup machines is written as a single string with ip/hostname:port separated by comma.
  # Example: localhost:4174,remotehost:6784,10.10.10.1:1337
  $lookup_locators    = false,
  $lookup_groups      = false,
  # Set true for management machines to start a GSM as well as an GSA
  $management_machine = false,
) {

  validate_bool($management_machine)
  validate_string($lookup_locators)

  Exec {
    path => '/bin/',
  }

  file { 'gslicense':
    ensure  => present,
    path    => "${gigaspaces_home}/gslicense.xml",
    content => template("${module_name}/gslicense.xml.erb"),
    owner   => gigaspaces,
    group   => gigaspaces,
  }


  file { 'gs_init':
    ensure  => present,
    path    => '/etc/init.d/gigaspace-agent',
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template("${module_name}/init.erb"),
    notify  => Service['gigaspace-agent'],
    require => File['gs_environment'],
  }

  file { 'gs_environment':
    ensure  => present,
    path    => "${gigaspaces_home}/environment.sh",
    owner   => gigaspaces,
    group   => gigaspaces,
    content => template("${module_name}/gs_environment.erb"),

  }

  file { 'limits_gigaspaces':
    ensure => file,
    path   => '/etc/security/limits.d/10-gigaspaces.conf',
    source => "puppet:///modules/${module_name}/gigaspaces_limits.conf",
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  user { 'gigaspaces':
    ensure   => present,
    uid      => '1500',
    password => 'gigaspaces',
    home     => '/home/gigaspaces',
  }

  file { $gigaspaces_lib_dir:
    ensure => directory,
    owner  => gigaspaces,
    mode   => '0755',
  }

  file { "${gigaspaces_home}/logs":
    ensure  => link,
    target  => '/var/log/gigaspaces',
    require => Exec['move_gigaspaces_log_dir'],
  }

  exec { 'move_gigaspaces_log_dir':
    command => "mv ${gigaspaces_home}/logs /var/log/gigaspaces && chown -R gigaspaces: ${gigaspaces_home}",
    creates => '/var/log/gigaspaces',
    notify  => File['/opt/gigaspaces/logs'],
  }

  file { "${gigaspaces_home}/deploy":
    ensure  => link,
    target  => "${gigaspaces_lib_dir}/deploy",
    require => [File[$gigaspaces_lib_dir], Exec['move_gigaspaces_deploy_dir']],
  }

  exec { 'move_gigaspaces_deploy_dir':
    command => "mv ${gigaspaces_home}/deploy ${gigaspaces_lib_dir}/ && chown -R gigaspaces: ${gigaspaces_lib_dir}",
    creates => "${gigaspaces_lib_dir}/deploy",
    notify  => File["${gigaspaces_home}/deploy"],
  }

  file { "${gigaspaces_home}/work":
    ensure  => link,
    target  => "${gigaspaces_lib_dir}/work",
    require => File["${gigaspaces_lib_dir}/work"],
  }

  file { "${gigaspaces_lib_dir}/work":
    ensure => directory,
    owner  => gigaspaces,
    group  => gigaspaces,
  }
}
