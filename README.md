# Summary

I use this as my daily driver for work and everything else. The FULL setup that I use is actually neovide + nvim + firenvim (with firefox).

## Requirements

- Neovim 0.10 or higher
- git, curl, make
- Modern terminal (I use alacritty)

## Installation

1. Clone this repository.
   ```

2. Run the link script to set up the configuration:
   ```bash
   ./install.sh
   ```

3. Start Neovim and install plugins:
   ```bash
   nvim
   :Lazy
   ```

## Features

- Plugin management with Lazy.nvim
- Keybindings management with Legendary
- File navigation with Oil.nvim (to modify filesystem as text)
* Firenvim, so a man can have full scale neovim instance right in a browser
* Some modern AI integrations (of course with an agent mode)
* Heavy usage of label-highlighted jumping

## Key Commands

- `:Lazy` - Manage plugins
- `:Legendary` - View and search keybindings
- `:LspInfo` - Check LSP status

## Configuration

The configuration is split into several modules:
- `lua/` - Core configuration and plugin setups
- `after/` - Overrides and additional configurations
