(setq config-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(defun load-config-file (f)
  (load-file (concat config-dir f)))

(setq load-paths
      '(align-cljlet
        async
        auto-highlight-symbol
        cider
        cider-eval-sexp-fu
        clj-refactor
        clojure-mode
        color-theme
        company
        dash ;; cider
        edn ;; clj-refactor
        epl ;; cider
        eval-sexp-fu
        highlight ;; yasnippet
        hydra ;; clj-refactor
        magit/lisp
        multiple-cursors ;; clj-refactor
        paredit
        peg ;; clj-refactor
        pkg-info ;; cider
        popwin
        queue ;; cider
        s ;; clj-refactor
        smex
        spinner ;; cider
        tabbar
        undo-tree
        yasnippet
        ))

(dolist (path load-paths)
  (add-lib-path (symbol-name path)))

(setq required-libs
      '(align-cljlet
        auto-highlight-symbol
        cider
        cider-eval-sexp-fu
        clj-refactor
        color-theme
        company
        erc-services
        magit
        mpc
        mu4e
        paredit
        paren
        popwin
        saveplace
        smex
        smtpmail-async
        tabbar
        undo-tree
        yasnippet
        ))

(dolist (lib required-libs)
  (require lib))

(setq config-files
      '(clojure
        global-modes
        misc
        mu4e
        erc
        mpc
        look-and-feel
        tabbar
        bindings
        defuns
        ))

(dolist (config-file config-files)
  (load-config-file (concat (symbol-name config-file) ".el")))
