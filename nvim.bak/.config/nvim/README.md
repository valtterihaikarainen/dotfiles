# Neovim Configuration

My personal Neovim configuration with LSP support for multiple languages including C/C++, Python, and TypeScript.

## Prerequisites

Before installing this configuration, ensure you have the following dependencies installed:

### Required Dependencies
- Neovim (v0.8 or later)
- git
- A C compiler (clang or gcc)
- Node.js (for LSP servers)
- ripgrep (for Telescope fuzzy finder)

### Installation Commands

#### macOS (using Homebrew):
```bash
# Install Neovim
brew install neovim

# Install other dependencies
brew install git
brew install ripgrep
brew install node

# clang is usually pre-installed on macOS
```

#### Ubuntu/Debian:
```bash
# Install Neovim (using AppImage or PPA recommended for latest version)
# Install other dependencies
sudo apt update
sudo apt install git
sudo apt install ripgrep
sudo apt install nodejs npm
sudo apt install build-essential  # For C compiler
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/valtterihaikarainen/neovim-configuration.git ~/.config/nvim
```

2. Start Neovim:
```bash
nvim
```

The first time you start Neovim, it will:
- Install lazy.nvim (package manager)
- Install all configured plugins
- Set up LSP servers

## Features

- LSP support for multiple languages
- Fuzzy finding with Telescope
- File explorer with nvim-tree
- Auto-completion
- Git integration
- Automatic session management
- Markdown preview
- Modern theme with Catppuccin

## Updating

To update your configuration with the latest changes:

```bash
cd ~/.config/nvim
git pull
```

## Key Features and Bindings

### LSP Features
- Code completion (triggered automatically)
- Go to definition: `gd`
- Find references: `gr`
- Hover documentation: `K`
- Code actions: `<leader>ca`
- Rename symbol: `<leader>rn`

### Completion Navigation
- Show completion suggestions: `<Ctrl-Space>`
- Navigate through suggestions: `<Tab>` and `<Shift-Tab>`
- Accept suggestion: `<Enter>`
- Scroll documentation: `<Ctrl-u>` and `<Ctrl-d>`

