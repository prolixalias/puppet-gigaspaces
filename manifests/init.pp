#
class gigaspaces {
  require stdlib
  class { '::gigaspaces::package': } ->
#  class { '::gigaspaces::config': } ->
  class { '::gigaspaces::service': }
}
