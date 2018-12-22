# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include vim::install
class vim::install (
  String $package_ensure,
  String $package_name,
){
  package { 'vim':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if defined(Exec['apt_update']) {
    Exec['apt_update'] -> Package['vim']
  }
}
