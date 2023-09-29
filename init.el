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
 '(erc-modules
   (quote
    (autojoin track completion irccontrols log netsplit match noncommands readonly stamp autoaway log scrolltobottom fill truncate ring networks move-to-prompt)))
 '(flycheck-popup-tip-error-prefix "! ")
 '(safe-local-variable-values
   (quote
    ((eval tuareg-opam-update-env
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
           (deftype
               (quote defun)))
     (checkdoc-package-keywords-flag)
     (bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)")
     (js2-basic-offset . 2)
     (js-indent-level . 2)
     (css-indent-offset . 2)
     (cider-cljs-lein-repl . "(user/cljs-repl)")
     (nameless-current-name . "cider")
     (nameless-affect-indentation-and-filling))))
 '(transient-show-popup 1))

(customize-set-variable 'magit-ellipsis '((t (nil . " …"))))
(customize-set-variable 'magit-section-visibility-indicator '(" …" t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "color-33" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-33" :weight bold))))
 '(diff-refine-added ((t (:inherit diff-refine-change :background "color-22"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "color-52"))))
 '(ediff-even-diff-C ((t (:background "color-238"))))
 '(ediff-odd-diff-C ((t (:background "color-239"))))
 '(eshell-ls-directory ((t (:foreground "Blue"))))
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
 '(tuareg-font-lock-interactive-output-face ((t (:foreground "color-153"))))
 '(tuareg-font-lock-operator-face ((t (:foreground "color-130"))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "color-250" :weight bold)))))

(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(delete-file (expand-file-name "~/.emacs.d/init.elc"))
