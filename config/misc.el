(fset 'yes-or-no-p 'y-or-n-p)

(setq byte-compile-warnings nil)

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
(setq backup-by-copying t
      backup-directory-alist (list (cons ".*" (concat dotfiles-tmp-dir ".backups")))
      auto-save-list-file-prefix (concat dotfiles-tmp-dir ".autosaves")
      auto-save-file-name-transforms `((".*" ,(concat dotfiles-tmp-dir ".autosaves/\\1") t))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;saveplace
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/.saved-places")


(setq-default
 font-lock-maximum-decoration t
 font-lock-maximum-size nil

 recentf-max-menu-items 25

 abbrev-mode t
 abbrev-file-name (concat dotfiles-dir "abbrevs.el")
 save-abbrevs nil

 require-final-newline t
 next-line-add-newlines nil

 vc-follow-symlinks t

 ido-create-new-buffer 'always

 case-fold-search t

 indent-tabs-mode nil
 tab-width 4
 indent-line-function 'insert-tab
 tab-always-indent 'complete

 default-major-mode 'text-mode

 display-time-24hr-format t
 display-time-day-and-date t

 version-control t
 diff-switches "-u"

 completion-ignore-case t

 scroll-error-top-bottom t

 magit-revert-buffers 'silent
 magit-diff-unmarked-lines-keep-foreground nil
 magit-keep-region-overlay t
 magit-branch-read-upstream-first t
 magit-fetch-arguments '("--prune")
 magit-log-arguments '("--graph" "--color" "--decorate" "--show-signature" "-n100")
 magit-merge-arguments '("--no-ff")
 magit-push-always-verify nil

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

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))
(setq ring-bell-function 'ignore)
