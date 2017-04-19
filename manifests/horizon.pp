# == Class: branding::horizon
#
# Apply DataCentred branding to Horizon
#
# === Parameters
#
# [*release*]
#   Openstack release name.  Dictates the plugin version to install.
#
# === Notes
#
# Compatible with OpenStack Kilo or greater
#
class branding::horizon (
  $release = 'mitaka',
) {

  $horizon_dir = '/var/lib/openstack-dashboard'
  $theme_dir = '/usr/share/openstack-dashboard-datacentred-theme'

  file { $theme_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
    source  => "puppet:///modules/branding/horizon-${release}",
  } ->

  file { "${horizon_dir}/static/themes/datacentred":
    ensure  => link,
    target  => $theme_dir,
    require => Package['horizon'],
  }

  file { "${horizon_dir}/themes/datacentred":
    ensure  => link,
    target  => $theme_dir,
    require => Package['horizon'],
  }

  File[$theme_dir] -> Exec[refresh_horizon_django_compress]

}
