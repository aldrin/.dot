;;; .emacs --- emacs init file
;;;
;;; Commentary:
;;;
;;; This file sets the common baseline I assume to be present in all
;;; Emacs instances I work with.  There is little effort put into
;;; making these compatible with legacy versions of Emacs and assume
;;; that the we're on 26 or above.  My primary workspace is macOS and
;;; that is all I've tested so far, so there may be rough edges on
;;; other Linux and Windows.
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

;; Packages
(use-package better-defaults
  :ensure t)

(use-package magit
  :ensure t)

(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package spacemacs-common
  :if window-system
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-light t))

(use-package smart-mode-line
  :if window-system
  :ensure t
  :init (setq sml/no-confirm-load-theme t)
  :config (sml/setup))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package osx-clipboard
  :if (memq window-system '(mac ns))
  :ensure t :config (osx-clipboard-mode +1))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :config
  (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode)))

(use-package org
  :ensure t
  :defer 1
  :config
  (setq org-src-fontify-natively t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t))))

(use-package web-mode
  :ensure t
  :mode (("\\.html$" . web-mode)))

(use-package yaml-mode
  :ensure t
  :mode (("\\.y?ml$" . yaml-mode)))

;; Standard Settings
(setq fill-column 100)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-startup-screen t)
(setq show-trailing-whitespace t)
(setq ring-bell-function 'ignore)
(setq initial-scratch-message nil)

;; Standard Modes
(show-paren-mode 1)
(electric-pair-mode t)
(column-number-mode 1)
(global-auto-revert-mode 1)

;; Hooks, etc.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Miscellaneous
(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Local customizations
(setq custom-file (concat user-emacs-directory ".custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Done
(provide '.emacs)
;;; .emacs ends here
