# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   vim::config { 'namevar': }
define vim::config(
  String $owner,
  String $vimrc_template = 'vim/pathogen_vimrc.epp',
  Hash $vimrc_params = {},
  Enum['present', 'absent'] $ensure = 'present',
  String $group = $owner,
  String $path = $name,
) {
  File {
    owner   => $owner,
    group   => $group,
    purge   => true,
    recurse => true,
    force   => true,
  }

  $dir_ensure = $ensure ? {
    'present' => directory,
    'absent'  => absent,
  }

  $file_ensure = $ensure ? {
    'present' => file,
    'absent'  => absent,
  }

  file { "${path}/.vim":
    ensure => $dir_ensure,
    mode   => '0700',
  }
  file { "${path}/.vim/autoload":
    ensure => $dir_ensure,
    mode   => '0775',
  }
  file { "${path}/.vim/bundle":
    ensure => $dir_ensure,
    mode   => '0775',
  }
  file { "${path}/.vim/plugin":
    ensure => $dir_ensure,
    mode   => '0775',
  }

  file { "${path}/.vimrc":
    ensure => $file_ensure,
    mode    => '0640',
    content => epp($vimrc_template, $vimrc_params),
  }
}
