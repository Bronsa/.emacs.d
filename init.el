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
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(safe-local-variable-values
   (quote
    ((cider-cljs-lein-repl . "(user/cljs-repl)")
     (eval define-clojure-indent
           (lazy-seq 0)
           (match 1)
           (try+ 0))
     (cider-refresh-after-fn . "bounce.core/start!")
     (cider-refresh-before-fn . "bounce.core/stop!")
     (nameless-current-name . "cider")
     (nameless-affect-indentation-and-filling)))))
