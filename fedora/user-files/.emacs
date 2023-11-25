;; .emacs

(custom-set-variables
 ;; uncomment to always end a file with a newline
 ;'(require-final-newline t)
 ;; uncomment to disable loading of "default.el" at startup
 ;'(inhibit-default-init t)
 ;; default to unified diffs
 '(diff-switches "-u")
 '(electric-pair-mode t)

 ;; More stuff
 '(column-number-mode t)
 '(custom-enabled-themes '(manoj-dark))
 '(desktop-save-mode t)
 '(icomplete-mode t)
 '(indent-tabs-mode nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ;; ("melpa" . "https://melpa.org/packages/")
     ))
 '(global-whitespace-mode t)
 '(whitespace-style
   '(face trailing tabs lines-tail empty space-after-tab space-before-tab tab-mark))
 )

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;; Install some useful plugins for Python development
(mapc
 'package-install
 '(eglot pyvenv company markdown-mode)
 )

;; Use Eglot for Python LSP
(add-hook 'python-mode-hook 'eglot-ensure)
