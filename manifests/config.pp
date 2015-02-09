# == Class: gigaspaces::config
#
# This manages and installs the configuration files for Gigaspaces
#
# === Parameters
#
# This class does not provide any parameters
#
# === Examples 
#
# This class may be imported by other classes to use its functionality:
#   class { 'gigaspaces::config': }
# 
# It is not intended to be used directly by external resources like node 
# definitions or other modules.
#
# === Authors
#
# * Lowe Schmidt <mailto:github@loweschmidt.se>
#
class gigaspaces::config {

  File {
    owner => $gigaspaces::user,
    group => $gigaspaces::group,
  }

  if $gigaspaces::manage_user {

    user { $gigaspaces::user:
      ensure   => present,
      password => $gigaspaces::password,
      home     => $gigaspaces::home_dir,
      group    => $gigaspaces::group,
    }
  }

  if $gigaspaces::manage_license {
    file { 'gigaspaces_license':
      ensure  => present,
      path    => "${gigaspaces::home_dir}/gslicense.xml",
      content => template("${module_name}/gslicense.xml.erb"),
    }
  }

  file { 'gigaspaces_environment.sh':
    ensure  => present,
    path    => "${gigaspaces::home_dir}/environment.sh",
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
}
