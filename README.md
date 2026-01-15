# Neovim Configuration

Personal Neovim setup for daily coding.

## Requirements

- git
- neovim

## Installation

```bash
git clone https://github.com/adonamarkkevin/lazy-vim-config.git --depth 1 ~/.config/nvim
```

If using [dotfiles](https://github.com/adonamarkkevin/dotfiles.git), Stow handles installation automatically.

## Features

- **Plugin Manager**: lazy.nvim
- **LSP Support**: TypeScript, Go, HTML, Lua, SQL
- **Autocompletion**: nvim-cmp with LuaSnip
- **Fuzzy Finder**: Telescope (files, grep, recent files)
- **Syntax Highlighting**: Treesitter
- **Formatting**: Auto-format on save (stylua, prettier)
- **File Explorer**: Oil.nvim
- **Git Integration**: Gitsigns
- **AI Assist**: Avante, Copilot

## Keymaps

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader><leader>` | Recent files |
| `K` | Hover docs |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>ca` | Code actions |

## Structure

```
├── init.lua           # Entry point, bootstraps lazy.nvim
├── lua/
│   ├── editor.lua     # Editor settings
│   ├── remap.lua      # Global keymaps
│   ├── lsp_diagnostics.lua
│   └── plugins/       # Plugin configs (one file per plugin)
```

## Adding Plugins

Create a new file in `lua/plugins/` following lazy.nvim format. It loads automatically.
