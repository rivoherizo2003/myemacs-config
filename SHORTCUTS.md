### 🔍 Searching & 📂 Opening Files

* **`C-x C-f`** (`find-file`): Open or create a file (Native Emacs).
* **`C-c p f`** (`projectile-find-file`): Search for a file by name across your entire project.
* **`C-c p p`** (`projectile-switch-project`): **Switch Project** (Quickly jump between Laravel and Symfony projects).
* **`C-x C-w`** (`Save As`): **Save As** Save the current file under a new name.
* **`C-x C-s`** (`Save As`): **Save** Save.
* **`C-x s`** (`Save As`): **Save All** Emacs asks you (y/n) for every open file that has unsaved changes..
  
### 🔄 Navigation & Buffers

* **`C-x b`** (`switch-to-buffer`): Switch to a file that is already open.
* **`C-c p b`** (`projectile-switch-to-buffer`): Switch to an open file belonging to the current project.
* **`C-x o`** (`other-window`): Jump the cursor to another window (if your screen is split).

### 🎯 Selecting & ❌ Deleting Lines

* **`C-SPC` + `C-n` / `C-p`**: **Select text**. Set the mark with `C-SPC`, then move the cursor to highlight.
* **`C-x h`**: Select the entire buffer/file.
* **`C-k`**: Delete from the cursor position to the end of the line.
* **`C-S-Backspace`**: **Kill whole line**, regardless of cursor position.

### 📋 Copy & Paste (Kill Ring)

* **`M-w`**: **Copy** the selection.
* **`C-w`**: **Cut** the selection.
* **`C-y`**: **Paste** (Yank).
* **`M-y`**: **Paste History** (Use immediately after `C-y` to cycle through previous copies).

### 🚀 Fast Navigation (LSP & Lines)

* **`C-c l g`**: **Go to Definition**. Jump directly to the source of the class or method under the cursor.
* **`M-g M-g`**: Jump to an absolute line number.
* **`C-u [num] C-n/p`**: Relative jump (e.g., `C-u 10 C-n` to move 10 lines down).

### 🐘 PHP & Frameworks (Custom Shortcuts)

* **`C-c a`**: Run **PHP Artisan** (Laravel).
* **`C-c s`**: Run **PHP bin/console** (Symfony).
* **`C-c c c`**: Run **Composer Install** via the `composer` package.

### 🪄 Code Intelligence (LSP)

* **`M-RET`**: **Quick Fix / Code Action**. Auto-import missing namespaces or fix errors.
* **`C-c l r`**: **Rename**. Safely rename a variable or method across the entire project.
* **`M-x lsp-format-buffer`**: Reformat the entire file based on standards (PSR-12, etc.).

### 🌿 Git (Magit)

* **`C-x g`**: Open the **Magit** status interface.
* **`s`** (within Magit): Stage the file or change under the cursor.
* **`c c`**: Create a commit.
* **`P p`**: Push changes to the remote server.
