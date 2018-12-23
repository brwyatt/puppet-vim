# @summary
#   Install a vim pugin.
#
# @example
#   vim::plugin { 'pathogen':
#     owner    => 'brwyatt',
#     autoload => true,
#     source   =>
#       'https://raw.githubusercontent.com/tpope/vim-pathogen/v2.4/autoload/pathogen.vim',
#     vim_dir  => '/home/brwyatt/.vim',
#   }
#
# @param owner
#   The username of the owner of this plugin.
# @param vim_dir
#   Path to the user's `.vim` directory containing the `plugin` and `autoload` directories.
# @param autoload
#   Controls if this plugin should be symlinked from the `autoload` directory.
# @param plugin_name
#   The plugin's name. `.vim` will be appended to this name if not included.
# @param ensure
#   Resource ensure value.
# @param group
#   Group name for plugin's permissions.
# @param content
#   Content of the plugin file. Mutually exclusive with `$source`.
# @param source
#   Source location of the plugin file. Mutually exclusive with `$content`.
#   Note: if source is an http/https URL, `$content` is ignored completely without error.
define vim::plugin(
  String $owner,
  String $vim_dir,
  Boolean $autoload = false,
  String $plugin_name = $name,
  Enum['present', 'absent'] $ensure = 'present',
  String $group = $owner,
  Optional[String] $content = undef,
  Optional[String] $source = undef,
) {
  if $plugin_name =~ /\.vim$/ {
    $_plugin_name = $plugin_name
  } else {
    $_plugin_name = "${plugin_name}.vim"
  }
  $path = "${vim_dir}/plugin/${_plugin_name}"
  $autoload_path = "${vim_dir}/autoload/${_plugin_name}"

  $remote_file_ensure = $ensure ? {
    'present' => present,
    'absent'  => absent,
  }

  $file_ensure = $ensure ? {
    'present' => file,
    'absent'  => absent,
  }

  $link_ensure = $ensure ? {
    'present' => link,
    'absent'  => absent,
  }

  if $source and $source =~ /^https?:\/\// {
    remote_file { $path:
      ensure => $remote_file_ensure,
      source => $source,
      owner  => $owner,
      group  => $group,
      mode   => '0640',
    }
  } else {
    file { $path:
      ensure  => $file_ensure,
      owner   => $owner,
      group   => $group,
      source  => $source,
      content => $content,
      mode    => '0640',
    }
  }

  if $autoload {
    file { $autoload_path:
      ensure => $link_ensure,
      target => $path,
      owner  => $owner,
      group  => $group,
      mode   => '0777',
    }
  }
}
