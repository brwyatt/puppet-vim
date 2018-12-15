# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   vim::bundle { 'namevar': }
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

  file { $path:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0775',
    before => Vcsrepo["vim bundle: ${path}"],
  }

  vcsrepo { "vim bundle: ${path}":
    ensure   => latest,
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
