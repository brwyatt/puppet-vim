# @summary
#   Installs the vim package. It is not recommended to use this class directly.
#
# @example
#   include vim::install
#
# @param package_ensure
#   Ensure to pass to the package resource.
# @param package_name
#   Vim package name for the package resource.
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
