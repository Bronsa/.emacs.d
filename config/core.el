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

(advice-add 'custom-handle-keyword :around
            (lambda (orig-fun symbol keyword value type)
              (if (eq keyword :local)
                  (make-variable-buffer-local symbol)
                (apply orig-fun (list symbol keyword value type)))))

(defmacro setq-local (&rest pairs)
  "Make each VARIABLE buffer-local and assign to it the corresponding VALUE.

The arguments are variable/value pairs.  For each VARIABLE in a pair,
make VARIABLE buffer-local and assign to it the corresponding VALUE
of the pair.  The VARIABLEs are literal symbols and should not be quoted.

The VALUE of the Nth pair is not computed until after the VARIABLE
of the (N-1)th pair is set; thus, each VALUE can use the new VALUEs
of VARIABLEs set by earlier pairs.

The return value of the `setq-local' form is the VALUE of the last
pair.

\(fn [VARIABLE VALUE]...)"
  (declare (debug setq))
  (unless (zerop (mod (length pairs) 2))
    (error "PAIRS must have an even number of variable/value members"))
  (let ((expr nil))
    (while pairs
      (unless (symbolp (car pairs))
        (error "Attempting to set a non-symbol: %s" (car pairs)))
      ;; Can't use backquote here, it's too early in the bootstrap.
      (setq expr
            (cons
             (list 'set
                   (list 'make-local-variable (list 'quote (car pairs)))
                   (car (cdr pairs)))
             expr))
      (setq pairs (cdr (cdr pairs))))
    (macroexp-progn (nreverse expr))))

(setq config-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(defun load-config-file (f)
  (load-file (concat config-dir f)))



(setq load-paths
      '(
        apiwrap
        async
        auto-highlight-symbol
        clojure-mode
        color-theme
        company
        compat
        csv-mode
	    dash
        dockerfile-mode
        dune/editor-integration/emacs
        diff-hl
        editorconfig-emacs
        emacs-dune-format
        emacs-reformatter
        eldoc
        flymake
        eglot
        eval-sexp-fu
        external-completion
        f
        flycheck
        flycheck-ocaml
        flycheck-popup-tip
        flycheck-eglot
        ggtags
        graphql
        haskell-mode
        hcl-mode
        highlight ;; yasnippet
        ht
        ido-completing-read-plus
        iedit
        imandra-mode
        imenu-anywhere
        inf-clojure
        ipl-mode
        jsonrpc
        less-css-mode
        markdown-mode
        markup-faces
        magithub
        magit/lisp
        merlin/emacs
        merlin-eldoc
        multiple-cursors
        neotree
        nix-mode
        ocamlformat/emacs
        olivetti
        opam-switch-mode
        ocp-indent/tools
        paredit
        project
        projectile
        popup
        popwin
        queue
        reason-mode
        rust-mode
        s
        seq
        sesman
        smex
        string-inflection
        terraform-mode
        transient/lisp
        treepy
        tabbar
        tuareg
        timemachine
        undo-tree
	    with-editor/lisp
        wgrep
        yaml-mode
        yasnippet
        ))

(dolist (path load-paths)
  (add-lib-path (symbol-name path)))

(setq required-libs
      '(async
        auto-highlight-symbol
        clojure-mode
        color-theme
        company
        diff-hl-flydiff
        diff-hl-margin
        dockerfile-mode
        dune
        flymake
        project
        eglot
        dune-format
        flycheck-ocaml
        flycheck-eglot
        flycheck-popup-tip
        git-timemachine
        ido-completing-read+
        iedit
        imandra-mode
        imandra-mode-merlin
        imandra-mode-ocamlformat
        imenu-anywhere
        inf-clojure
        ipl-mode
        magit
        markdown-mode
        merlin
        merlin-company
        merlin-eldoc
        merlin-imenu
        multiple-cursors
        neotree
        nix-mode
        ocamlformat
        olivetti
        opam-switch-mode
        ocp-indent
        paredit
        paren
        projectile
        popwin
        reason-mode
        rust-mode
        saveplace
        smex
        string-inflection
        sql
        tabbar
        terraform-mode
        tuareg
        undo-tree
        uniquify
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
