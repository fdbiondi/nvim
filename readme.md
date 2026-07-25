# Neovim

Personal Neovim configuration managed as a Stow package.

## Requirements

- Neovim >= 0.12
- `git`
- `ripgrep`
- GNU Stow
- `tree-sitter-cli`

## Installation

Run Stow from the parent directory of this repository:

```bash
stow nvim
```

`lazy.nvim` is bootstrapped automatically on the first launch. Plugins and
language parsers may require network access during initial setup.

## Treesitter

Parsers are configured in `lua/plugins/nvim-treesitter.lua`. Update them with:

```vim
:TSUpdate
```

The configuration includes local Markdown and Bash injection-query overrides
for Neovim 0.12. They avoid a `range()` error caused by incompatible capture
node handling in Treesitter directives. Do not remove those overrides unless
the related upstream compatibility issue has been resolved.

For diagnostics, use:

```vim
:checkhealth nvim-treesitter
```
