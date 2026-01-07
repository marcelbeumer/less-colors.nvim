# less-colors

Neovim plugin to remove colors from syntax highlighting. Some languages are
beautiful as they are without colors (like Go).

Because simply turning off vim and treesitter syntax highlighting sometimes
caused issues with other plugins this plugin maps highlight groups back to
"Normal". This way all bells and whistles can stay enabled including non-syntax
colors of a colorscheme.

## TODO

Currently works on default colorscheme. Needs more mapping to de-colorize
colorschemes that use more highlight groups, which is most modern colorscheme
plugins.

## Usage

```lua
vim.pack.add({ -- or other plugin manager
  "https://github.com/marcelbeumer/less-colors.nvim",
})

require('less-colors').setup() -- use default config
-- OR
require('less-colors').setup({ -- override defaults
  enabled = true, -- general enable/disable
  enable_command = "LessColors",
  disable_command = "MoreColors",
  toggle_command = "LessColorsToggle",
  commands = true, -- add commands during setup
  autocmd = false, -- automatically re-apply on colorscheme change
})
```

See [helpfile](./doc/less-colors.txt) for more detail.
