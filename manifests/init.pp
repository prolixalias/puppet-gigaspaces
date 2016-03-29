# == Class: gigaspaces
#
# This class installs and configures the Gigaspaces XAP agent on a node.
# All defaults values will be found in the params.pp file
#
# === Parameters
# 
# [*bind_host*]
#   String. What IP address or hostname to bind the Gigaspaces services to. 
#   Defaults to the facter value $::ipaddress
#
# [*environment_file*]
#   String. Path to the environment file on the target system, defaults to ${home_dir}/environment.sh.
#   The environment file sets the Java options for Gigasapces.
#
# [*group*]
#   String. Sets the group the gigaspaces user should belong too.
#
# [*home_dir*]
#   String. The directory which the gigaspaces distribution will reside. 
#
# [*java_home*]
#   String. Directory where you can find the JDK distribution you are using. 
#
# [*lib_dir*]
#   String. The library directory for gigaspaces.
#
# [*license_key*]
#   String. The gigaspaces license key.
# 
# [*log_dir*] 
#   String. The directory path for gigaspaces log files.
#
# [*lookup_groups*]
#   Array. Lookup group to be configured for the agent.
#
# [*lookup_locators*]
#   Array. The IP address(es) or hostname(s) of the management machines. 
#   Should probably be collectable via tags from a managment machine in the future.
#
# [*lookup_port*]
#   Number. The port to use for connecting to the management machines.
#
# [*manage_java*]
#   Boolean. If set to true it will install the package 'java'
#
# [*manage_license*]
#   Boolean. If set to true it will distribute the license file, requires the
#   license_key variable to be set. 
#
# [*manage_package*]
#   Boolean. Install the gigaspace package, currently needs the zip file
#   located in the files directory in this module.
#
# [*manage_service*]
#   Boolean. If true will install the service file and enable the service.
#
# [*manage_user*]
#   Boolean. If true will create the user specified in the user parameter.
#   Disable this if you use LDAP or something similar even for system users.
#
class gigaspaces (
  String $bind_host                           = $gigaspaces::params::bind_host,
  String $environment_file                    = $gigaspaces::params::environment_file,
  String $group                               = $gigaspaces::params::group,
  String $home_dir                            = $gigaspaces::params::home_dir,
  String $java_home                           = $gigaspaces::params::java_home,
  String $lib_dir                             = $gigaspaces::params::lib_dir,
  String $license_key                         = $gigaspaces::params::license_key,
  String $log_dir                             = $gigaspaces::params::log_dir,
  Array $lookup_groups                        = $gigaspaces::params::lookup_groups,
  Array $lookup_locators                      = $gigaspaces::params::lookup_locators,
  Integer $lookup_port                        = $gigaspaces::params::lookup_port,
  Boolean $manage_java                        = $gigaspaces::params::manage_java,
  Boolean $manage_license                     = $gigaspaces::params::manage_license,
  Boolean $manage_package                     = $gigaspaces::params::manage_package,
  Boolean $manage_service                     = $gigaspaces::params::manage_service,
  Boolean $manage_user                        = $gigaspaces::params::manage_user,
  String $management_machine                  = $gigaspaces::params::management_machine,
  String $package_base_name                   = $gigaspaces::params::package_base_name,
  String $package_build                       = $gigaspaces::params::build_version,
  Enum['zip', 'os_package'] $package_provider = $gigaspaces::params::package_provider,
  Float $package_version                      = $gigaspaces::params::package_version,
  String $password                            = $gigaspaces::params::password,
  String $user                                = $gigaspaces::params::user,
) inherits gigaspaces::params {

  include stdlib
  class { 'gigaspaces::package': }
  class { 'gigaspaces::config': }
  class { 'gigaspaces::service': }

}
