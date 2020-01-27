;;; cfn.el --- CloudFormation configuration
;;;
;;; Author: Aldrin John D'Souza
;;;
;;; Commentary:
;;;
;;; This file configures Emacs for editing CloudFormation better.
;;;
;;; Code:

(define-derived-mode cfn-yaml-mode yaml-mode
  "CFN-YAML" "CloudFormation Template")

(add-to-list 'magic-mode-alist
             '("\\(---\n\\)?AWSTemplateFormatVersion:" . cfn-yaml-mode))

;; Set up cfn-lint integration if flycheck is installed
;; Get flycheck here https://www.flycheck.org/
(when (featurep 'flycheck)
  (flycheck-define-checker cfn-lint
    "AWS CloudFormation linter using cfn-lint."
    :command ("cfn-lint" "-f" "parseable" source)
    :error-patterns ((warning line-start (file-name) ":" line ":" column
                              ":" (one-or-more digit) ":" (one-or-more digit) ":"
                              (id "W" (one-or-more digit)) ":" (message) line-end)
                     (error line-start (file-name) ":" line ":" column
                            ":" (one-or-more digit) ":" (one-or-more digit) ":"
                            (id "E" (one-or-more digit)) ":" (message) line-end))
    :modes (cfn-json-mode cfn-yaml-mode))

  (add-to-list 'flycheck-checkers 'cfn-lint)
  (add-hook 'cfn-yaml-mode-hook 'flycheck-mode))

;;; cfn.el ends here
