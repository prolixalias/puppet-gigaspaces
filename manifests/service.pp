class gigaspaces::service {
  if $gigaspaces::manage_service {
    service { 'gigaspace-agent':
      ensure  => running,
      enable  => true,
      require => File['gigaspaces_init_file'],
    }

    file { 'gigaspaces_init_file':
      ensure  => file,
      path    => '/etc/init.d/gigaspaces-agent',
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template("${module_name}/init.erb"),
      notify  => Service['gigaspace-agent'],
      require => File['gs_environment'],
    }
  }
}
