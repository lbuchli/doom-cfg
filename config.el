;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Visuals                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(toggle-scroll-bar -1) ;; disable scroll bar

;; Start Screen Logo
(setq
 +doom-dashboard-banner-dir doom-private-dir
 +doom-dashboard-banner-file "emacs-logo.png"
 )

;; Quit Message
(setq
 +doom-quit-messages '("")
)

;; "Fringe" bar (errors, ...)
(fringe-mode '(nil . 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Languages                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General
(setq
 build-command "make build"
 run-command   "make run"
 test-command  "make test"
 debug-command "make debug"
)

;; Go
(defun cfg-go-mode-hook ()
  "Hook for go mode"
  (add-hook 'before-save-hook 'gofmt-before-save)                 ;; format before saving
  (add-hook 'completion-at-point-functions 'go-complete-at-point) ;; autocomplete

  (set (make-local-variable 'build-command) "go build *.go" )
  (set (make-local-variable 'run-command)   "go run *.go" )
  (set (make-local-variable 'test-command)  "go test -v *.go" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'go-mode-hook 'cfg-go-mode-hook)
(setq godoc-command "go doc")

;; Verilog
(setq verilog-simulator "verilator")

;; Java
(defun cfg-java-mode-hook ()
  "Hook for java mode"
  (set (make-local-variable 'build-command) "gradle build" )
  (set (make-local-variable 'run-command)   "gradle run" )
  (set (make-local-variable 'test-command)  "gradle test" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'java-mode-hook 'cfg-java-mode-hook)

;; Javascript :(
(defun cfg-javascript-mode-hook ()
  "Hook for Javascript mode"
  (set (make-local-variable 'build-command) "" )
  (set (make-local-variable 'run-command)   "node {bpath}" )
  (set (make-local-variable 'test-command)  "" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'javascript-mode-hook 'cfg-javascript-mode-hook)

;; Python (3)
(defun cfg-python-mode-hook ()
  "Hook for python mode"
  (set (make-local-variable 'show-trailing-whitespace) nil)

  (set (make-local-variable 'build-command) "" )
  (set (make-local-variable 'run-command)   "python {bpath}" )
  (set (make-local-variable 'test-command)  "" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'python-mode-hook 'cfg-python-mode-hook)

;; Ruby
(defun cfg-ruby-mode-hook ()
  "Hook for ruby mode"
  (set (make-local-variable 'build-command) "" )
  (set (make-local-variable 'run-command)   "ruby {bpath}" )
  (set (make-local-variable 'test-command)  "" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'ruby-mode-hook 'cfg-ruby-mode-hook)


;; Julia
(defun cfg-julia-mode-hook ()
  "Hook for julia mode"
  (set (make-local-variable 'build-command) "" )
  (set (make-local-variable 'run-command)   "julia {bpath}" )
  (set (make-local-variable 'test-command)  "" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'julia-mode-hook 'cfg-julia-mode-hook)

;; Idris
(defun cfg-idris-mode-hook ()
  "Hook for julia mode"
  (set (make-local-variable 'build-command) "idris {bpath} -o {bpath-noext}" )
  (set (make-local-variable 'run-command)   "idris {bpath} -o {bpath-noext} && {bpath-noext}" )
  (set (make-local-variable 'test-command)  "idris {bpath} --check" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'idris-mode-hook 'cfg-idris-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Keyboard Shortcuts                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General
(set-input-mode t nil t "ESC") ;; Quit (C-g) to ESC

;; code
(map! :leader (:prefix-map ("c" . "code")
                :desc "Comment out region" "o" #'comment-region
                :desc "Uncomment region"   "u" #'uncomment-region
                :desc "Build project"      "b" (lambda () (interactive) (run-command-in-project-root build-command))
                :desc "Run project"        "r" (lambda () (interactive) (run-command-in-project-root run-command))
                :desc "Test project"       "t" (lambda () (interactive) (run-command-in-project-root test-command))
                :desc "Debug project"      "d" (lambda () (interactive) (run-command-in-project-root debug-command))
))

;; open
(map! :leader (:prefix-map ("o" . "open")
                :desc "Neotree sidebar" "s" #'neotree
))

;; journal
(map! :leader (:prefix-map ("j" . "journal")
                :desc "New journal entry"                         "n" #'org-journal-new-entry
                :desc "Open journal at date"                      "o" #'org-journal-read-entry
                :desc "Search for string in journals of interval" "s" #'org-journal-search
                :desc "Go one day forward"                        "f" #'org-journal-next-entry
                :desc "Go to previous day"                        "p" #'org-journal-previous-entry
))

;; agenda
(map! :leader (:prefix-map ("a" . "agenda")
                :desc "Open 'school' agenda"       "s" (lambda () (interactive) (open-agenda-file 0))
                :desc "Open 'projects' agenda"     "p" (lambda () (interactive) (open-agenda-file 1))
                :desc "Open 'appointments' agenda" "a" (lambda () (interactive) (open-agenda-file 2))
                :desc "Open 'other' agenda"        "o" (lambda () (interactive) (open-agenda-file 3))
))

;; window
(map! (:map evil-window-map
                :desc "Other window"                             "SPC" #'other-window
                :desc "Open file in new vertically split window"   "a" #'open-file-in-new-window
                :desc "Open file in new horizontally split window" "A" #'open-file-in-new-h-window
                :desc "Resize window to frame width fraction"      "f" #'resize-window-to-width-fraction
                :desc "Resize window to frame height fraction"     "F" #'resize-window-to-height-fraction

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                               Functions                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun open-file-in-new-window ()
  "Opens a new window with the selected file in it"
  (interactive)
  (evil-window-vsplit nil (read-file-name "File to open:"))
)

(defun open-file-in-new-h-window ()
  "Opens a new window (hsplit) with the selected file in it"
  (interactive)
  (evil-window-split nil (read-file-name "File to open:"))
)

(defun resize-window-to-width-fraction (fraction)
  "Resizes the current window to this fraction of the frame width"
  (interactive "P")
  (evil-window-set-width (/ (frame-width) fraction))
)

(defun resize-window-to-height-fraction (fraction)
  "Resizes the current window to this fraction of the frame height"
  (interactive "P")
  (evil-window-set-height (/ (frame-height) fraction))
)

(defun run-command-in-project-root (command)
  "Runs a command from the projects root, replacing '{bpath}' with the buffer file path"
  (projectile-with-default-dir (projectile-ensure-project (projectile-project-root))
    (shell-command (s-replace "{bpath-noext}" (file-name-sans-extension buffer-file-name)
                   (s-replace "{bpath}" (buffer-file-name) command))))
)

(defun open-agenda-file (index)
  "Opens an org agenda file from the org-agenda-files list"
  (evil-window-vsplit nil (nth index org-agenda-files))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                             Other Behaviour                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Autocompletion
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;; Journal
(setq org-journal-dir "~/docs/journal")

;; PlantUML
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(setq org-plantuml-jar-path (expand-file-name "/opt/plantuml/plantuml.jar"))

;; Source Code with colors
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-src-fontify-natively t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))


;; Reveal.js (org-reveal)
(setq org-reveal-mathjax-url "/usr/share/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML")

;; Agenda
(setq org-agenda-files (list "~/docs/agenda/school.org"
                             "~/docs/agenda/projects.org"
                             "~/docs/agenda/appointments.org"
                             "~/docs/agenda/other.org"))

;; Org-Todo
(setq org-todo-keywords
      '((sequence "TODO" "INPROGRESS" "TEST" "FEEDBACK" "|" "DONE" "NOPE")))

(provide 'config)
;;; config.el ends here
