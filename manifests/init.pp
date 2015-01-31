# == Class: gigaspaces
#
# This class installs and configures the Gigaspaces XAP agent on a node.
# 
# === Parameters
#
# 
class gigaspaces (
  $bind_host           = $gigaspaces::params::bind_host,
  $environment_file    = $gigaspaces::params::environment_file,
  $group               = $gigaspaces::params::group,
  $home_dir            = $gigaspaces::params::home_dir,
  $java_home           = $gigaspaces::params::java_home,
  $lib_dir             = $gigaspaces::params::lib_dir,
  $license_key         = $gigaspaces::params::license_key,
  $log_dir             = $gigaspaces::params::log_dir,
  $lookup_groups       = $gigaspaces::params::lookup_groups,
  $lookup_locators     = $gigaspaces::params::lookup_locators,
  $lookup_port         = $gigaspaces::params::lookup_port,
  $manage_java         = $gigaspaces::params::manage_java,
  $manage_license      = $gigaspaces::params::manage_license,
  $manage_package      = $gigaspaces::params::manage_package,
  $manage_service      = $gigaspaces::params::manage_service,
  $manage_user         = $gigaspaces::params::manage_user,
  $management_machine  = $gigaspaces::params::management_machine,
  $package_base_name   = $gigaspaces::params::package_base_name,
  $package_build       = $gigaspaces::params::build_version,
  $package_provider    = $gigaspaces::params::package_provider,
  $package_version     = $gigaspaces::params::package_version,
  $password            = $gigaspaces::params::password,
  $user                = $gigaspaces::params::user,
) inherits gigaspaces::params {

  validate_string($environment_file, $home_dir, $java_home, $lib_dir)
  validate_string($license_key, $log_dir, $package_base_name, $package_build)
  validate_string($package_version, $user, $group, $password, $bind_host)
  validate_array($lookup_groups, $lookup_locators)
  validate_bool($manage_java, $manage_license, $manage_package)
  validate_bool($manage_service, $manage_user, $management_machine)
  validate_re($package_provider, '^os_package$', '^zip$')

  class { 'gigaspaces::package': } ->
  class { 'gigaspaces::config': } ->
  class { 'gigaspaces::service': }

}
