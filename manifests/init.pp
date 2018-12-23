# @summary
#   Installs and configures the vim package.
#
# @example
#   include vim
class vim {
  include ::vim::install
  include ::vim::configure

  Class['vim::install'] -> Class['vim::configure']
}
