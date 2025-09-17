# Neovim Configuration

A modern Neovim configuration using Lazy.nvim plugin manager with a focus on productivity and aesthetics.

## Features

- **Package Manager**: Lazy.nvim for fast plugin loading
- **Colorscheme**: Tokyo Night with custom colors
- **File Explorer**: Nvim-tree with git integration
- **Fuzzy Finder**: Telescope with live grep
- **Syntax Highlighting**: Treesitter with multiple language support
- **Status Line**: Lualine with custom theme
- **Session Management**: Auto-session for workspace persistence
- **Markdown Support**: Preview and Marp presentation support

## Plugins

### Core Plugins
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Lua utility functions
- **vim-tmux-navigator** - Seamless tmux/vim navigation

### UI & Appearance
- **tokyonight.nvim** - Tokyo Night colorscheme with custom colors
- **lualine.nvim** - Customizable status line
- **bufferline.nvim** - Buffer/tab line with slant separators
- **alpha-nvim** - Start screen with custom ASCII art
- **dressing.nvim** - Better UI for vim.ui interfaces
- **nvim-web-devicons** - File type icons

### File Management & Navigation
- **nvim-tree.lua** - File explorer with git integration
- **telescope.nvim** - Fuzzy finder for files, grep, and more
- **telescope-fzf-native.nvim** - FZF sorter for telescope

### Code Features
- **nvim-treesitter** - Syntax highlighting and code parsing
- **nvim-ts-autotag** - Auto close/rename HTML tags
- **which-key.nvim** - Keybinding hints

### Productivity
- **auto-session** - Session management
- **vim-maximizer** - Maximize/minimize splits
- **markdown-preview.nvim** - Live markdown preview
- **marp-nvim** - Marp presentation support

## Key Bindings

### Leader Key
- Leader key is set to `<Space>`

### General
- `jk` - Exit insert mode
- `<leader>nh` - Clear search highlights
- `<leader>+` / `<leader>-` - Increment/decrement numbers

### Window Management
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split
- `<leader>sm` - Maximize/minimize split

### Tab Management
- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` / `<leader>tp` - Navigate tabs
- `<leader>tf` - Open current buffer in new tab

### File Explorer (Nvim-tree)
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Toggle file explorer on current file
- `<leader>ec` - Collapse file explorer
- `<leader>er` - Refresh file explorer

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files in current directory
- `<leader>fr` - Find recent files
- `<leader>fs` - Live grep (search in files)
- `<leader>fc` - Find string under cursor

### Session Management
- `<leader>wr` - Restore session for current directory
- `<leader>ws` - Save session

### Markdown
- `<leader>p` - Toggle markdown preview
- `<leader>mt` - Toggle Marp
- `<leader>ms` - Marp status

### Treesitter
- `<C-space>` - Init/increment selection
- `<bs>` - Decrement selection

## Configuration Structure

```
lua/gusdesouza/
├── core/
│   ├── init.lua          # Core module loader
│   ├── keymaps.lua       # Key mappings
│   └── options.lua       # Vim options
├── plugins/
│   ├── init.lua          # Basic plugins
│   ├── alpha.lua         # Start screen
│   ├── auto-session.lua  # Session management
│   ├── bufferline.lua    # Buffer line
│   ├── colorscheme.lua   # Color scheme
│   ├── dressing.lua      # UI improvements
│   ├── lualine.lua       # Status line
│   ├── markdown-preview.lua # Markdown preview
│   ├── marp-nvim.lua     # Marp presentations
│   ├── nvim-tree.lua     # File explorer
│   ├── telescope.lua     # Fuzzy finder
│   ├── treesitter.lua    # Syntax highlighting
│   ├── vim-maximizer.lua # Split maximizer
│   └── which-key.lua     # Key hints
└── lazy.lua              # Plugin manager setup
```

## Installation

1. Backup your existing Neovim configuration
2. Clone this repository to your Neovim config directory:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```
3. Start Neovim - Lazy.nvim will automatically install all plugins
4. Restart Neovim to ensure all plugins are properly loaded

## Requirements

- Neovim >= 0.8.0
- Git
- Node.js and yarn (for markdown-preview)
- A Nerd Font for proper icons display
- Ripgrep for telescope live_grep functionality