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
  # directory to collect themes into
  # NOTE: This path should be controlled by the STATIC_ROOT parameter in
  # `local_settings.py` instead. Remove this when upstream allows to change
  # the config option.
#  $collection_dir = '/var/lib/openstack-dashboard/static'

  file { $theme_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
    source  => "puppet:///modules/branding",
    require => Package['horizon'],
#  } ->
  }

#  file { "${collection_dir}/themes/datacentred":
#    ensure  => link,
#    target  => $theme_dir,
#    require => Package['horizon'],
#  }

#  File[$theme_dir] -> Exec[refresh_horizon_django_compress]

}
