# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   vim::config { 'namevar': }
define vim::config(
  String $owner,
  Optional[String] $content = epp('vim/pathogen_vimrc.epp'),
  Enum['present', 'absent'] $ensure = 'present',
  String $group = $owner,
  String $path = $name,
) {
  file { $path:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => '0640',
    content => $content,
  }
}
