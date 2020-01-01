;;; .org.el --- Org-mode configuration
;;;
;;; Commentary: This file configures org-mode for literate programming.
;;;
;;; Code:

(require 'ox)
(require 'ox-latex)

;; Export options
(setq org-export-with-toc 'nil)
(setq org-export-with-creator 'nil)
(setq org-export-with-smart-quotes t)
(setq org-src-preserve-indentation t)
(setq org-export-with-section-numbers 'nil)

;; XeLaTeX
(setq org-latex-compiler "xelatex")

;; Syntax highlighting using Python pygments.
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-latex-classes
      '(("article" "
\\documentclass[oneside]{article}

[DEFAULT-PACKAGES]

\\usepackage[margin=1in]{geometry}

\\hypersetup{colorlinks,urlcolor=teal,linkcolor=red}
\\usepackage[cachedir=/tmp/minted]{minted}
\\usemintedstyle{tango}

\\usepackage{fontspec}
\\setmainfont{IBM Plex Serif}
\\setsansfont{IBM Plex Sans}
\\setmonofont[Scale=0.9]{IBM Plex Mono Italic}

\\usepackage{sectsty}
\\allsectionsfont{\\sffamily}

\\usepackage{fancyhdr}
\\pagestyle{fancy}

\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\footrulewidth}{0pt}

\\fancyhead{}
\\fancyfoot[C]{\\thepage}

\\setlength{\\parindent}{0em}
\\setlength{\\parskip}{.2em}
\\usepackage[hang,flushmargin]{footmisc}

\\makeatletter
\\renewcommand{\\@maketitle}{
\\newpage
 \\begin{center}%
 {\\sffamily \\huge \\@title \\par}%
 \\vskip 0.5em%
 {\\@author \\par}%
 {\\textcolor{gray}{\\@date} \\par}%
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
(defun export-tangle ()
  "Export and tangle current buffer."
  (interactive)
  (org-latex-export-to-pdf)
  (org-babel-tangle))

(provide '.org)
;;; .org.el ends here
