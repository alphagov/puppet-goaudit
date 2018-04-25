# See README.md
class goaudit (
  String $package_name = $goaudit::params::package_name,
  String $package_ensure = $goaudit::params::package_ensure,
  Pattern[/^\//] $config_file = $goaudit::params::config_file,
  String $service_name = $goaudit::params::service_name,
  $service_enable = $goaudit::params::service_enable,
  String $service_ensure = $goaudit::params::service_ensure,
  Integer $events_min = $goaudit::params::events_min,
  Integer $events_max = $goaudit::params::events_max,
  Boolean $message_tracking_enabled = $goaudit::params::message_tracking_enabled,
  Boolean $message_tracking_log_ooo = $goaudit::params::message_tracking_log_ooo,
  Integer $message_tracking_max_ooo = $goaudit::params::message_tracking_max_ooo,
  $output_stdout_enabled = $goaudit::params::output_stdout_enabled,
  $output_stdout_attempts = $goaudit::params::output_stdout_attempts,
  Boolean $output_syslog_enabled = $goaudit::params::output_syslog_enabled,
  Integer $output_syslog_attempts = $goaudit::params::output_syslog_attempts,
  Enum['tcp', 'tcp4', 'tcp6', 'udp', 'udp4', 'udp6', 'ip', 'ip4', 'ip6', 'unix', 'unixgram', 'unixpacket'] $output_syslog_network = $goaudit::params::output_syslog_network,
  String $output_syslog_address = $goaudit::params::output_syslog_address,
  Integer $output_syslog_priority = $goaudit::params::output_syslog_priority,
  String $output_syslog_tag = $goaudit::params::output_syslog_tag,
  Boolean $output_file_enabled = $goaudit::params::output_file_enabled,
  Integer $output_file_attempts = $goaudit::params::output_file_attempts,
  Pattern[/^\//] $output_file_path = $goaudit::params::output_file_path,
  String $output_file_mode = $goaudit::params::output_file_mode,
  String $output_file_user = $goaudit::params::output_file_user,
  String $output_file_group = $goaudit::params::output_file_group,
  Integer $log_flags = $goaudit::params::log_flags,
  Enum['none', 'disable', 'enable', 'lock'] $auto_enable_rule = $goaudit::params::auto_enable_rule,
) inherits goaudit::params {
  contain ::goaudit::install
  contain ::goaudit::config
  contain ::goaudit::service

  Class['::goaudit::install'] -> Class['::goaudit::config'] ~> Class['::goaudit::service']
}
