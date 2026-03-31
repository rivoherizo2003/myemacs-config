;;; init.el --- Emacs Pro Config: Symfony 7, Laravel 13 & Tailwind CSS

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

;; --- 1. Gestion des paquets ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package) (package-refresh-contents) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; --- 2. Interface et Performance ---
(setq inhibit-startup-message t)
(tool-bar-mode -1) (menu-bar-mode -1) (scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-fringe-mode 10)
(setq-default line-spacing 0.1)

(use-package doom-themes :config (load-theme 'doom-one t))
(use-package doom-modeline :init (doom-modeline-mode 1))
(use-package all-the-icons :if (display-graphic-p))
(use-package which-key :init (which-key-mode) :config (setq which-key-idle-delay 0.8))

;; --- 3. Développement (Core & Git) ---
(use-package magit)
(use-package projectile
  :init (projectile-mode +1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package company
  :config (global-company-mode)
  (setq company-idle-delay 0.1 company-minimum-prefix-length 1))

;; --- 4. LSP Mode (Le cerveau) ---
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((php-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (js-ts-mode . lsp)
         (css-mode . lsp)
         (yaml-mode . lsp))
  :config
  (setq lsp-php-server-any-version t)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.5)
  ;; Support de Tailwind via LSP
  (add-to-list 'lsp-language-id-configuration '("\\.blade\\.php\\'" . "html")))

(use-package lsp-ui :hook (lsp-mode . lsp-ui-mode))

;; --- 5. Frameworks & Tailwind ---

;; Tailwind CSS (Autocomplétion des classes)
(use-package lsp-tailwindcss
  :ensure t
  :init (setq lsp-tailwindcss-add-on-mode t)
  :config
  ;; On dit à Tailwind de s'activer sur Blade et Twig
  (setq lsp-tailwindcss-major-modes '(web-mode php-mode html-mode css-mode)))

;; PHP & Laravel Artisan
(use-package php-mode :mode "\\.php\\'")
(use-package laravel-mode
  :hook (php-mode . laravel-mode)
  :bind (:map laravel-mode-map ("C-c a" . laravel-artisan-call)))

;; Symfony Navigation
(use-package symfony-mode :hook (php-mode . symfony-mode))

;; Templates (Twig & Blade)
(use-package web-mode
  :mode ("\\.blade\\.php\\'" "\\.html\\.twig\\'" "\\.html\\'" "\\.css\\'")
  :config
  (setq web-mode-engines-alist 
        '(("blade" . "\\.blade\\.php\\'")
          ("twig"  . "\\.html\\.twig\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil)) ;; Évite les conflits avec les directives Blade

;; Composer
(use-package composer
  :bind (:map php-mode-map ("C-c c c" . composer-install)))

;; Java
(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp-deferred))

;; --- 6. Tree-sitter (Emacs 29+) ---
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (bash-mode . bash-ts-mode)
        (php-mode . php-ts-mode)))

(provide 'init.el)
