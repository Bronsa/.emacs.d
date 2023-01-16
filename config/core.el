(defmacro define-obsolete-variable-alias (obsolete-name current-name &optional when docstring)
  "Make OBSOLETE-NAME a variable alias for CURRENT-NAME and mark it obsolete.
WHEN should be a string indicating when the variable was first
made obsolete, for example a date or a release number.
This macro evaluates all its parameters, and both OBSOLETE-NAME
and CURRENT-NAME should be symbols, so a typical usage would look like:
  (define-obsolete-variable-alias 'foo-thing 'bar-thing \"27.1\")
This macro uses `defvaralias' and `make-obsolete-variable' (which see).
See the Info node `(elisp)Variable Aliases' for more details.
If CURRENT-NAME is a defcustom or a defvar (more generally, any variable
where OBSOLETE-NAME may be set, e.g. in an init file, before the
alias is defined), then the define-obsolete-variable-alias
statement should be evaluated before the defcustom, if user
customizations are to be respected.  The simplest way to achieve
this is to place the alias statement before the defcustom (this
is not necessary for aliases that are autoloaded, or in files
dumped with Emacs).  This is so that any user customizations are
applied before the defcustom tries to initialize the
variable (this is due to the way `defvaralias' works).
For the benefit of Customize, if OBSOLETE-NAME has
any of the following properties, they are copied to
CURRENT-NAME, if it does not already have them:
`saved-value', `saved-variable-comment'."
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
  "Make OBSOLETE-FACE a face alias for CURRENT-FACE and mark it obsolete.
WHEN should be a string indicating when the face was first made
obsolete, for example a date or a release number."
  `(progn (put ,obsolete-face 'face-alias ,current-face)
	  (put ,obsolete-face 'obsolete-face (or (purecopy ,when) t))))

(defmacro define-obsolete-function-alias (obsolete-name current-name &optional when docstring)
  "Set OBSOLETE-NAME's function definition to CURRENT-NAME and mark it obsolete.
\(define-obsolete-function-alias \\='old-fun \\='new-fun \"22.1\" \"old-fun's doc.\")
is equivalent to the following two lines of code:
\(defalias \\='old-fun \\='new-fun \"old-fun's doc.\")
\(make-obsolete \\='old-fun \\='new-fun \"22.1\")
WHEN should be a string indicating when the function was first
made obsolete, for example a date or a release number.
See the docstrings of `defalias' and `make-obsolete' for more details."
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
        ;; clojure-mode
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
        ;; align-cljlet
        auto-highlight-symbol
        ;; cider
        ;; cider-eval-sexp-fu
        ;; cider-scratch
        ;; clj-refactor
        color-theme
        company
        csv-mode
        diff-hl-flydiff
        diff-hl-margin
        dockerfile-mode
        ;; editorconfig
        ;; elm-mode
        ;; erc-services
        ;; ggtags
        git-timemachine
        ;; haskell-mode
        iedit
        ;; inf-shen
        ;; inf-clojure
        ;; less-css-mode
        magit
        ;;magithub
        markdown-mode
        merlin
        merlin-company
        ;; mpc
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
        ;; shen-mode

        smex
        ;; smtpmail-async
        string-inflection
        sql
        tabbar
        tuareg
        undo-tree
        uniquify
        ;; web-mode
        wgrep
        yasnippet
        yaml-mode))

(dolist (lib required-libs)
  (require lib))

(setq config-files
      '(;; lisp
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
