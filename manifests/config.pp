# Private class
class goaudit::config {

  file { $::goaudit::config_file :
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('goaudit/go-audit.yaml.erb'),
  }

}

