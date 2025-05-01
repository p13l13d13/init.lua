# My NVIM Configuration

A modern Neovim configuration focused on productivity and developer experience.

## Requirements

- Neovim 0.10 or higher
- Git
- A terminal with true color support
- Basic Unix tools (curl, tar, etc.)

## Installation

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

2. Run the link script to set up the configuration:
   ```bash
   ./link.sh
   ```

3. Start Neovim and install plugins:
   ```bash
   nvim
   :Lazy
   ```

## Features

- Plugin management with Lazy.nvim
- Keybindings management with Legendary
- Modern UI with various visual enhancements
- Language server support
- Git integration
- File navigation and management
- Terminal integration

## Key Commands

- `:Lazy` - Manage plugins
- `:Legendary` - View and search keybindings
- `:LspInfo` - Check LSP status
- `:Mason` - Manage LSP servers and tools

## Configuration

The configuration is split into several modules:
- `lua/` - Core configuration and plugin setups
- `after/` - Overrides and additional configurations

## Troubleshooting

If you encounter any issues:
1. Make sure you have the required Neovim version
2. Run `:Lazy sync` to ensure all plugins are properly installed
3. Check the Neovim logs with `:messages`