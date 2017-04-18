class goaudit::params {
  $package_ensure = 'present'
  $service_ensure = 'running'

  $events_min = 1300
  $events_max = 1399

  $message_tracking_enabled = true
  $message_tracking_log_ooo = false
  $message_tracking_max_ooo = 500

  $output_stdout_enabled = true
  $output_stdout_attempts = 2

  $output_syslog_enabled = false
  $output_syslog_attempts = 5
  $output_syslog_network = 'unixgram'
  $output_syslog_address = '/dev/log'
  $output_syslog_priority = 129
  $output_syslog_tag = 'go-audit'

  $output_file_enabled = false
  $output_file_attempts = 2
  $output_file_path = '/var/log/go-audit/go-audit.log'
  $output_file_mode = '0600'
  $output_file_user = 'root'
  $output_file_group = 'root'

  $log_flags = 0

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
}

