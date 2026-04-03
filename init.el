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

;; ✅ Active la fermeture automatique des parenthèses/accolades partout
(electric-pair-mode 1)

;; ajoute une ligne indentée entre deux accolades
(global-set-key (kbd "RET") 'newline-and-indent)

;; Empêche l'auto-pairing des <> en mode PHP/Java pour ne pas gêner les flèches -> ou les types génériques
(setq electric-pair-inhibit-predicate
      `(lambda (c)
         (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))

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
         (php-ts-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (js-ts-mode . lsp-deferred) ;; deferred est mieux pour les perfs
         (css-mode . lsp-deferred)
         (yaml-mode . lsp-deferred))
  :config
  (setq lsp-php-server-any-version t)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.5)

  (setq lsp-enable-indentation nil)
  (setq lsp-enable-on-type-formatting nil)
  
  ;; 🎨 FORCER LSP À LIRE BLADE ET TWIG COMME DU HTML
  (add-to-list 'lsp-language-id-configuration '("\\.blade\\.php\\'" . "html"))
  (add-to-list 'lsp-language-id-configuration '("\\.html\\.twig\\'" . "html"))

  ;; 🛑 DIRE A LSP D'IGNORER LES GROS DOSSIERS SYMFONY/LARAVEL
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]vendor\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]var\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]node_modules\\'"))

(use-package lsp-ui :hook (lsp-mode . lsp-ui-mode))

;; --- 5. Frameworks & Tailwind ---

;; Tailwind CSS (Autocomplétion des classes)
(use-package lsp-tailwindcss
  :ensure t
  :init (setq lsp-tailwindcss-add-on-mode t)
  :config
  (setq lsp-tailwindcss-major-modes '(web-mode php-mode html-mode css-mode)))

;; PHP Mode (Base)
(use-package php-mode :mode "\\.php\\'")

;; Optional: Quick Framework Commands
(defun my-php-framework-commands ()
  "Ajoute les raccourcis Symfony/Laravel."
  (local-set-key (kbd "C-c a") (lambda () (interactive) (compile "php artisan ")))
  (local-set-key (kbd "C-c s") (lambda () (interactive) (compile "php bin/console "))))

(add-hook 'php-mode-hook #'my-php-framework-commands)
(add-hook 'php-ts-mode-hook #'my-php-framework-commands)

;; Templates (Twig & Blade)
(use-package web-mode
  :mode ("\\.blade\\.php\\'" "\\.html\\.twig\\'" "\\.html\\'" "\\.css\\'")
  :hook (web-mode . (lambda ()
                      ;; On force les variables localement au buffer
                      (setq-local web-mode-enable-auto-closing t)
                      (setq-local web-mode-enable-auto-pairing t)
                      (setq-local web-mode-enable-auto-indentation t)))
  :config
  (setq web-mode-engines-alist 
        '(("blade" . "\\.blade\\.php\\'")
          ("twig"  . "\\.html\\.twig\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil))

;; emmet-mode
(use-package emmet-mode
  :ensure t
  :hook (web-mode html-mode css-mode))

;; Composer
(use-package composer
  :bind (:map php-mode-map ("C-c c c" . composer-install)))

;; Java
(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp-deferred))

;; --- 7. Gestion de l'Indentation & Style Universel ---

;; 🚫 La règle d'or : Espaces au lieu de Tabulations
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; 📐 Fonction de style "Moderne" (Accolades alignées verticalement)
(defun my-modern-indent-style ()
  (setq c-basic-offset 4)
  (c-set-style "java") ;; Style de base plus propre que "linux"
  ;; Force l'alignement des { et } sur la colonne de l'instruction parente (0 = pas de décalage)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'arglist-intro '+))

;; 🐘 Appliquer aux langages C-like (PHP, Java)
(add-hook 'c-mode-common-hook #'my-modern-indent-style)
(add-hook 'php-mode-hook #'my-modern-indent-style)
(add-hook 'php-ts-mode-hook #'my-modern-indent-style)
(add-hook 'java-mode-hook #'my-modern-indent-style)
(add-hook 'java-ts-mode-hook #'my-modern-indent-style)

;; 🎨 Configuration Web & JS (2 espaces mais accolades alignées)
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq css-indent-offset 2)

(with-eval-after-load 'web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; 🎯 Cas particulier de Dart (2 espaces)
(use-package dart-mode
  :ensure t
  :hook (dart-mode . (lambda ()
                       (setq c-basic-offset 2)
                       (setq indent-tabs-mode nil))))

;; --- 8. Tree-sitter (Emacs 29+) ---
;; Automatiser l'installation des grammaires manquantes

;; Corriger l'URL et la branche pour les grammaires PHP et PHPDoc
(setq treesit-language-source-alist
  '((php "https://github.com/tree-sitter/tree-sitter-php" "master" "php/src")
    (phpdoc "https://github.com/claytonrcarter/tree-sitter-phpdoc" "master" "src")))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt) ;; Met 't' à la place de 'prompt' si tu ne veux même pas qu'il te demande confirmation
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (bash-mode . bash-ts-mode)
        (php-mode . php-ts-mode)))

(provide 'init.el)
