(fset 'yes-or-no-p 'y-or-n-p)

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

 default-major-mode 'text-mode

 display-time-24hr-format t
 display-time-day-and-date t

 version-control t
 diff-switches "-u"

 completion-ignore-case t

 scroll-error-top-bottom t

 magit-revert-buffers 'silent
 magit-diff-unmarked-lines-keep-foreground nil
 magit-keep-region-overlay t)

(quietly-read-abbrev-file)
(smex-initialize)

(add-to-list 'completion-styles 'initials)

(defalias 'byte-compile-cl-warn 'identity)

(put 'overwrite-mode 'disabled t)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . git-commit-mode))

(setq magit-last-seen-setup-instructions "1.4.0")

(defadvice with-editor-finish (after delete-window activate)
  (magit-mode-bury-buffer))

(defadvice with-editor-cancel (after delete-window activate)
  (magit-mode-bury-buffer))

(defun javap-handler (op &rest args)
  "Handle .class files by putting the output of javap in the buffer."
  (cond
   ((eq op 'get-file-buffer)
    (let ((file (car args)))
      (with-current-buffer (create-file-buffer file)
        (call-process "javap" nil (current-buffer) nil "-verbose"
                      "-classpath" (file-name-directory file)
                      (file-name-sans-extension (file-name-nondirectory file)))
        (setq buffer-file-name file)
        (setq buffer-read-only t)
        (set-buffer-modified-p nil)
        (goto-char (point-min))
        (java-mode)
        (current-buffer))))
   ((javap-handler-real op args))))

(defun javap-handler-real (operation args)
  "Run the real handler without the javap handler installed."
  (let ((inhibit-file-name-handlers
         (cons 'javap-handler
               (and (eq inhibit-file-name-operation operation)
                    inhibit-file-name-handlers)))
        (inhibit-file-name-operation operation))
    (apply operation args)))

(add-to-list 'file-name-handler-alist '("\\.class$" . javap-handler))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'recentf-exclude "Gmail")

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(setq ggtags-split-window-function (lambda () (interactive)))
(push '("*ggtags-global*" :noselect tn) popwin:special-display-config)
(push '("*cider-doc*" :noselect tn) popwin:special-display-config)

(defvar doc-buffer-timer nil)

(add-to-list 'company-frontends
             (lambda (command)
               (pcase command
                 (`post-command
                  (setq doc-buffer-timer (run-with-idle-timer 0.6 nil (lambda () (company-show-doc-buffer)))))
                 (`hide
                  (when (timerp doc-buffer-timer)
                    (cancel-timer doc-buffer-timer)
                    (setq doc-buffer-timer nil)))))
             :append)
