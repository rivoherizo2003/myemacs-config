# 🚀 MyEmacs Config - Professional Emacs Setup

## Overview
A modern, performant Emacs configuration optimized for web development, Flutter/Dart, PHP, and polyglot development. Built with LSP support, Tree-sitter syntax highlighting, and bleeding-edge development tools.

## ✨ Features

- **LSP Integration** - Full Language Server Protocol support for intelligent code completion and diagnostics
- **Tree-sitter Support** - Modern syntax highlighting for TypeScript, JavaScript, Bash
- **Multi-Language Support** - HTML/CSS, JavaScript/TypeScript, PHP, Dart/Flutter, YAML, SQL, Bash, Java
- **Git Integration** - Magit for powerful Git workflow management
- **Project Management** - Projectile for seamless project navigation
- **Code Completion** - Company mode with smart autocompletion
- **Modern UI** - Doom themes and modeline for a contemporary look
- **Performance Optimized** - Tuned for fast startup and responsive editing

## 📋 System Requirements

- **Emacs 29+** (recommended for native Tree-sitter support)
- **Git** - For version control integration
- **Language Servers** - For LSP features (installed on-demand)
- **macOS, Linux, or Windows with WSL2**

## 🔧 Installation

### Step 1: Install Emacs

#### macOS
```bash
# Using Homebrew
brew install emacs

# For GUI version with better support
brew install --with-cocoa emacs
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install emacs emacs-el
```

#### Linux (Fedora/RHEL)
```bash
sudo dnf install emacs
```

