;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Visuals                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu-bar-mode 1)      ;; enable the menu bar
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Languages                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Go
(defun cfg-go-mode-hook ()
  "Hook for go mode"
  (add-hook 'before-save-hook 'gofmt-before-save) ;; format before saving

  ;; compile & run (SPC c c)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go test -v *.go && go vet *.go; echo ; go run *.go"))
)
(add-hook 'go-mode-hook 'cfg-go-mode-hook)

;; Verilog
(setq
 verilog-simulator "verilator"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Keyboard Shortcuts                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General
(set-input-mode t nil t "ESC") ;; Quit (C-g) to ESC

;; code
(map! :leader (:prefix-map ("c" . "code")
                :desc "Comment out region" "o" #'comment-region
                :desc "Uncomment region"   "u" #'uncomment-region
))

;; Tab Bar
(map! :leader "a" 'tabbar-backward-tab)
(map! :leader "d" 'tabbar-forward-tab)

(provide 'config)
;;; config.el ends here
