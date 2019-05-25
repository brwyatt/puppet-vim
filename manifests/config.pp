# @summary
#   Manage a user's vim configuration.
#
# @example
#   vim::config { '/home/brwyatt':
#     ensure => present,
#     owner  => 'brwyatt',
#   }
#
# @param owner
#   Username of the owner of the configs.
# @param vimrc_template
#   Template file/path used to generate the user's `.vimrc`.
# @param vimrc_params
#   Template params to pass to the template indicated by `$vimrc_template`.
# @param ensure
#   Resource ensure.
# @param group
#   Name of the group that owns the configs.
# @param path
#   The path to the directory containing the configs. This should be the parent
#   directory that the `.vimrc` and `.vim` directory should be created.
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

  file { "${path}/.vim/.netrwhist":
    ensure  => $file_ensure,
    mode    => '0664',
    replace => no,
  }

  file { "${path}/.vimrc":
    ensure  => $file_ensure,
    mode    => '0640',
    content => epp($vimrc_template, $vimrc_params),
  }
}
