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
 '(safe-local-variable-values
   (quote
    ((eval define-clojure-indent
           (assoc 1)
           (dissoc 1)
           (lazy-seq 0)
           (db-transaction 1)
           (GET
            (quote defun))
           (DELETE
            (quote defun))
           (PUT
            (quote defun))
           (POST
            (quote defun))
           (ANY
            (quote defun))
           (context
            (quote defun))
           (routes
            (quote defun))
           (facts
            (quote defun))
           (fact
            (quote defun))
           (try+ 0)
           (doto-let 1)
           (match 1)
           (mlet 1))
     (cider-refresh-after-fn . "yoyo/start!")
     (cider-refresh-before-fn . "yoyo/stop!")
     (cider-cljs-repl . "(user/cljs-repl user/foo-system)")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
