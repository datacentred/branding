# == Class: branding::horizon
#
# Apply DataCentred branding to Horizon
#
# === Parameters
#
# [*horizon_dir*]
#   The main directory where Horizon is installed.
#
class branding::horizon (
  $horizon_dir = '/usr/share/openstack-dashboard/openstack_dashboard'
) {

  # directory where the theme will be stored
  $theme_dir = "${horizon_dir}/themes/datacentred"

  file { $theme_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
    source  => "puppet:///modules/branding",
    require => Concat[$::horizon::params::config_file],
  }

  # trigger asset collection and compression after getting the theme
  File[$theme_dir] ~> Exec['refresh_horizon_django_cache'] -> Exec['refresh_horizon_django_compress']

}
