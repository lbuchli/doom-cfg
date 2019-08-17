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
  ;; compile & run (SPC c c)
  (set (make-local-variable 'build-command) "gradle build" )
  (set (make-local-variable 'run-command)   "gradle run" )
  (set (make-local-variable 'test-command)  "gradle test" )
  (set (make-local-variable 'debug-command) "" )
)
(add-hook 'java-mode-hook 'cfg-java-mode-hook)

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

;; window
(map! (:map evil-window-map
                :desc "Other window" "SPC" #'other-window
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
  "Runs a command from the projects root"
  (interactive)
  (projectile-with-default-dir (projectile-ensure-project (projectile-project-root))
    (shell-command command))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                             Other Behaviour                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Autocompletion
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(provide 'config)
;;; config.el ends here
