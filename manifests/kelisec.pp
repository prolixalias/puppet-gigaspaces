class gigaspaces::kelisec {
  $lib_path = '/usr/java/default/jre/lib/security'

  File {
    owner => root,
    group => root,
    mode  => '0644',
  }

  file {
    'kelisec_local_policy':
      ensure => present,
      path   => "${lib_path}/local_policy.jar",
      source => "puppet:///modules/${module_name}/local_policy.jar";

    'kelisec_US_policy':
      ensure => present,
      path   => "${lib_path}/US_export_policy.jar",
      source => "puppet:///modules/${module_name}/US_export_policy.jar";
  }
}
