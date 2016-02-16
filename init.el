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
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(safe-local-variable-values
   (quote
    ((js2-basic-offset . 2)
     (js-indent-level . 2)
     (css-indent-offset . 2)
     (eval define-clojure-indent
           (mlet 1)
           (lazy-seq 0)
           (match 1)
           (try+ 0))
     (cider-cljs-lein-repl . "(user/cljs-repl)")
     (cider-refresh-after-fn . "bounce.core/start!")
     (cider-refresh-before-fn . "bounce.core/stop!")
     (nameless-current-name . "cider")
     (nameless-affect-indentation-and-filling)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
