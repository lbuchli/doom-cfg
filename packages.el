;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;;; Code:
(package! verilog-mode       :recipe (:repo "veripool/verilog-mode"))
(package! company-go         :recipe (:repo "emacsmirror/company-go"))
(package! bison-mode         :recipe (:repo "Wilfred/bison-mode"))
(package! gorepl-mode        :recipe (:repo "manute/gorepl-mode"))
;; TODO check if working ~ 2020-03-15 (package! org-roam           :recipe (:host github :repo "jethrokuan/org-roam" :branch "develop"))

;;(package! telan-mode :recipe (:repo "lbuchli/telan-mode"))

(package! yasnippet-snippets)
(package! org-journal)
(package! plantuml-mode)
(package! org-re-reveal)
(package! zetteldeft)

(provide 'packages)
;;; packages.el ends here