#### Windows
- Download from [GNU Emacs website](https://www.gnu.org/software/emacs/)
- Or use Windows Subsystem for Linux (WSL2) with Linux instructions above

### Step 2: Clone Configuration

```bash
# Navigate to your Emacs configuration directory
cd ~/.config/emacs  # Linux/macOS
# or
cd ~\AppData\Roaming\.emacs.d  # Windows

# Clone this repository
git clone https://github.com/rivoherizo2003/myemacs-config.git .
```

### Step 3: Launch Emacs

```bash
emacs &
```

Emacs will automatically:
1. Download and install all required packages from MELPA
2. Compile configuration files
3. Initialize LSP servers on first use of each language

**Note:** First launch may take 2-3 minutes. Subsequent launches are fast.

## 📖 Configuration Guide

### File Structure
```
~/.config/emacs/
├── init.el              # Main configuration file
├── custom.el            # Auto-generated customizations
├── projectile-bookmarks.eld  # Project bookmarks
└── .gitignore          # Git ignore rules
```

### Customizing the Configuration

#### Adding New Packages
Edit `init.el` and add to the appropriate section:

```emacs-lisp
(use-package your-package-name
  :hook (major-mode . your-package-name)
  :config
  (setq your-package-option t))
```

#### Changing the Theme
Modify line 28 in init.el:
```emacs-lisp
(use-package doom-themes
  :config (load-theme 'doom-dracula t))  ; Change 'doom-one' to other doom themes
```

Available themes: `doom-one`, `doom-dracula`, `doom-gruvbox`, `doom-monokai-pro`, etc.

#### Adjusting Font Size
Change line 25-26 in init.el (`:height` is in 1/10 of a point):
```emacs-lisp
(set-face-attribute 'default nil :height 120)  ; 12pt font
```

## ⌨️ Key Bindings

| Keybinding | Command | Description |
|---|---|---|
| `C-c p` | Projectile | Project management prefix |
| `C-c p f` | projectile-find-file | Find file in project |
| `C-c p s r` | projectile-grep | Search in project |
| `C-c l` | LSP Mode | LSP commands prefix |
| `C-c l d` | lsp-find-definition | Jump to definition |
| `C-c l r` | lsp-find-references | Find all references |
| `C-c l n` | lsp-rename | Rename symbol |
| `M-x magit-status` | Magit | Open Git status |
| `C-x C-+` | Scale up | Increase font size |
| `C-x C--` | Scale down | Decrease font size |

## 🛠️ Supported Languages

### Web Development
- **HTML/CSS** - Web-mode with syntax highlighting
- **JavaScript** - Tree-sitter + LSP
- **TypeScript** - Tree-sitter + LSP

### Mobile Development
- **Dart/Flutter** - dart-mode + lsp-dart
- **Java** - LSP support

### Backend Development
- **PHP** - php-mode + LSP
- **SQL** - sql-indent + LSP
- **YAML** - yaml-mode
- **Bash** - bash-ts-mode (Tree-sitter)

## 🚀 Setting Up Language Servers

Language servers are installed automatically on first use. To manually install:

### TypeScript/JavaScript
```bash
npm install -g typescript-language-server typescript
```

### Python
```bash
pip install pylsp python-lsp-server
```

### PHP
```bash
composer global require felixbecker/language-server
```

### Dart/Flutter
Requires Dart SDK installation. Installation automatic with lsp-dart.

## 🐛 Troubleshooting

### LSP Not Working
1. Check if language server is installed: `M-x lsp-describe-session`
2. Enable LSP logging: Set `(setq lsp-log-io t)` temporarily in init.el
3. View logs: `M-x lsp-log-io-next-line` or check `*lsp-log*` buffer

### Slow Startup
1. Disable LSP logging: `(setq lsp-log-io nil)`
2. Disable unnecessary packages
3. Increase `lsp-idle-delay` (currently 0.5 seconds)

### Theme Not Loading
```emacs-lisp
M-x package-refresh-contents
M-x package-install doom-themes
```

### Package Installation Errors
```bash
# Clear package cache
rm -rf ~/.emacs.d/elpa/

# Restart Emacs and let it reinstall
emacs &
```

## 📚 Customization Tips

### Disable Relative Line Numbers
In init.el, change line 21:
```emacs-lisp
(setq display-line-numbers-type nil)  ; Use absolute line numbers
```

### Change Modeline
Try other doom-modeline configurations or alternatives:
- `mood-line` - Minimalist modeline
- `telephone-line` - Modular modeline

### Add Custom Keybindings
Add to end of init.el:
```emacs-lisp
(global-set-key (kbd "C-c m") 'your-command)
```

## 📦 Dependencies Summary

| Package | Purpose |
|---------|---------|
| use-package | Package management & configuration |
| doom-themes | Modern color theme |
| doom-modeline | Enhanced mode line |
| magit | Git integration |
| projectile | Project navigation |
| lsp-mode | Language Server Protocol |
| lsp-ui | LSP UI enhancements |
| company | Code completion |
| all-the-icons | Icon support |
| which-key | Keybinding hints |

## 🔄 Updating Configuration

To pull latest updates:
```bash
cd ~/.config/emacs
git pull origin main
```

Restart Emacs: `M-x restart-emacs` or restart the application.

## ⚙️ Advanced Setup

### Daemonize Emacs (Linux/macOS)
For faster subsequent launches:
```bash
# Start daemon
emacs --daemon

# Connect to daemon
emacsclient -c
```

### Windows Setup with WSL2
1. Install WSL2: Follow [Microsoft's guide](https://docs.microsoft.com/en-us/windows/wsl/install)
2. Install Emacs in WSL: `sudo apt install emacs`
3. Install Emacs on Windows for GUI
4. Configure `server-use-tcp` in init.el for WSL-Windows communication

## 🤝 Contributing

Feel free to fork this configuration and customize it for your workflow!

## 📞 Support

For issues or questions:
1. Check [GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/)
2. Visit [Emacs Stack Exchange](https://emacs.stackexchange.com/)
3. Check package documentation: `M-x describe-package`

## 📄 License

This configuration is provided as-is. Emacs is licensed under GNU General Public License v3.

---

**Happy Coding! 🎉**