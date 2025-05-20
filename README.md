# NvChad Configuration

**This repo contains a customized configuration for NvChad v3.0!**

## Setup Information

- This uses NvChad as a base with custom configurations
- NvChad modules are imported (e.g., `require "nvchad.options"`, `require "nvchad.mappings"`)
- You can delete the .git directory from this repo when cloning locally or fork it

## Features

- Improved C/C++ development with enhanced clangd configuration
- Well-organized keymaps for common operations
- Transparent UI elements with consistent styling
- TypeScript/JavaScript development optimizations
- File browsing with Oil.nvim

## Key Mappings

### General

- Space (leader) + ff: Find files
- Space + fg: Live grep (search)
- Space + fb: Browse buffers
- Space + w: Save file

### LSP & C/C++ Development

- gd: Go to definition
- K: Show documentation hover
- Space + ch: Switch between header/source files
- Space + ct: Show type hierarchy
- Space + cr: Find all references
- Space + cc: Show callers

### File Browser

- Ctrl+e: Open Oil file browser
- Space + ee: Open Oil in floating window

## Credits

1. Based on [NvChad](https://github.com/NvChad/NvChad)
2. Inspired by [LazyVim starter](https://github.com/LazyVim/starter)
