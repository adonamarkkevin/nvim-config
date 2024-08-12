# Neovim Configuration

## Description

This my vim setup for my day to day coding.

## Requirement

- git
- neovim

## Installation

```
git clone https://github.com/adonamarkkevin/lazy-vim-config.git --depth 1
.config/nvim
```

Note: if this [dotfiles](https://github.com/adonamarkkevin/dotfiles.git) is use
no need to install. Stow will handle the installation

## Customization

- [init.lua](./init.lua)
  - lazy.nvim is installed
  - vim options
- [remap.lua](./lua/remap.lua)
  - remap vim key
- [./lua/plugins/](./lua/plugins/)
  - plugins are installed here
  - if you want to add new plugin, just create a file on this directory and
    follow the format of the other files. If plugin(s) needs remapping write it
    the same plugin file.
