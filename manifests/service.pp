# Private class
class goaudit::service {

  service { $::goaudit::service_name :
    ensure => $::goaudit::service_ensure,
    enable => $::goaudit::service_enable,
  }

}

