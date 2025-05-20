# Neovim Configuration

A modern Neovim configuration for efficient development.

## 🌟 Features

### 🛠️ Development Tools

- **LSP Integration** (`nvim-lspconfig`)

  - Code completion, diagnostics, and hover information
  - Configured for multiple languages

- **Autocompletion** (`nvim-cmp`)

  - Intelligent code suggestions from multiple sources (LSP, buffer, path)
  - Snippet integration with LuaSnip

- **Syntax Highlighting** (`nvim-treesitter`)

  - Advanced syntax highlighting for multiple languages
  - Code folding and indentation based on language structure

- **Code Formatting** (`conform.nvim`)

  - On-demand code formatting
  - Configured for multiple languages

- **TypeScript Tools** (`typescript.nvim`, `format-ts-errors.nvim`)

  - TypeScript-specific features and error formatting
  - Import management, file renaming, and unused variable removal

- **Auto Tagging** (`nvim-ts-autotag`)

  - Automatically closes and renames HTML/JSX tags

- **LSP UI Enhancement** (`lspsaga.nvim`)
  - Improved UI for code actions, definitions, and references

### 📝 Editing Features

- **Auto Save** (`auto-save.nvim`)

  - Automatically saves files after edits with zero notifications
  - Configurable delay (5000ms)
  - Completely silent operation - focus on your code, not save messages

- **Code Commenting** (`Comment.nvim`)

  - Toggle comments with `gcc` (line) or `gc` (selection)

- **Snippets** (`LuaSnip`, `friendly-snippets`)

  - Code snippets for faster development
  - Includes snippets for multiple languages

- **Terminal Integration** (`toggleterm.nvim`)
  - Toggle terminal with a keybinding
  - Multiple terminal instances

### 🔍 Navigation

- **Fuzzy Finder** (`telescope.nvim`)

  - Quick file navigation, text search, and more
  - Keybindings: `<leader>ff` (find files), `<leader>fg` (grep), `<leader>fb` (buffers)
  - Features extremely fast filtering with fzf integration
  - Supports advanced sorting and preview capabilities

- **File Explorer** (`oil.nvim`)

  - Navigate and edit files in a traditional file manager interface
  - Allows file operations directly from Neovim
  - Integrates with LSP for rename operations
  - Automatically refreshes on file system changes

- **File Bookmarks** (`harpoon`)

  - Quickly jump between frequently used files
  - Keybindings: `<leader>ha` (add), `<leader>hh` (menu), `<leader>h1/2/3` (jump)
  - Persistent across sessions
  - Enables blazing-fast workflow by minimizing context switching

- **Fast Navigation** (`leap.nvim`)
  - Jump to any visible text with minimal keystrokes using 2-character search
  - More efficient than traditional search
  - Works across windows and splits for entire viewport navigation

### 🔧 Git Integration

- **Git Signs** (`gitsigns.nvim`)

  - Shows git changes in the sign column
  - Line blame and chunk navigation
  - Interactive staging/unstaging of hunks directly in buffer
  - Diff preview with floating windows

- **Search and Replace** (`nvim-spectre`)
  - Project-wide search and replace with live preview
  - Supports regex pattern matching
  - Keybindings: `<leader>S` (toggle), `<leader>sw` (search word)
  - Integrates with plenary for better performance

### 📊 UI Enhancements

- **Enhanced Tabline** (`bufferline.nvim`)

  - Stylish and functional tabs/buffers display with slant separators
  - Ordinal numbering for quick buffer jumping
  - Integrated diagnostics indicators
  - Custom hover actions and close buttons
  - Color-coded by filetype and modification status
  - Buffer groups and smart sorting
  - Diagnostic integration to show errors/warnings in tabs

- **Status Line** (`lualine.nvim`)

  - Beautiful and informative status line
  - Shows mode, file info, git info, and diagnostics
  - Fully customizable sections and components
  - Integrates with existing plugins to show relevant information

- **Notifications** (`nvim-notify`, `noice.nvim`)

  - Aesthetically pleasing notifications
  - Command feedback and search results

- **File Icons** (`nvim-web-devicons`)

  - Adds file type icons throughout the UI

- **TODO Comments** (`todo-comments.nvim`)

  - Highlights and makes TODOs searchable
  - Keybinding: `<leader>ft` (find TODOs)

