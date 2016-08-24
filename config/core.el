(setq config-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(defun load-config-file (f)
  (load-file (concat config-dir f)))

(setq load-paths
      '(adoc-mode
        align-cljlet
        async
        auto-highlight-symbol
        cider
        cider-eval-sexp-fu
        clj-refactor
        clojure-mode
        color-theme
        company
        csv-mode
        dash ;; cider
        diff-hl
        edn ;; clj-refactor
        epl ;; cider
        eval-sexp-fu
        ggtags
        highlight ;; yasnippet
        hydra ;; clj-refactor
        less-css-mode
        markup-faces
        magit/lisp
        multiple-cursors ;; clj-refactor
        paredit
        peg ;; clj-refactor
        projectile
        pkg-info ;; cider
        popwin
        queue ;; cider
        s ;; clj-refactor
        smex
        spinner ;; cider
        tabbar
        timemachine
        undo-tree
        wgrep
        with-editor
        yasnippet
        ))

(dolist (path load-paths)
  (add-lib-path (symbol-name path)))

(setq required-libs
      '(adoc-mode
        align-cljlet
        auto-highlight-symbol
        cider
        cider-eval-sexp-fu
        cider-scratch
        clj-refactor
        color-theme
        company
        csv-mode
        diff-hl-flydiff
        diff-hl-margin
        erc-services
        ggtags
        git-timemachine
        less-css-mode
        magit
        mpc
        multiple-cursors
        paredit
        paren
        projectile
        popwin
        saveplace
        smex
        smtpmail-async
        sql
        tabbar
        undo-tree
        uniquify
        wgrep
        yasnippet
        ))

(dolist (lib required-libs)
  (require lib))

(setq config-files
      '(lisp
        global-modes
        misc
        erc
        mpc
        look-and-feel
        tabbar
        bindings
        defuns
        java
        superstore))

(dolist (config-file config-files)
  (load-config-file (concat (symbol-name config-file) ".el")))
