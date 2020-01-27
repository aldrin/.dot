;;; org.el --- Org-mode configuration
;;;
;;; Author: Aldrin John D'Souza
;;;
;;; Commentary:
;;;
;;; This file configures org-mode for literate programming.
;;;
;;; Code:

;; Org mode.
(require 'ox)
(require 'org)
(require 'ox-latex)
(require 'org-bibtex)
(setq org-hide-leading-stars t)
(setq org-hide-emphasis-markers t)

(setq org-src-fontify-natively t)
(setq org-src-preserve-indentation t)
(setq org-confirm-babel-evaluate 'nil)
(org-babel-do-load-languages
 'org-babel-load-languages '((emacs-lisp . t )(shell . t)))

(setq org-export-with-toc 'nil)
(setq org-export-with-creator 'nil)
(setq org-export-with-smart-quotes t)
(setq org-latex-prefer-user-labels t)
(setq org-export-with-section-numbers 'nil)


(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
     '("latexmk -pdflua --shell-escape -bibtex %f"))

(setq org-latex-caption-above 'nil)
 (setq org-latex-minted-options
       '(("bgcolor" "WhiteSmoke")
         ("fontsize" "\\small")
         ("breaklines" "")))
;(setq org-latex-minted-options '(("bgcolor", "red")))
(setq org-latex-classes
      '(("article" "
\\documentclass[oneside]{article}

[DEFAULT-PACKAGES]

% Page geometry
\\usepackage[margin=.8in]{geometry}

% Links
\\usepackage[svgnames]{xcolor}
\\hypersetup{colorlinks,urlcolor=SteelBlue,linkcolor=DarkRed}

% Source code
\\usepackage[cachedir=/tmp/minted]{minted}
\\usemintedstyle{tango}

% Fonts
\\usepackage{fontspec}
\\setmainfont{IBM Plex Serif}
\\setsansfont{IBM Plex Sans Condensed}
\\setmonofont{IBM Plex Mono Light}

% Headings etc.
\\usepackage{sectsty}
\\allsectionsfont{\\sffamily}

% Headers and Footers
\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\footrulewidth}{0pt}
\\fancyhead{}
\\fancyfoot[C]{\\thepage}

% Indents and such
\\setlength{\\parindent}{0em}
\\usepackage[hang,flushmargin]{footmisc}

% Tables
\\usepackage{booktabs}

% Tweak the title rendering
\\makeatletter
\\renewcommand{\\@maketitle}{
\\newpage
 \\begin{center}%
 {\\huge \\sffamily \\@title \\par}%
 \\vskip 0.5em%
 {\\@author \\par}%
 {\\textcolor{lightgray}{\\@date} \\par}%
 \\end{center}%
 \\par} \\makeatother

[EXTRA]
"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; Render the current buffer
(defun ajd/render ()
  "Export and tangle current buffer."
  (interactive)
  (org-latex-export-to-pdf)
  (org-babel-tangle))

(provide 'ajd/org)
;;; org.el ends here
