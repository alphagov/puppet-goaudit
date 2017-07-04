# See README.md
class goaudit (
  $package_name             = $goaudit::params::package_name,
  $package_ensure           = $goaudit::params::package_ensure,
  $config_file              = $goaudit::params::config_file,
  $service_name             = $goaudit::params::service_name,
  $service_enable           = $goaudit::params::service_enable,
  $service_ensure           = $goaudit::params::service_ensure,
  $events_min               = $goaudit::params::events_min,
  $events_max               = $goaudit::params::events_max,
  $message_tracking_enabled = $goaudit::params::message_tracking_enabled,
  $message_tracking_log_ooo = $goaudit::params::message_tracking_log_ooo,
  $message_tracking_max_ooo = $goaudit::params::message_tracking_max_ooo,
  $output_stdout_enabled    = $goaudit::params::output_stdout_enabled,
  $output_stdout_attempts   = $goaudit::params::output_stdout_attempts,
  $output_syslog_enabled    = $goaudit::params::output_syslog_enabled,
  $output_syslog_attempts   = $goaudit::params::output_syslog_attempts,
  $output_syslog_network    = $goaudit::params::output_syslog_network,
  $output_syslog_address    = $goaudit::params::output_syslog_address,
  $output_syslog_priority   = $goaudit::params::output_syslog_priority,
  $output_syslog_tag        = $goaudit::params::output_syslog_tag,
  $output_file_enabled      = $goaudit::params::output_file_enabled,
  $output_file_attempts     = $goaudit::params::output_file_attempts,
  $output_file_path         = $goaudit::params::output_file_path,
  $output_file_mode         = $goaudit::params::output_file_mode,
  $output_file_user         = $goaudit::params::output_file_user,
  $output_file_group        = $goaudit::params::output_file_group,
  $log_flags                = $goaudit::params::log_flags,
  $auto_enable_rule         = $goaudit::params::auto_enable_rule,
) inherits goaudit::params {

  validate_string($package_name)
  validate_string($package_ensure)
  validate_absolute_path($config_file)
  validate_string($service_name)
  validate_string($service_ensure)

  validate_integer($events_min)
  validate_integer($events_max)

  validate_bool($message_tracking_enabled)
  validate_bool($message_tracking_log_ooo)
  validate_integer($message_tracking_max_ooo)

  validate_bool($output_syslog_enabled)
  validate_integer($output_syslog_attempts)
  validate_string($output_syslog_network)
  $valid_socket_types = [
    'tcp', 'tcp4', 'tcp6', 'udp', 'udp4', 'udp6', 'ip',
    'ip4', 'ip6', 'unix', 'unixgram', 'unixpacket',
  ]
  if ! ($output_syslog_network in $valid_socket_types) {
    fail(
      sprintf('output_syslog_network must be one of %s',
        join($valid_socket_types, ', ')
      )
    )
  }
  validate_string($output_syslog_address)
  validate_integer($output_syslog_priority)
  validate_string($output_syslog_tag)

  validate_bool($output_file_enabled)
  validate_integer($output_file_attempts)
  validate_absolute_path($output_file_path)
  validate_string($output_file_mode)
  validate_string($output_file_user)
  validate_string($output_file_group)

  validate_integer($log_flags)

  $valid_auto_enable_rule_values = [
    'none', 'disable', 'enable', 'lock'
  ]
  if ! ($auto_enable_rule in $valid_auto_enable_rule_values) {
    fail(
      sprintf('auto_enable_rule must be one of %s',
        join($valid_auto_enable_rule_values, ', ')
      )
    )
  }

  anchor { 'goaudit::begin': } ->
  class { '::goaudit::install': } ->
  class { '::goaudit::config': } ~>
  class { '::goaudit::service': } ->
  anchor { 'goaudit::end': }

}
