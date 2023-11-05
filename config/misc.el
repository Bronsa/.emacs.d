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
(make-directory "~/.emacs.d/tmp/.undo-tree/" t)

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

(setq initial-major-mode 'text-mode)

(auto-compression-mode 1)

(setq-default

 major-mode 'text-mode

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

 show-paren-style 'parenthesis

 magit-prefer-remote-upstream t
 magit-push-current-set-remote-if-missing nil
 magit-revert-buffers 'silent
 magit-diff-unmarked-lines-keep-foreground nil
 magit-keep-region-overlay t

 magit-branch-read-upstream-first t
 magit-push-always-verify nil

 magit-save-repository-buffers 'dontask

 git-commit-fill-column nil

 projectile-enable-caching t
 projectile-use-git-grep t
 git-commit-finish-query-functions ()

 tuareg-highlight-all-operators t
 )

(defun recent-commits ()
  (when (magit-git-success "rev-parse" "@{upstream}")
    (magit-insert-recent-commits)))

(magit-add-section-hook 'magit-status-sections-hook
                        #'recent-commits
                        #'magit-insert-unpushed-to-upstream-or-recent
                        t)

(magit-add-section-hook 'magit-status-sections-hook
                        #'magit-insert-unpushed-to-upstream
                        #'magit-insert-unpushed-to-upstream-or-recent
                        'replace)

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
(add-to-list 'auto-mode-alist '("\\.ml[ip]?\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.iml[i]?\\'" . imandra-mode))

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

;; (setq elm-format-on-save t)
;; (setq elm-tags-on-save t)
;; (add-to-list 'company-backends 'company-elm)

(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(setq org-src-fontify-natively t)
(setq magit-diff-refine-hunk t)

;;; (magithub-feature-autoinject t)
;;; (setq magithub-clone-default-directory "~/github")

(setq olivetti-body-width 86)


(add-to-list 'auto-mode-alist '("\\.ipl[d]?\\'" . ipl-mode))

(setq csv-separators '("," ";"))

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh t)

(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/tmp/.undo-tree")))

(setq transient-show-common-commands nil)
(setq transient-default-level 1)
(setq transient-show-popup 0.3)


(setq tuareg-indent-align-with-first-arg t)
(setq tuareg-match-patterns-aligned t)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (setq-local merlin-command (imandra--find-merlin))))

(add-hook 'tuareg-mode-hook (lambda () (abbrev-mode -1) (ocp-setup-indent)))
(add-hook 'tuareg-interactive-mode-hook (lambda () (abbrev-mode -1)))

(add-hook 'reason-mode-hook (lambda ()
                              ;; (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(add-hook 'tuareg-mode-hook (lambda () (auto-highlight-symbol-mode)))

;; (imandra-merlin-setup-eldoc)

(defun merlin-restart ()
  (interactive)
  (call-interactively 'imandra--merlin-restart))

(add-hook 'before-save-hook 'ocamlformat-before-save)
;; (add-hook 'tuareg-mode-hook 'merlin-eldoc-setup)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(add-to-list 'auto-mode-alist '("\\.xtend\\'" . java-mode))

(setq ocamlformat-enable 'enable-outside-detected-project)
(add-to-list 'recentf-exclude "/tmp/ocamlformat.*")

(defun opam-root-dir ()
  (with-temp-buffer
    (if (eq (call-process-shell-command "opam var bin" nil (current-buffer) nil) 0)
        (replace-regexp-in-string "_opam/bin\n$" "" (buffer-string))
      (message "can't find opam root"))))

(defun generate-mli ()
  (interactive)
  (let* ((root-dir (opam-root-dir))
         (file-name (buffer-file-name))
         (relative-path (substring file-name (length root-dir))))
    (when relative-path
      (let* ((mli-file-name (concat file-name "i"))
             (buffer (get-file-buffer mli-file-name)))
        (progn
          (cond
           (buffer (switch-to-buffer buffer))
           (t (find-file mli-file-name)))
          (let ((default-directory root-dir))
            (call-process-shell-command
             (concat "opam exec -- dune exec ocaml-print-intf " relative-path)
             nil (current-buffer) nil)))))))

(defun popup-buffer (buffer)
  (setq outwin (display-buffer buffer '(nil (allow-no-window . nil)))))

(defun tuareg-compile (watch)
  (interactive "P")
  (let* ((buffer (get-buffer "*compilation*"))
         (tuareg-compilation-buffer (get-buffer-create "*tuareg-compilation*"))
         (compilation-running (and buffer (get-buffer-process buffer))))
    (progn
      (if compilation-running (popup-buffer buffer))
      (let ((root-dir (opam-root-dir)))
        (with-current-buffer tuareg-compilation-buffer
          (when (or (not compilation-running)
                    (not (string-equal root-dir (buffer-string))))
            (erase-buffer)
            (insert root-dir)
            (compile (concat "make -C " root-dir (if watch " watch")))))))))

(advice-add 'ocamlformat--process-errors :filter-args
            (lambda (args)
              (let ((buffer (get-buffer-create "*ocamlformat*")))
                (append (butlast args) (list buffer)))))

(setq-default compilation-always-kill t)

(setq-local merlin-error-after-save t)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (flycheck-mode t)
            (flycheck-ocaml-setup)))

(flycheck-define-generic-checker 'imandra-merlin
  "A syntax checker for Imandra using Merlin Mode."
  :start #'flycheck-ocaml-merlin-start
  :verify #'flycheck-verify-ocaml-merlin
  :modes '(imandra-mode tuareg-mode)
  :predicate (lambda () merlin-mode))

(add-to-list 'flycheck-checkers 'imandra-merlin)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (side            . bottom)
               (reusable-frames . visible)
               (window-height   . 0.33)))

(setq projectile-mode-line-function
      #'(lambda () projectile-mode-line-prefix))

(defun flycheck-list-errors-or-hide ()
  (interactive)
  (let* ((buf (get-buffer flycheck-error-list-buffer))
         (win (if buf (get-buffer-window buf))))
    (if win
        (condition-case nil
            (while (setq win (get-buffer-window buf)) (delete-window win))
          (error (switch-to-buffer (other-buffer buf))))
      (flycheck-list-errors))))

(add-to-list 'imenu-anywhere-friendly-modes '(tuareg-mode imandra-mode))

(setq-default
 imenu-anywhere-buffer-list-function
 #'(lambda ()
     (seq-filter
      (lambda (buf)
        (not (provided-mode-derived-p (buffer-local-value 'major-mode buf) 'magit-mode)))
      (buffer-list))))

(setq-default resize-mini-windows t)

(advice-add 'imandra--merlin-restart :after #'flycheck-buffer)

(add-hook 'merlin-mode-hook (lambda () (merlin-use-merlin-imenu)))
(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode)

(setq transient-display-buffer-action '(display-buffer-below-selected))

(defun imandra--merlin-restart ()
  (interactive)
  (require 'opam-switch-mode)
  (call-interactively #'opam-switch-set-switch)
  (merlin-stop-server))


(add-to-list 'eglot-server-programs '(ipl-mode . ("ipl-server")))

(add-hook 'ipl-mode-hook 'eglot-ensure)

(add-to-list 'company-backends '(merlin-company-backend company-dabbrev-code))


(defun merlin-bounds-of-ocaml-atom-at-point ()
  "Return the start and end points of an ocaml atom near point.
An ocaml atom is any string containing [a-z_0-9A-Z`.]."
  (save-excursion
    (skip-chars-backward "a-z0-9A-Z_'.")
    (save-match-data
      (if (looking-at "['a-z_0-9A-Z.]*['a-z_A-Z0-9]")
          (cons (point) (match-end 0)) ; returns the bounds
        nil)))) ; no atom at point
