;;; init.el --- Emacs Pro Config for EndeavourOS

;; --- 1. Gestion des paquets (MELPA) ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; --- 2. Interface et Performance ---
(setq inhibit-startup-message t)
(tool-bar-mode -1)          ; Pas d'icônes inutiles
(menu-bar-mode -1)          ; Pas de menu en haut
(scroll-bar-mode -1)        ; Pas de barre de défilement
(setq display-line-numbers-type 'relative) ; Mode relatif activé
(global-display-line-numbers-mode t)       ; Affiche les numéros
(if (daemonp)
    (add-hook 'server-after-make-frame-hook
              (lambda () (set-face-attribute 'default nil :height 110)))
  (set-face-attribute 'default nil :height 110))

(use-package doom-themes
  :config (load-theme 'doom-one t)) ; Un thème sombre moderne

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.8)) ; Temps d'attente (en secondes) avant l'affichage
;; --- 3. Développement (Core) ---
(use-package magit)         ; Le meilleur client Git
(use-package projectile
  :init (projectile-mode +1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package company        ; Autocomplétion
  :config (global-company-mode))

;; --- 4. LSP Mode (Le cerveau de l'éditeur) ---
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((web-mode . lsp)
         (typescript-ts-mode . lsp)
         (js-ts-mode . lsp)
         (php-mode . lsp)
         (dart-mode . lsp)
         (java-mode . lsp)
         (sh-mode . lsp)
         (yaml-mode . lsp)
         (sql-mode . lsp))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)

;; --- 5. Configuration des langages spécifiques ---

;; Web (HTML/CSS)
(use-package web-mode
  :mode ("\\.html\\'" "\\.css\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2))

;; Flutter / Dart
(use-package dart-mode)
(use-package lsp-dart
  :hook (dart-mode . lsp))

;; PHP
(use-package php-mode)

;; YAML
(use-package yaml-mode)

;; SQL & PL/pgSQL
(use-package sql-indent)

;; --- 6. Tree-sitter (Coloration syntaxique moderne) ---
;; Emacs 29+ utilise tree-sitter nativement pour TS/JS/Bash
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (bash-mode . bash-ts-mode)))

(provide 'init.el)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
