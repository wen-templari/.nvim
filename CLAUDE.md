# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration using Lazy.nvim as the plugin manager. The configuration is structured as follows:

- `init.vim` - Main entry point with basic Vim settings and loads Lua configuration
- `lua/main.lua` - Lazy.nvim setup and plugin loading orchestration
- `lua/shortcuts.lua` - All key mappings and shortcuts
- `lua/plugins/` - Modular plugin configurations:
  - `theme.lua` - Themery theme switcher with onedarkpro and quietlight themes
  - `theme_persist.lua` - Persists theme selection across sessions
  - `lsp.lua` - LSP configuration with lsp-zero, Mason, and nvim-cmp
  - `editor.lua` - Editor enhancements (autopairs, surround, comments, etc.)
  - `ui.lua` - UI components (lualine, nvim-tree)
  - `project.lua` - Project management plugins
  - `git.lua` - Git integration plugins
  - `nvim-treesitter.lua` - Treesitter configuration

## Plugin Management

Uses Lazy.nvim for plugin management. Plugin configurations are loaded from `lua/plugins/` directory in this order:
1. Theme (loaded first to allow overrides)
2. Editor enhancements
3. Project management
4. UI components
5. LSP configuration
6. Treesitter
7. Git tools

Lock file: `lazy-lock.json` contains exact plugin versions.

## Key Language Support

Configured LSP servers via Mason:
- `lua_ls` - Lua Language Server (for Neovim configuration)
- `gopls` - Go Language Server

## Theme System

Uses Themery for theme switching between:
- "Day" mode (quietlight colorscheme)
- "Night" mode (onedark colorscheme)

Theme selection persists via `theme_persist.lua`.

## Key Mappings

Leader key: `<Space>`

Essential shortcuts:
- `<leader>ff` - Telescope find files
- `<leader>fg` - Telescope live grep
- `<leader>tt` - Toggle nvim-tree
- `<leader>tm` - Toggle terminal (vertical)
- `<leader>tb` - Toggle git blame
- `<leader>gf` - Format code with LSP
- `gd` - Go to definition
- `gh` - Show hover information
- `gr` - Show references
- `<leader>rn` - Rename symbol

## Development Commands

This is a Neovim configuration, not a software project. Common operations:

- Install/update plugins: `:Lazy sync` in Neovim
- Check plugin status: `:Lazy` in Neovim
- LSP server management: `:Mason` in Neovim
- Theme switching: `:Themery` in Neovim

## Configuration Editing

When editing this configuration:
- Test changes by reloading Neovim or using `:source %`
- Plugin changes may require `:Lazy sync`
- LSP changes may require `:LspRestart`
- Theme changes can be tested with `:Themery`

## File Organization

- Core settings: `init.vim`
- Plugin orchestration: `lua/main.lua`
- Keybindings: `lua/shortcuts.lua`  
- Plugin configs: `lua/plugins/*.lua` (one concern per file)
- Plugin versions: `lazy-lock.json` (managed by Lazy.nvim)