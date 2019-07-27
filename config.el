;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq
 +doom-dashboard-banner-dir doom-private-dir
 +doom-dashboard-banner-file "emacs-logo.png"
)

;; Visuals
(menu-bar-mode 1)      ;; enable the menu bar
(toggle-scroll-bar -1) ;; disable scroll bar

;; Go
(defun cfg-go-mode-hook ()
  "Hook for go mode"
  (add-hook 'before-save-hook 'gofmt-before-save) ;; format before saving

  ;; compile & run (SPC c c)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
)
(add-hook 'go-mode-hook 'cfg-go-mode-hook)
