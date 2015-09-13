(dolist (hook '(cider-mode-hook
                cider-repl-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook #'eldoc-mode)
  (add-hook hook #'paredit-mode)
  (add-hook hook #'auto-highlight-symbol-mode)

  (add-hook hook (lambda ()
                   (dolist (el '(("(\\(fn\\)[[:space:]]"         . "ƒ")
                                 ("\\(partial\\)[[:space:]]"     . "Ƥ")
                                 ("\\(comp\\)[[:space:]]"        . "·")
                                 ("\\(#\\)("                     . "λ")
                                 ("\\(#\\)_("                    . "#")
                                 ("(\\(not\\)[[:space:]]"        . "¬")
                                 ("\\(->\\)[[:space:]]"          . "→")
                                 ("\\(->>\\)[[:space:]]"         . "⇉")
                                 ("\\(<=\\)[[:space:]]"          . "≤")
                                 ("\\(>=\\)[[:space:]]"          . "≥")
                                 ("\\(not=\\)[[:space:]]"        . "≠")
                                 ("\\(identical\\?\\)[[:space:]]". "≡")
                                 ("[^\\]?\\(~\\)"                . "˷")
                                 ("\\(contains\\?\\)[[:space:]]" . "∈")
                                 ("\\(every\\?\\)[[:space:]]"    . "∀")
                                 ("[^\\]?\\(%\\)"                . "¯")
                                 ("\\(true\\)"                   . "т")
                                 ("\\(false\\)"                  . "ғ")
                                 ("\\(nil\\)"                    . "∅")))

                     (font-lock-add-keywords nil `((,(car el)
                                                    (0 (progn (compose-region (match-beginning 1)
                                                                              (match-end 1)
                                                                              ,(cdr el))
                                                              nil)))))))))

(dolist (hook '(cider-mode-hook  cider-repl-mode-hook))
  (add-hook hook (lambda ()
                   (clj-refactor-mode 1)
                   (cljr-add-keybindings-with-prefix "C-c r"))))

(setq nrepl-log-messages nil
      nrepl-hide-special-buffers t
      cider-repl-use-clojure-font-lock t
      cider-repl-use-pretty-printing t
      cider-repl-popup-stacktraces t
      cider-auto-select-error-buffer t
      cider-stacktrace-default-filters nil
      cider-stacktrace-fill-column nil
      cider-use-overlays nil
      cider-prompt-save-file-on-load 'always-save
      cider-font-lock-dynamically nil)

(add-to-list 'auto-mode-alist '("\\.clj\\(s\\|c\\)?$" . clojure-mode))

;; enable cider even if no connection is available
(add-hook 'clojure-mode-hook #'cider-mode)
