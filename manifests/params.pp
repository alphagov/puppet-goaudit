class goaudit::params {
  $package_ensure = 'present'
  $service_ensure = 'running'

  case $::osfamily {
    'Debian': {
      $package_name = 'go-audit'
      $config_file  = '/etc/go-audit.yaml'
      $service_name = 'go-audit'
    }
    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
  }
}

