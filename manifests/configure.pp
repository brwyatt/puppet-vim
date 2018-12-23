# @summary
#   Global vim configuration. Realizes all virtual user configs and sets up resource order. It is not recommended to include this directly.
#
# @example
#   include vim::configure
class vim::configure {
  # No global configs, but we can realize user configs here
  Vim::Config <| |>
  -> Vim::Plugin <| |>
  -> Vim::Bundle <| |>
}
