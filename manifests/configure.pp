# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include vim::configure
class vim::configure {
  # No global configs, but we can realize user configs here
  Vim::Config <| |>
  -> Vim::Plugin <| |>
  -> Vim::Bundle <| |>
}
