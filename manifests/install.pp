# Private class
class goaudit::install {
  package { $::goaudit::package_name:
    ensure => $::goaudit::package_ensure,
  }
}

