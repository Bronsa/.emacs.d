(setq config-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(defun load-config-file (f)
  (load-file (concat config-dir f)))

(setq load-paths
      '(adoc-mode
        align-cljlet
        apiwrap
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
        dockerfile-mode
        diff-hl
        editorconfig-emacs
        edn ;; clj-refactor
        elm-mode
        epl ;; cider
        eval-sexp-fu
        f ;; elm-mode
        ggtags
        ghub
        ghub-plus
        graphql
        haskell-mode
        highlight ;; yasnippet
        hydra ;; clj-refactor
        iedit
        inf-clojure
        less-css-mode
        markdown-mode
        markup-faces
        magit-popup
        magithub
        magit/lisp
        merlin/emacs
        multiple-cursors ;; clj-refactor
        olivetti
        ocp-indent/tools
        paredit
        peg ;; clj-refactor
        pg/generic
        prettier
        projectile
        pkg-info ;; cider
        popwin
        queue ;; cider
        reason-mode
        s ;; clj-refactor
        sesman
        shen-mode
        smex
        string-inflection
        spinner ;; cider
        treepy
        tabbar
        tuareg
        timemachine
        undo-tree
        web-mode
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
        dockerfile-mode
        editorconfig
        elm-mode
        erc-services
        ggtags
        git-timemachine
        haskell-mode
        iedit
        inf-shen
        inf-clojure
        less-css-mode
        magit
        ;;magithub
        markdown-mode
        merlin
        merlin-company
        mpc
        multiple-cursors
        olivetti
        ocp-indent
        paredit
        paren
        prettier-js
        projectile
                                        ;proof-site
        popwin
        reason-mode
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
        web-mode
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
        java))

(dolist (config-file config-files)
  (load-config-file (concat (symbol-name config-file) ".el")))
