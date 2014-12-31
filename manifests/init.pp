class gigaspaces (
  $environment_file   = $gigaspaces::params::environment_file,
  $home_dir           = $gigaspaces::params::home_dir,
  $java_home          = $gigaspaces::params::java_home,
  $lib_dir            = $gigaspaces::params::lib_dir,
  $license_key        = $gigaspaces::params::license_key,
  $log_dir            = $gigaspaces::params::log_dir,
  $lookup_groups      = $gigaspaces::params::lookup_groups,
  $lookup_locators    = $gigaspaces::params::lookup_locators,
  $lookup_port        = $gigaspaces::params::lookup_port,
  $manage_java        = $gigaspaces::params::manage_java,
  $manage_license     = $gigaspaces::params::manage_license,
  $manage_package     = $gigaspaces::params::manage_package,
  $manage_service     = $gigaspaces::params::manage_service,
  $manage_user        = $gigaspaces::params::manage_user,
  $management_machine = $gigaspaces::params::management_machine,
  $package_base_name  = $gigaspaces::params::package_base_name,
  $package_build      = $gigaspaces::params::build_version,
  $package_version    = $gigaspaces::params::package_version,
  $user          = $gigaspaces::params::user,
  $password      = $gigaspaces::params::password,
) inherits gigaspaces::params {

  require stdlib
  class { '::gigaspaces::package': } ->
  class { '::gigaspaces::config': } ->
  class { '::gigaspaces::service': }

}
