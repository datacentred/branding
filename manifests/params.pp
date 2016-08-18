# Class: branding::params
#
class branding::params {

  case $::osfamily {
    'RedHat': {
      $http_service = 'httpd'
    }
    'Debian': {
      $http_service = 'apache2'
    }
    default: {}
  }

}
