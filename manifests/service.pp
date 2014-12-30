class gigaspaces::service {
  service { 'gigaspace-agent':
    ensure  => running,
    enable  => true,
    require => File['gs_init'],
  }
}
