;;; .emacs --- emacs initialization file
;;;
;;; Author: Aldrin John D'Souza
;;;
;;; Commentary:
;;;
;;; The baseline configuration for all *my* Emacs setups.  My primary
;;; workspace is the latest Emacs running on the latest macOS.  There
;;; is very little effort put into making these work on other
;;; operation systems (particularly Windows) or with older Emacs
;;; versions.
;;;
;;; Code:

;; Packages.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Use use-package.
(unless (package-installed-p 'use-package)
  (progn (package-refresh-contents)
         (package-install 'use-package)))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

;; Local customizations
(setq custom-file "~/.custom.el")
(when (file-exists-p custom-file) (load custom-file))

;; Packages
(use-package magit :demand t)

(use-package better-defaults :demand t)

(use-package drag-stuff
  :demand t
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :demand t
  :config
  (exec-path-from-shell-initialize))

(use-package super-save
  :demand t
  :config
  (add-to-list 'super-save-hook-triggers 'focus-out-hook)
  (super-save-mode 1))

(use-package doom-themes
  :if (display-graphic-p)
  :demand t
  :config
  (load-theme 'doom-challenger-deep t)
  (doom-themes-org-config))

(use-package doom-modeline
  :demand t
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons-dired
  :demand t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package osx-clipboard
  :if (memq window-system '(mac ns))
  :config (osx-clipboard-mode +1))

(use-package markdown-mode
  :custom
  (markdown-header-scaling t)
  :mode ("\\.md$" . gfm-mode))

(use-package web-mode
  :mode (("\\.html$" . web-mode)))

(use-package yaml-mode
  :mode (("\\.y?ml$" . yaml-mode)))

(use-package htmlize)

(use-package mixed-pitch)

(use-package writeroom-mode)

(use-package ns-auto-titlebar)

(use-package load-dir
  :custom
  (load-dirs "~/.elisp"))

;; Use bullets, instead of asterisks.
(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("●" "○"))
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

;; Presentations
(use-package org-tree-slide
  :custom
  (org-tree-slide-skip-outline-level 4)
  :config
   (org-tree-slide-simple-profile))

;; Markdown
(use-package ox-gfm)
(use-package org-ref :demand t
  :custom
  (reftex-default-bibliography '("~/references.bib")))

;; Rust
(use-package rust-mode
  :config
  (setq rust-format-on-save t))

;; Terraform
(use-package terraform-mode
  :mode ("\\.tf$" . terraform-mode)
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;; Python format
(use-package blacken
  :demand t
  :config
  (add-hook 'python-mode-hook 'blacken-mode))

;; Bury successful build logs
(use-package bury-successful-compilation :demand t)
(use-package toml-mode :demand t)

;; Global
(defun ajd/everywhere ()
  "Settings we want everywhere."

  ;; Enable modes
  (show-paren-mode 1)
  (electric-pair-mode t)
  (column-number-mode 1)
  (delete-selection-mode t)
  (global-auto-revert-mode 1)

  ;; Times
  (setq display-time-world-list
        '(("Asia/Calcutta" "India")
          ("UTC" "UTC")
          ("America/New_York" "Eastern")
          ("America/Chicago" "Central")
          ("America/Denver" "Mountain")
          ("America/Los_Angeles" "Pacific")))

  ;; Latest features
  (when (>= emacs-major-version 26)
    (pixel-scroll-mode))

  ;; Change defaults
  (setq auto-save-default nil)
  (setq-default fill-column 100)
  (setq inhibit-startup-screen t)
  (setq show-trailing-whitespace t)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq ring-bell-function 'ignore)
  (setq initial-scratch-message nil)
  ;; Hooks
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; Key bindings
  (global-set-key (kbd "M-c") 'compile))

;; Terminal
(defun ajd/terminal ()
  "Settings for when we're running in a terminal."
  (global-set-key (kbd "ESC <up>") 'drag-stuff-up)
  (global-set-key (kbd "ESC <down>") 'drag-stuff-down))

;; Graphical
(defun ajd/graphical ()
  "Settings for when we're running in full graphical mode."
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'org-mode-hook 'mixed-pitch-mode)
  (when (eq system-type 'darwin) (ns-auto-titlebar-mode))
  (global-hl-line-mode 1))

;; Apply, as appropriate.
(load-dirs)
(ajd/everywhere)
(if (display-graphic-p) (ajd/graphical) (ajd/terminal))

;; Done
(provide '.emacs)
;;; .emacs ends here