- **Terminal Transparency**
  - Configurable transparency for a beautiful UI
  - Works with terminal background blur

### 📚 Additional Features

- **Keybinding Help** (`which-key.nvim`)

  - Shows available keybindings as you type
  - Makes discovering commands easier

- **Session Management** (`persistence.nvim`)

  - Automatically saves and restores sessions
  - Keybindings: `<leader>qs` (restore), `<leader>ql` (last), `<leader>qd` (don't save)

- **Markdown Rendering** (`render-markdown.nvim`)

  - Improved Markdown preview and editing

- **Diagnostic Display** (`trouble.nvim`)
  - Better view of diagnostics and problems
  - Keybindings: `<leader>xx` (document), `<leader>xX` (workspace)

## 🚀 Usage

### LSP Features

- Get hover information: Move cursor over symbol
- Go to definition: `gd`
- Find references: `gr`
- Code actions: `<leader>ca`
- Rename symbol: `<leader>rn`

### Completion

- Trigger completion: `<C-Space>`
- Accept suggestion: `<CR>`
- Navigate suggestions: `<Tab>` and `<S-Tab>`

### Navigation

- File finder: `<leader>ff`
- Text search: `<leader>fg`
- Buffer list: `<leader>fb`
- Help tags: `<leader>fh`

### Editing

- Toggle comment: `gcc` (line), `gc` (visual selection)
- Auto format: (on save if enabled)
- Add file to harpoon: `<leader>ha`
- Toggle harpoon menu: `<leader>hh`

### Git

- Navigate changes: `]c` and `[c`
- Stage hunk: `<leader>hs`
- Preview hunk: `<leader>hp`
- Reset hunk: `<leader>hr`

### UI

- Toggle file explorer: `:Oil`
- Toggle diagnostics list: `<leader>xx`
- Toggle terminal: `:ToggleTerm`

## ⚙️ Installation

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

1. Clone this repository to your Neovim config directory:

   ```bash
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

2. Start Neovim:

   ```bash
   nvim
   ```

3. The plugins will be automatically installed.

## 📋 Requirements

- Neovim >= 0.8.0
- Git
- A Nerd Font for icons
- Node.js for LSP servers
- ripgrep for Telescope grep
- make for some plugins

## 🧩 Plugin List

| Plugin                  | Description                                |
| ----------------------- | ------------------------------------------ |
| **LSP and Completion**  |                                            |
| `nvim-lspconfig`        | Core LSP client configuration              |
| `conform.nvim`          | Code formatting engine                     |
| `nvim-cmp`              | Completion engine with multiple sources    |
| `LuaSnip`               | Snippet engine for advanced snippets       |
| `lspsaga.nvim`          | Enhanced UI for LSP features               |
| `fidget.nvim`           | LSP progress UI                            |
| **Language-Specific**   |                                            |
| `typescript.nvim`       | TypeScript extensions and tools            |
| `format-ts-errors.nvim` | Improved TypeScript error formatting       |
| `nvim-ts-autotag`       | Auto close and rename HTML/JSX tags        |
| **Navigation**          |                                            |
| `telescope.nvim`        | Fuzzy finder for files, grep, etc.         |
| `oil.nvim`              | File explorer with buffer-based navigation |
| `harpoon`               | Bookmarks for quick file navigation        |
| `leap.nvim`             | Fast cursor movement with 2-char search    |
| **UI and Experience**   |                                            |
| `bufferline.nvim`       | Enhanced tabline with visual indicators    |
| `lualine.nvim`          | Configurable and beautiful statusline      |
| `noice.nvim`            | UI for cmdline, messages and popups        |
| `nvim-notify`           | Notification manager with animations       |
| `nvim-web-devicons`     | Icons for files and UI elements            |
| `which-key.nvim`        | Displays available keybindings             |
| **Git Tools**           |                                            |
| `gitsigns.nvim`         | Git integration in the buffer              |
| `nvim-spectre`          | Project-wide search and replace            |
| **Utility**             |                                            |
| `toggleterm.nvim`       | Floating/persistent terminal               |
| `auto-save.nvim`        | Automatic file saving                      |
| `Comment.nvim`          | Smart code commenting                      |
| `persistence.nvim`      | Session management                         |
| `trouble.nvim`          | Pretty diagnostics list                    |
| `todo-comments.nvim`    | Highlight and search TODOs                 |
| `render-markdown.nvim`  | Enhanced markdown previewing               |

## ⌨️ Keybinding Cheatsheet

### Basic Editing

| Keybinding  | Mode   | Description                              |
| ----------- | ------ | ---------------------------------------- |
| `;`         | Normal | Enter command mode                       |
| `jk`        | Insert | Exit insert mode                         |
| `<leader>w` | Normal | Save file                                |
| `<leader>w` | Insert | Save file (exits to Normal mode briefly) |
| `<leader>c` | Normal | Toggle comment for current line          |

### File Navigation

| Keybinding   | Mode   | Description                 |
| ------------ | ------ | --------------------------- |
| `<C-e>`      | Normal | Open Oil file explorer      |
| `<leader>ee` | Normal | Open Oil in floating window |
| `<leader>oh` | Normal | Display Oil keymaps help    |

### Marks & Bookmarks (Harpoon)

| Keybinding   | Mode   | Description               |
| ------------ | ------ | ------------------------- |
| `<leader>ma` | Normal | Add current file to marks |
| `<leader>mm` | Normal | Open marks menu           |
| `<leader>m1` | Normal | Jump to mark 1            |
| `<leader>m2` | Normal | Jump to mark 2            |
| `<leader>m3` | Normal | Jump to mark 3            |

### Fuzzy Finding (Telescope)

| Keybinding   | Mode   | Description                 |
| ------------ | ------ | --------------------------- |
| `<leader>ff` | Normal | Find files                  |
| `<leader>fg` | Normal | Live grep (search in files) |
| `<leader>fb` | Normal | Browse open buffers         |
| `<leader>fh` | Normal | Search help tags            |
| `<leader>fs` | Normal | Find document symbols       |
| `<leader>fw` | Normal | Find workspace symbols      |
| `<leader>ft` | Normal | Find TODOs                  |

### LSP Features

| Keybinding   | Mode   | Description                    |
| ------------ | ------ | ------------------------------ |
| `gd`         | Normal | Go to definition               |
| `K`          | Normal | Show hover documentation       |
| `<leader>rn` | Normal | Rename symbol                  |
| `gr`         | Normal | Find references                |
| `<leader>o`  | Normal | Go to definition (alternative) |
| `<leader>p`  | Normal | Peek definition                |
| `<leader>e`  | Normal | Toggle diagnostic virtual text |

### C/C++ Specific

| Keybinding   | Mode   | Description          |
| ------------ | ------ | -------------------- |
| `<leader>cc` | Normal | Show callers         |
| `<leader>cr` | Normal | Find references      |
| `<leader>ci` | Normal | Find implementations |
| `<leader>cd` | Normal | Find definitions     |

### Diagnostics (Trouble)

| Keybinding   | Mode   | Description                  |
| ------------ | ------ | ---------------------------- |
| `<leader>xx` | Normal | Toggle document diagnostics  |
| `<leader>xX` | Normal | Toggle workspace diagnostics |
| `<leader>xL` | Normal | Toggle location list         |
| `<leader>xQ` | Normal | Toggle quickfix list         |

### Search and Replace (Spectre)

| Keybinding   | Mode   | Description                   |
| ------------ | ------ | ----------------------------- |
| `<leader>sr` | Normal | Toggle search & replace       |
| `<leader>sw` | Normal | Search & replace current word |

### Session Management

| Keybinding   | Mode   | Description                |
| ------------ | ------ | -------------------------- |
| `<leader>qs` | Normal | Restore session            |
| `<leader>ql` | Normal | Restore last session       |
| `<leader>qd` | Normal | Don't save current session |

### Terminal

| Keybinding   | Mode     | Description                   |
| ------------ | -------- | ----------------------------- |
| `<leader>tt` | Normal   | Toggle terminal               |
| `<C-\>`      | Normal   | Toggle terminal (alternative) |
| `<Esc>`      | Terminal | Exit terminal mode            |

### Git

| Keybinding   | Mode   | Description  |
| ------------ | ------ | ------------ |
| `<leader>gg` | Normal | Open LazyGit |
