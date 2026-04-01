### 🔍 Searching & 📂 Opening Files

* **`C-x C-f`** (`find-file`): Open or create a file (Native Emacs).
* **`C-c p f`** (`projectile-find-file`): Search for a file anywhere inside your current project.

### 🔄 Switching Files (Buffers)

* **`C-x b`** (`switch-to-buffer`): Switch to a file that is already open in the background.
* **`C-c p b`** (`projectile-switch-to-buffer`): Switch to an open file specifically belonging to your current project.

### 🎯 Selecting & ❌ Deleting Lines

* **`C-SPC` + `Down Arrow` (or `C-n`)**: **Select lines**. Set the mark with `C-SPC`, then move your cursor up or down to select multiple lines.
* **`C-x h`** (`mark-whole-buffer`): Select the entire file at once.
* **`C-k`** (`kill-line`): Delete everything from your cursor to the end of the line.
* **`C-S-Backspace`** (`kill-whole-line`): **Delete the entire line**, regardless of where your cursor is positioned on it.

### 📋 Copy and Paste

*First, press **`C-SPC`** to set a marker and move your cursor to select text, then use:*

* **`M-w`** (Alt + w): **Copy** the selected text.
* **`C-w`** (Ctrl + w): **Cut** the selected text.
* **`C-y`** (Ctrl + y): **Paste** (Yank) the text you just copied or cut.
* **`M-y`** (Alt + y): **Paste History** (Press this immediately after `C-y` to cycle back through your clipboard history).

### 🚀 Jumping to a Line (Relative & Absolute)

*Since you use relative line numbers, you have two powerful ways to navigate:*

* **`C-u [number] C-n`** (or **`C-p`**): **Jump using relative numbers.** If you see the code you want to edit is 12 lines below, just type `C-u 12 C-n` (Down). If it's 8 lines above, type `C-u 8 C-p` (Up). *(Pro tip: You can also hold `Meta/Alt` and type the number, like `M-1 M-2 C-n`).*
* **`M-g M-g`** (`goto-line`): **Jump to an absolute line number.** Emacs will ask you for the exact line number at the bottom of the screen.

### 🪄 Formatting Code

* **`M-x lsp-format-buffer`**: Format the entire file using your LSP server (e.g., Intelephense for PHP, Prettier for JS/CSS).
* **`C-M-\`** (Ctrl + Alt + Backslash): Instantly fix the indentation and alignment of the currently selected block of code.
