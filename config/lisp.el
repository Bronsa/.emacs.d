(dolist (hook '(cider-mode-hook
                cider-repl-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook #'eldoc-mode)
  (add-hook hook #'paredit-mode)
  (add-hook hook #'auto-highlight-symbol-mode))

;; (dolist (hook '(cider-mode-hook cider-repl-mode-hook))
;;   (add-hook hook (lambda ()
;;                    (clj-refactor-mode 1)
;;                    (cljr-add-keybindings-with-prefix "C-c r"))))

(setq nrepl-log-messages nil
      cider-mode-line nil
      cider-prompt-for-symbol nil
      nrepl-hide-special-buffers t
      cider-repl-use-clojure-font-lock t
      cider-repl-use-pretty-printing t
      cider-repl-popup-stacktraces t
      cider-auto-select-error-buffer t
      cider-stacktrace-default-filters nil
      cider-stacktrace-fill-column nil
      cider-use-overlays nil
      cider-prompt-save-file-on-load 'always-save
      cider-font-lock-dynamically nil
      cider-lein-command "~/bin/lein"
      cljr-suppress-middleware-warnings t
      cljr-magic-requires nil
      cljr-eagerly-build-asts-on-startup nil)

;; enable cider even if no connection is available
(add-hook 'clojure-mode-hook #'cider-mode)
