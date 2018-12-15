# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include vim
class vim {
  include ::vim::install
  include ::vim::configure

  Class['vim::install'] -> Class['vim::configure']
}
