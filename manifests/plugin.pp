# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   vim::plugin { 'namevar': }
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
  $path = "${vim_dir}/plugin/${plugin_name}"
  $autoload_path = "${vim_dir}/autoload/${plugin_name}"

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
