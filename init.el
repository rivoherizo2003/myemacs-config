;;; init.el --- Emacs Pro Config for Symfony 7.4 & PHP 8+

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

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
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-fringe-mode 10)
(setq-default line-spacing 0.1)

(if (daemonp)
    (add-hook 'server-after-make-frame-hook (lambda () (set-face-attribute 'default nil :height 110)))
  (set-face-attribute 'default nil :height 110))

(use-package doom-themes :config (load-theme 'doom-one t))
(use-package doom-modeline :init (doom-modeline-mode 1))
(use-package all-the-icons :if (display-graphic-p))
(use-package which-key :init (which-key-mode) :config (setq which-key-idle-delay 0.8))

;; --- 3. Développement (Core) ---
(use-package magit)
(use-package projectile
  :init (projectile-mode +1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package company
  :config (global-company-mode)
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

;; --- 4. LSP Mode (Le cerveau de l'éditeur) ---
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((php-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (typescript-ts-mode . lsp)
         (js-ts-mode . lsp)
         (yaml-mode . lsp))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-php-server-any-version t) ; Support PHP 8+ pour Symfony 7
  (setq lsp-idle-delay 0.5)
  (setq lsp-log-io nil)
  (setq read-process-output-max (* 1024 1024)))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable t
        lsp-ui-imenu-enable t))

;; --- 5. Configuration spécifique SYMFONY & PHP ---

;; PHP Mode avec support des Attributes (PHP 8)
(use-package php-mode
  :mode "\\.php\\'"
  :config
  (setq php-mode-coding-style 'psr2))

;; Symfony Mode (Navigation & Helper)
(use-package symfony-mode
  :ensure t
  :hook (php-mode . symfony-mode))

;; Twig & Web development
(use-package web-mode
  :mode ("\\.html\\.twig\\'" "\\.html\\'" "\\.css\\'")
  :config
  (setq web-mode-engines-alist '(("twig" . "\\.html\\.twig\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; Composer integration
(use-package composer
  :ensure t
  :bind (:map php-mode-map
              ("C-c c c" . composer-install)
              ("C-c c u" . composer-update)))

;; --- 6. Autres langages ---
(use-package dart-mode)
(use-package lsp-dart :hook (dart-mode . lsp))
(use-package yaml-mode)
(use-package sql-indent)

;; --- 7. Tree-sitter (Emacs 29+) ---
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (bash-mode . bash-ts-mode)
        (php-mode . php-ts-mode))) ; Utilise le parser moderne pour PHP si dispo

(provide 'init.el)
