(dolist (hook '(clojure-mode-hook
                lisp-mode-hook
                scheme-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook (lambda () (eldoc-mode 1)))
  (add-hook hook (lambda () (enable-paredit-mode)))
  (add-hook hook (lambda () (auto-highlight-symbol-mode 1))))

(setq inf-clojure-generic-cmd "clojure"
      inf-clojure-tools-deps-cmd "clojure"
      inf-clojure-project-type "tools.deps")

(add-hook 'clojure-mode-hook #'cider-mode)
