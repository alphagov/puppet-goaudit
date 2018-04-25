# Private class
class goaudit::config {

  datacat_fragment { 'goaudit_config_main':
    target => $::goaudit::config_file,
    data   => {
      'main'   => {
        'events'           => {
          'min' => $::goaudit::events_min,
          'max' => $::goaudit::events_max,
        },
        'message_tracking' => {
          'enabled'          => $::goaudit::message_tracking_enabled,
          'log_out_of_order' => $::goaudit::message_tracking_log_ooo,
          'max_out_of_order' => $::goaudit::message_tracking_max_ooo,
        },
        'output'           => {
          'stdout' => {
            'enabled'  => $::goaudit::output_stdout_enabled,
            'attempts' => $::goaudit::output_stdout_attempts,
          },
          'syslog' => {
            'enabled'  => $::goaudit::output_syslog_enabled,
            'attempts' => $::goaudit::output_syslog_attempts,
            'network'  => $::goaudit::output_syslog_network,
            'address'  => $::goaudit::output_syslog_address,
            'priority' => $::goaudit::output_syslog_priority,
            'tag'      => $::goaudit::output_syslog_tag,
          },
          'file'   => {
            'enabled'  => $::goaudit::output_file_enabled,
            'attempts' => $::goaudit::output_file_attempts,
            'path'     => $::goaudit::output_file_path,
            'mode'     => $::goaudit::output_file_mode,
            'user'     => $::goaudit::output_file_user,
            'group'    => $::goaudit::output_file_group,
          },
        },
        'log'              => {
          'flags' => $::goaudit::log_flags,
        },
      },
    },
  }

  if ($::goaudit::auto_enable_rule != 'none') {
    datacat_fragment { 'go-audit audit enable rule':
      target => $::goaudit::config_file,
      data   => {
        'enable_rule' => $::goaudit::auto_enable_rule,
      },
    }
  }

  datacat { $::goaudit::config_file:
    ensure   => 'file',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    template => 'goaudit/go-audit.yaml.erb',
  }

}

