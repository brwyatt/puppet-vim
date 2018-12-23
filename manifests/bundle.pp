# @summary
#   Install Pathogen/vim plugin bundles.
#
# @example Install Puppet bundle from GitHub
#   vim::bundle { 'puppet':
#     ensure   => present,
#     owner    => 'brwyatt',
#     repo     => 'https://github.com/voxpupuli/vim-puppet.git',
#     revision => 'master',
#     vim_dir  => '/home/brwyatt/.vim',
#   }
#
# @param owner
#   The username of the owner of this bundle's files.
# @param repo
#   URL/Path to the repo source for the bundle.
# @param vim_dir
#   Path to the user's `.vim` directory containing the `bundles` directory.
# @param bundle_name
#   The bundle's name.
# @param ensure
#   Resource ensure value.
# @param group
#   Group name for bundle's permissions.
# @param provider
#   The provider value to pass to `vcsrepo`. Can be any valid provider accepted by `vcsrepo`.
# @param revision
#   Repository revision to checkout.
define vim::bundle(
  String $owner,
  String $repo,
  String $vim_dir,
  String $bundle_name = $name,
  Enum['present', 'absent'] $ensure = 'present',
  String $group = $owner,
  String $provider = 'git',
  String $revision = 'master',
) {
  $path = "${vim_dir}/bundle/${bundle_name}"

  $dir_ensure = $ensure ? {
    'present' => directory,
    'absent'  => absent,
  }

  $vcs_ensure = $ensure ? {
    'present' => latest,
    'absent'  => absent,
  }

  file { $path:
    ensure => $dir_ensure,
    owner  => $owner,
    group  => $group,
    mode   => '0775',
    before => Vcsrepo["vim bundle: ${path}"],
  }

  vcsrepo { "vim bundle: ${path}":
    ensure   => $vcs_ensure,
    path     => $path,
    provider => $provider,
    owner    => $owner,
    group    => $group,
    source   => $repo,
    revision => $revision,
  }

  if $provider == 'git' {
    include ::git
    Class['git'] -> Vcsrepo["vim bundle: ${path}"]
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
