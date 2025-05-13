	;; (toggle-debug-on-error)

(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq dotfiles-lib-dir (concat dotfiles-dir "libs/"))
(setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))

(defun add-dotfile-path (p)
  (add-to-list 'load-path (concat dotfiles-dir p)))

(defun add-lib-path (p)
  (add-to-list 'load-path (concat dotfiles-lib-dir p)))

(defun load-dotfile (f)
  (load-file (concat dotfiles-dir f)))

(add-dotfile-path "libs")

(load-dotfile "config/core.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-dabbrev-other-buffers nil)
 '(erc-modules
   '(autojoin track completion irccontrols log netsplit match noncommands readonly stamp autoaway log scrolltobottom fill truncate ring networks move-to-prompt))
 '(flycheck-checker-error-threshold nil)
 '(flycheck-popup-tip-error-prefix "! ")
 '(safe-local-variable-values
   '((elisp-lint-indent-specs
      (if-let* . 2)
      (when-let* . 1)
      (let* . defun)
      (nrepl-dbind-response . 2)
      (cider-save-marker . 1)
      (cider-propertize-region . 1)
      (cider-map-repls . 1)
      (cider--jack-in . 1)
      (cider--make-result-overlay . 1)
      (insert-label . defun)
      (insert-align-label . defun)
      (insert-rect . defun)
      (cl-defun . 2)
      (with-parsed-tramp-file-name . 2)
      (thread-first . 0)
      (thread-last . 0)
      (transient-define-prefix . defmacro)
      (transient-define-suffix . defmacro))
     (cljr-print-right-margin . 118)
     (cljr-insert-newline-after-require . t)
     (cljr-favor-prefix-notation)
     (eval define-clojure-indent
           (l/matcha
            '(1
              (:defn)))
           (l/matche
            '(1
              (:defn)))
           (p.types/def-abstract-type
            '(1
              (:defn)))
           (p.types/defprotocol+
            '(1
              (:defn)))
           (p.types/defrecord+
            '(2 nil nil
                (:defn)))
           (p.types/deftype+
            '(2 nil nil
                (:defn)))
           (p/def-map-type
            '(2 nil nil
                (:defn)))
           (p/defprotocol+
            '(1
              (:defn)))
           (p/defrecord+
            '(2 nil nil
                (:defn)))
           (p/deftype+
            '(2 nil nil
                (:defn)))
           (tools.macro/macrolet
            '(1
              ((:defn))
              :form)))
     (eval put 'mu/defn 'clojure-doc-string-elt 2)
     (eval put 'mr/def 'clojure-doc-string-elt 2)
     (eval put 'mi/define-batched-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'mi/define-simple-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'methodical/defmulti 'clojure-doc-string-elt 2)
     (eval put 'methodical/defmethod 'clojure-doc-string-elt 3)
     (eval put 'p.types/defprotocol+ 'clojure-doc-string-elt 2)
     (eval put 's/defn 'clojure-doc-string-elt 2)
     (eval put 'setting/defsetting 'clojure-doc-string-elt 2)
     (eval put 'defsetting 'clojure-doc-string-elt 2)
     (eval put 'api.macros/defendpoint 'clojure-doc-string-elt 3)
     (eval put 'define-premium-feature 'clojure-doc-string-elt 2)
     (ftf-project-finders ftf-get-top-git-dir)
     (project-vc-merge-submodules)
     (eval tuareg-opam-update-env
           (projectile-project-root))
     (projectile-project-type . "make")
     (Syntax . Common-lisp)
     (Package . XREF)
     (eval define-clojure-indent
           (lazy-seq 0)
           (match 1)
           (try+ 0)
           (pdoseq 2))
     (eval define-clojure-indent
           (lazy-seq 0)
           (match 1)
           (try+ 0))
     (eval define-clojure-indent
           (lazy-seq 0)
           (match 1)
           (try+ 0)
           (deftype 'defun))
     (checkdoc-package-keywords-flag)
     (bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)")
     (js2-basic-offset . 2)
     (js-indent-level . 2)
     (css-indent-offset . 2)
     (cider-cljs-lein-repl . "(user/cljs-repl)")
     (nameless-current-name . "cider")
     (nameless-affect-indentation-and-filling)))
 '(transient-show-popup 1))

(customize-set-variable 'magit-ellipsis '((t (nil . " …"))))
(customize-set-variable 'magit-section-visibility-indicator '(" …" t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completions-common-part ((t (:foreground "color-27"))))
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "color-33" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-33" :weight bold))))
 '(diff-refine-added ((t (:inherit diff-refine-change :background "color-22"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "color-52"))))
 '(ediff-even-diff-C ((t (:background "color-238"))))
 '(ediff-odd-diff-C ((t (:background "color-239"))))
 '(eshell-ls-directory ((t (:foreground "Blue"))))
 '(help-key-binding ((t (:inherit fixed-pitch :foreground "color-245"))))
 '(highlight ((t (:background "#1f1f1f"))))
 '(magit-branch-current ((t (:inherit magit-branch-local))))
 '(magit-branch-remote-head ((t (:inherit magit-branch-remote :underline "color-23"))))
 '(magit-diff-base ((t (:foreground "yellow"))))
 '(magit-diff-base-highlight ((t (:foreground "yellow"))))
 '(magit-signature-good ((t (:foreground "color-121"))))
 '(markup-complex-replacement-face ((t (:inherit markup-meta-face :foreground "purple3" :box (:line-width 2 :style released-button)))))
 '(markup-gen-face ((t (:foreground "color-25"))))
 '(markup-list-face ((t (:inherit markup-meta-face :foreground "color-125"))))
 '(markup-secondary-text-face ((t (:inherit markup-gen-face :foreground "brightred" :height 0.8))))
 '(markup-table-face ((t (:inherit markup-meta-face :foreground "royal blue"))))
 '(markup-verbatim-face ((t nil)))
 '(neo-dir-link-face ((t (:foreground "color-27"))))
 '(neo-file-link-face ((t (:foreground "white"))))
 '(org-block ((t (:inherit shadow :foreground "color-252"))))
 '(popup-tip-face ((t (:background "brightblack" :foreground "white"))))
 '(secondary-selection ((t (:underline t))))
 '(shadow ((t (:foreground "color-242"))))
 '(transient-active-infix ((t (:underline t :weight ultra-bold))))
 '(tuareg-font-lock-extension-node-face ((t (:inherit tuareg-font-lock-infix-extension-node-face))))
 '(tuareg-font-lock-interactive-output-face ((t (:foreground "color-153"))))
 '(tuareg-font-lock-operator-face ((t (:foreground "color-130"))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "color-250" :weight bold)))))

(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(delete-file (expand-file-name "~/.emacs.d/init.elc"))

(put 'overwrite-mode 'disabled nil)
