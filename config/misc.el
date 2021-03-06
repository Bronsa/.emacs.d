(fset 'yes-or-no-p 'y-or-n-p)

(setq byte-compile-warnings nil)

(setq create-lockfiles nil)

;; use utf-8
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;; backup & auto-save
(make-directory "~/.emacs.d/tmp/.autosaves/" t)
(make-directory "~/.emacs.d/tmp/.backups/" t)

(setq-default
 backup-by-copying t
 backup-directory-alist '(("" . "~/.emacs.d/tmp/.backups/"))
 auto-save-file-name-transforms `((".*"  "~/.emacs.d/tmp/.autosaves//\\1" t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;;saveplace
(setq-default
 save-place t
 save-place-file "~/.emacs.d/.saved-places")

(auto-compression-mode 1)

(setq-default

 company-idle-delay nil
 company-minimum-prefix-length 0
 company-selection-wrap-around t
 company-tooltip-align-annotations t
 company-tooltip-limit 16
 company-require-match nil

 auto-revert-use-notify t

 font-lock-maximum-decoration t
 font-lock-maximum-size nil

 ;; font-lock-support-mode 'jit-lock-mode

 yas-snippet-dirs ()

 recentf-max-menu-items 25

 abbrev-mode t
 abbrev-file-name (concat dotfiles-dir "abbrevs.el")
 save-abbrevs nil

 require-final-newline t
 next-line-add-newlines nil

 ;; vc-follow-symlinks t

 ido-create-new-buffer 'always

 case-fold-search t

 indent-tabs-mode nil
 tab-width 4
 indent-line-function 'insert-tab
 tab-always-indent 'complete

 default-major-mode 'text-mode

 display-time-24hr-format t
 display-time-day-and-date t

 ;; version-control t
 diff-switches "-u"

 completion-ignore-case t

 scroll-error-top-bottom t

 magit-prefer-remote-upstream t
 magit-push-current-set-remote-if-missing nil
 magit-revert-buffers 'silent
 magit-diff-unmarked-lines-keep-foreground nil
 magit-keep-region-overlay t
 magit-fetch-arguments '("--prune")
 magit-log-arguments '("--graph" "--color" "--decorate" "--show-signature" "-n100")
 magit-merge-arguments '("--no-ff")
 magit-rebase-arguments '("--preserve-merges")
 magit-branch-read-upstream-first t
 magit-push-always-verify nil

 magit-save-repository-buffers 'dontask

 git-commit-fill-column nil

 projectile-enable-caching t
 projectile-use-git-grep t
 git-commit-finish-query-functions ())

(magit-add-section-hook 'magit-status-sections-hook
                        #'magit-insert-recent-commits
                        #'magit-insert-unpushed-commits
                        t)

(quietly-read-abbrev-file)
(smex-initialize)

(defalias 'byte-compile-cl-warn 'identity)

(put 'overwrite-mode 'disabled t)

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . git-commit-mode))

(setq magit-last-seen-setup-instructions "1.4.0")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ggtags-split-window-function (lambda () (interactive)))
(push '("*ggtags-global*" :noselect tn) popwin:special-display-config)
(push '("*cider-doc*" :noselect tn) popwin:special-display-config)

(setq uniquify-buffer-name-style 'forward)

(setq browse-url-browser-function 'eww-browse-url)

(setq ns-right-alternate-modifier nil)

(require 'mouse)

(global-set-key [mouse-4] (lambda ()
                            (interactive)
                            (scroll-down 1)))

(global-set-key [mouse-5] (lambda ()
                            (interactive)
                            (scroll-up 1)))

(add-hook 'after-make-frame-functions (lambda (&optional frame) (xterm-mouse-mode t)))
(advice-add 'save-buffers-kill-terminal :before (lambda (&optional args) (xterm-mouse-mode -1)))
(advice-add 'save-buffers-kill-terminal :after (lambda (&optional args) (xterm-mouse-mode t)))

(setq ring-bell-function 'ignore)

(setq css-indent-offset 2
      js-indent-level 2
      c-basic-offset 2
      sql-indent-offset 2)

(remove-hook 'find-file-hooks 'vc-find-file-hook)


(advice-add 'kill-new :around
            (lambda (k str &rest args)
              (let ((process-connection-type nil))
                (let ((proc (start-process "clip.exe" "*copy*" "clip.exe")))
                  (process-send-string proc str)
                  (process-send-eof proc)))
              (apply k str args)))

(add-to-list 'auto-mode-alist '("\\.adoc\\'"  . adoc-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.[i]?ml[ip]?\\'" . tuareg-mode))


(defun rename-current-buffer-file ()
  (interactive)
  (let* ((old-name (buffer-file-name))
         (_ (unless (and old-name (file-exists-p old-name))
              (error "Buffer '%s' is not visiting a file" (buffer-name))))
         (new-name (read-file-name "New name: " old-name)))
    (when (get-buffer new-name)
      (error "A buffer named '%s' already exists" new-name))
    (rename-file old-name new-name 1)
    (rename-buffer new-name)
    (set-visited-file-name new-name)
    (set-buffer-modified-p nil)
    (message "File '%s' successfully renamed to '%s'" old-name (file-name-nondirectory new-name))))

(defun delete-current-buffer-file ()
  (interactive)
  (let* ((old-name (buffer-file-name)))
    (unless (and old-name (file-exists-p old-name))
      (error "Buffer '%s' is not visiting a file" (buffer-name)))
    (when (yes-or-no-p "Are you sure you want to remove this file? ")
      (delete-file (buffer-file-name))
      (kill-buffer (current-buffer))
      (message "File '%s' successfully removed" old-name))))

(defun copy-buffer-name ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(add-hook 'tuareg-mode-hook (lambda () (abbrev-mode -1)  (ocp-setup-indent)))
(add-hook 'tuareg-interactive-mode-hook (lambda () (abbrev-mode -1)))

(setq tuareg-indent-align-with-first-arg t)
(setq tuareg-match-patterns-aligned t)
(setq elm-format-on-save t)
(setq elm-tags-on-save t)
(add-to-list 'company-backends 'company-elm)

(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
(setq merlin-command 'opam)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(setq org-src-fontify-natively t)
(setq magit-diff-refine-hunk t)

;;; (magithub-feature-autoinject t)
;;; (setq magithub-clone-default-directory "~/github")

(setq olivetti-body-width 86)


(defun shell-cmd (cmd)
  "Returns the stdout output of a shell command or nil if the command returned
   an error"
  (car (ignore-errors (apply 'process-lines (split-string cmd)))))

(defun reason-cmd-where (cmd)
  (let ((where (shell-cmd cmd)))
    (if (not (string-equal "unknown flag ----where" where))
      where)))

(let* ((refmt-bin (or (reason-cmd-where "refmt ----where")
                      (shell-cmd "which refmt")))
       (merlin-bin (or (reason-cmd-where "ocamlmerlin ----where")
                       (shell-cmd "which ocamlmerlin")))
       (merlin-base-dir (when merlin-bin
                          (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
  ;; Add merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
  (when merlin-bin
    (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
    (setq merlin-command merlin-bin))

  (when refmt-bin
    (setq refmt-command refmt-bin)))

(require 'reason-mode)
(require 'merlin)
(add-hook 'reason-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(setq merlin-ac-setup t)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (when (string-match "\\.iml\\'" buffer-file-name)
              (setq-local merlin-buffer-flags "-reader imandra -package imandra-prelude -open Imandra_prelude"))))

(add-to-list 'safe-local-variable-values '(merlin-command . esy))
(add-to-list 'safe-local-variable-values '(refmt-command . esy))

(with-eval-after-load 'merlin
  (defun merlin-jump-to-type-definition ()
    (interactive)
    (let ((data (elt merlin-enclosing-types merlin-enclosing-offset)))
      (when (cddr data)
        (setq data (merlin--type-enclosing-text data))
        (merlin-locate-ident data)))))
