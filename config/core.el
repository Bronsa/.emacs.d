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
        editorconfig-emacs
        edn ;; clj-refactor
        elm-mode
        epl ;; cider
        eval-sexp-fu
        f ;; elm-mode
        ggtags
        ghub
        haskell-mode
        highlight ;; yasnippet
        hydra ;; clj-refactor
        less-css-mode
        markup-faces
        magit-popup
        magit/lisp
        merlin/emacs
        multiple-cursors ;; clj-refactor
        paredit
        peg ;; clj-refactor
        projectile
        pkg-info ;; cider
        popwin
        queue ;; cider
        s ;; clj-refactor
        shen-mode
        smex
        string-inflection
        spinner ;; cider
        tabbar
        tuareg
        timemachine
        undo-tree
        wgrep
        with-editor
        yaml-mode
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
        editorconfig
        elm-mode
        erc-services
        ggtags
        git-timemachine
        haskell-mode
        inf-shen
        less-css-mode
        magit
        merlin
        merlin-company
        mpc
        multiple-cursors
        paredit
        paren
        projectile
        popwin
        saveplace
        shen-mode
        smex
        smtpmail-async
        string-inflection
        sql
        tabbar
        tuareg
        undo-tree
        uniquify
        wgrep
        yasnippet
        yaml-mode))

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
        imandra))

(dolist (config-file config-files)
  (load-config-file (concat (symbol-name config-file) ".el")))
