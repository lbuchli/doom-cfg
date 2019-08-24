;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! verilog-mode       :recipe (:fetcher github :repo "veripool/verilog-mode"))
(package! company-go         :recipe (:fetcher github :repo "emacsmirror/company-go"))
(package! bison-mode         :recipe (:fetcher github :repo "Wilfred/bison-mode"))
(package! gorepl-mode        :recipe (:fetcher github :repo "manute/gorepl-mode"))

(package! yasnippet-snippets)
(package! org-journal)
(package! plantuml-mode)
