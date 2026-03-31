# 🚀 MyEmacs Config - Professional Polyglot Setup

## 📋 Overview
A modern, high-performance Emacs configuration optimized for Web Development (**Symfony 7.4**, **Laravel 13**, **Tailwind CSS**), **Flutter/Dart**, **Java**, and polyglot programming. Built on **Emacs 29+**, it leverages **LSP** and **Tree-sitter** for a premium IDE-like experience.

---

## ✨ Features
- **LSP Integration** - Full Language Server Protocol support for intelligent completion and diagnostics.
- **Modern UI** - Doom-One theme, enhanced Modeline, and native icon support (`all-the-icons`).
- **Framework Ready** - Dedicated tooling for Symfony, Laravel (Artisan), and Tailwind CSS.
- **Git Power** - Integrated Magit, the world’s best Git client.
- **Performance** - Tuned for fast startup and responsive real-time editing.

---

## 🛠️ System Dependencies (Required)

To enable code intelligence (LSP), you **must** install the following language servers on your system (**EndeavourOS / Arch**):

### 1. Web & PHP (via NPM)
```bash
# Global installation of language servers
npm install -g intelephense              # PHP Language Server
npm install -g @tailwindcss/language-server # Tailwind CSS Support
npm install -g typescript typescript-language-server # JS / TS Support
```

### 2. Java (via Pacman)
```bash
# JDK and build tools
sudo pacman -S jdk-openjdk maven gradle
```

### 3. Flutter / Dart
Install the official Flutter SDK. `lsp-dart` will handle the rest upon opening your first `.dart` file.

---

## 🐘 Framework Specific Setup

### Laravel 13
To enable autocomplete for Facades (`Route::`, `Auth::`), run this at the root of your Laravel projects:
```bash
composer require --dev barryvdh/laravel-ide-helper && php artisan ide-helper:generate
```

### Symfony 7.4
`symfony-mode` activates automatically when a `composer.json` is detected. Use it to navigate quickly between your services, routes, and controllers.

---

## 📦 Installation & Setup

1. **Clone the configuration:**
   ```bash
   git clone [https://github.com/rivoherizo2003/myemacs-config.git](https://github.com/rivoherizo2003/myemacs-config.git) ~/.emacs.d
   ```

2. **Launch Emacs:**
   The first launch will automatically download all required packages (2-3 minutes).

3. **Install Fonts (Crucial):**
   Once the package installation is complete, run the following command within Emacs:
   `M-x all-the-icons-install-fonts`

---

## ⌨️ Key Bindings (Cheatsheet)

### 🚀 Navigation & Git
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `C-c p` | **Projectile** | Project management menu (Find file, Switch project) |
| `M-x magit-status` | **Magit** | Full-featured Git interface |
| `M-x vterm` | **Terminal** | Ultra-fast embedded terminal |
| `C-x C-+ / -` | **Zoom** | Increase / Decrease font size |

### 💻 LSP & Code Intelligence (PHP, JS, Java)
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `C-c l` | **LSP Menu** | Prefix for all LSP commands |
| `C-c l d` | `find-definition` | Jump to source code |
| `C-c l r` | `find-references` | Find all usages in project |
| `C-c l n` | `lsp-rename` | Rename symbol across all files |
| `C-c l a a` | `code-actions` | Quick fixes (Imports, Getters/Setters) |

### 🛠️ Framework Tooling
| Shortcut | Action | Context |
| `C-c c c` | `composer-install`| Install PHP dependencies |

---

## ☕ Java Workflow
1. **Import**: When opening a Maven/Gradle project, accept the workspace import (`y`).
2. **Dependencies**: Any change to `pom.xml` or `build.gradle` triggers an automatic re-index.
3. **Getters/Setters**: Use `M-x lsp-java-generate-getters-setters` or Code Actions (`C-c l a a`).

---

## 🐛 Troubleshooting

### LSP Not Starting?
Check if the server is properly installed with `M-x lsp-describe-session`. Ensure that the binaries (`intelephense`, etc.) are in your `$PATH`.

### Icons Missing?
Don't forget to run `M-x all-the-icons-install-fonts`. On Linux, this downloads fonts to `~/.local/share/fonts`.

### Performance Lag?
If Emacs slows down in large Tailwind projects, adjust the index delay in your `init.el`:
`(setq lsp-idle-delay 0.5)`

---
*Configured with ❤️ on **EndeavourOS**. Happy Coding! 🎉*
