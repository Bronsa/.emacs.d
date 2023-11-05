(defmacro define-obsolete-variable-alias (obsolete-name current-name &optional when docstring)
  (declare (doc-string 4)
	   (advertised-calling-convention
	    (obsolete-name current-name when &optional docstring) "23.1"))
  `(progn
     (defvaralias ,obsolete-name ,current-name ,docstring)
     (dolist (prop '(saved-value saved-variable-comment))
       (and (get ,obsolete-name prop)
	    (null (get ,current-name prop))
	    (put ,current-name prop (get ,obsolete-name prop))))
     (make-obsolete-variable ,obsolete-name ,current-name ,when)))

(defmacro define-obsolete-face-alias (obsolete-face current-face &optional when)
  `(progn (put ,obsolete-face 'face-alias ,current-face)
	  (put ,obsolete-face 'obsolete-face (or (purecopy ,when) t))))

(defmacro define-obsolete-function-alias (obsolete-name current-name &optional when docstring)
  (declare (doc-string 4))
  `(progn (defalias ,obsolete-name ,current-name ,docstring)
	  (make-obsolete ,obsolete-name ,current-name ,when)))

(setq config-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(defun load-config-file (f)
  (load-file (concat config-dir f)))

(setq load-paths
      '(adoc-mode
        align-cljlet
        apiwrap
        async
        auto-highlight-symbol
        ;; cider
        ;; cider-eval-sexp-fu
        ;; clj-refactor
        clojure-mode
        color-theme
        company
        compat
        csv-mode
        dash ;; cider
        dockerfile-mode
        diff-hl
        editorconfig-emacs
        eldoc
        flymake
        eglot
        edn ;; clj-refactor
        epl ;; cider
        eval-sexp-fu
        external-completion
        f
        flycheck
        flycheck-ocaml
        flycheck-popup-tip
        ggtags
        graphql
        haskell-mode
        hcl-mode
        highlight ;; yasnippet
        hydra ;; clj-refactor
        ht
        ido-completing-read-plus
        iedit
        imandra-mode
        imenu-anywhere
        inf-clojure
        ipl-mode
        jsonrpc
        less-css-mode
        ;; lsp-mode
        markdown-mode
        markup-faces
        magithub
        magit/lisp
        merlin/emacs
        merlin-eldoc
        multiple-cursors ;; clj-refactor
        neotree
        nix-mode
        ocamlformat/emacs
        olivetti
        opam-switch-mode
        ocp-indent/tools
        paredit
        ;; peg ;; clj-refactor
        ;; pg/generic
        prettier
        project
        projectile
        pkg-info ;; cider
        popup
        popwin
        queue
        reason-mode
        rust-mode
        s
        seq
        sesman
        shen-mode
        smex
        string-inflection
        spinner ;; cider
        terraform-mode
        transient/lisp
        treepy
        tabbar
        tuareg
        timemachine
        undo-tree
        web-mode
        wgrep
        with-editor/lisp
        yaml-mode
        yasnippet
        ))

(dolist (path load-paths)
  (add-lib-path (symbol-name path)))

(setq required-libs
      '(adoc-mode
        async
        align-cljlet
        auto-highlight-symbol
        ;; cider
        ;; cider-eval-sexp-fu
        ;; cider-scratch
        ;; clj-refactor
        clojure-mode
        color-theme
        company
        ;; csv-mode
        diff-hl-flydiff
        diff-hl-margin
        dockerfile-mode
        flymake
        project
        eglot
        ;; editorconfig
        ;; erc-services
        flycheck-ocaml
        flycheck-popup-tip
        ;; ggtags
        git-timemachine
        ;; haskell-mode
        ido-completing-read+
        iedit
        imandra-mode
        imandra-mode-merlin
        imandra-mode-ocamlformat
        imenu-anywhere
        ipl-mode
        ;; lsp
        ;; inf-shen
        ;; inf-clojure
        ;; less-css-mode
        magit
        ;;magithub
        markdown-mode
        merlin
        merlin-company
        merlin-eldoc
        merlin-imenu
        ;; mpc
        multiple-cursors
        neotree
        nix-mode
        ocamlformat
        olivetti
        opam-switch-mode
        ocp-indent
        paredit
        paren
        prettier-js
        projectile
        ;;proof-site
        popwin
        reason-mode
        ;;rust-mode
        saveplace
        ;; shen-mode
        smex
        ;; smtpmail-async
        string-inflection
        sql
        tabbar
        terraform-mode
        tuareg
        undo-tree
        uniquify
        ;; web-mode
        wgrep
        yasnippet
        yaml-mode))

(dolist (lib required-libs)
  (message "Loading %s" lib)
  (require lib))

(setq config-files
      '(lisp
        global-modes
        misc
        ;; erc
        ;; mpc
        look-and-feel
        tabbar
        bindings
        defuns
        java))

(dolist (config-file config-files)
  (load-config-file (concat (symbol-name config-file) ".el")))
