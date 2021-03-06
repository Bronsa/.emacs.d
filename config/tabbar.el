(setq tabbar-buffer-groups-function
      (lambda ()
        (list (cond
               ((memq major-mode '(shell-mode term-mode eshell-mode))
                "Shell")
               ((or
                 (equal "*cider-scratch*" (buffer-name b))
                 (string-match "\\*cider-repl.*\\*" (buffer-name b))
                 (string-match "\\*cider-error.*\\*" (buffer-name b))
                 (equal "*inferior-lisp*" (buffer-name (current-buffer)))
                 (equal "*OCaml*" (buffer-name (current-buffer)))
                 (equal "*ielm*" (buffer-name (current-buffer)))
                 (equal "*Python*" (buffer-name (current-buffer)))
                 (string-match "\\*SQL.*\\*" (buffer-name (current-buffer)))
                 (string-match "\\*sql.*\\*" (buffer-name (current-buffer))))
                "Interaction")
               ((or (memq major-mode '(magit-mode magit-log-mode magit-commit-mode magit-key-mode magit-diff-mode
                                                  magit-wip-mode magit-wip-save-mode magit-status-mode magit-stath-mode
                                                  magit-log-edit-mode magit-branch-manager-mode magit-wazzup-mode
                                                  magit-revision-mode magit-refs-mode magit-process-mode
                                                  magit-reflog-mode))
                    (equal "*magit-process*" (buffer-name (current-buffer)))
                    (string-match "\\*magit." (buffer-name (current-buffer)))
                    (string-match "\\*Magit." (buffer-name (current-buffer)))
                    (equal "COMMIT_EDITMSG" (buffer-name (current-buffer))))
                "Magit")
               ;; ((memq major-mode '(mu4e-main-mode mu4e-view-mode mu4e-compose-mode mu4e-headers-mode message-mode mail-mode))
               ;;  "Mail")
               ((eq major-mode 'erc-mode)
                "IRC")
               ((eq major-mode 'dired-mode)
                "Dired")
               ;; ((memq major-mode '(mpc-mode mpc-status-mode mpc-tagbrowser-mode mpc-tagbrowser-dir-mode mpc-songs-mode))
               ;;  "Music")
               (t
                "All")))))

(setq tabbar-buffer-list-function
      (lambda ()
        (delq nil
              (mapcar #'(lambda (b)
                          (cond
                           ;; Always include the current buffer.
                           ;;((eq (current-buffer) b) b)
                           ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                           ((or (equal "*Messages*" (buffer-name b))
                                (eq major-mode 'compilation-mode)
                                (equal "*Help*" (buffer-name b))
                                (equal "*Warnings*" (buffer-name b))
                                (equal "*Buffer List*" (buffer-name b))
                                (equal "*clang-complete*" (buffer-name b))
                                (equal "*elm-format errors*" (buffer-name b))
                                (equal "elm-oracle" (buffer-name b))
                                (string-match "\\*tramp.*" (buffer-name b))
                                (and (string-match "\\*cider-.*" (buffer-name b))
                                     (not (equal "*cider-scratch*" (buffer-name b)))
                                     (not (string-match "\\*cider-repl.*\\*" (buffer-name b)))
                                     (not (string-match "\\*cider-error.*\\*" (buffer-name b))))
                                (equal "*Shell Command Output*" (buffer-name b))
                                (equal "*Ido Completions*" (buffer-name b))
                                (equal "*ggtags-global*" (buffer-name b))
                                (equal "*Completions*" (buffer-name b))
                                (equal "*Compile-Log*" (buffer-name b))
                                (equal "*copy*" (buffer-name b))
                                (equal "*Occur*" (buffer-name b))
                                (equal "*vc*" (buffer-name b))
                                (equal "*edn*" (buffer-name b))
                                (equal "*eww*" (buffer-name b))
                                (equal "*clang-complete*" (buffer-name b))
                                (equal "*grep*" (buffer-name b))
                                (equal "*Open Recent*" (buffer-name b))
                                (equal "*ERC Accidental Paste Overflow*" (buffer-name b))
                                (equal "*Directory*" (buffer-name b))
                                (equal "*Process List*" (buffer-name b))
                                (equal "*Disabled Command*" (buffer-name b))
                                (equal "*Warning*" (buffer-name b))
                                (equal "*merlin-types*" (buffer-name b))
                                (and (eq major-mode 'erc-mode)
                                     (or (string-match ".*:.*" (buffer-name b))
                                         (equal "freenode" (buffer-name b))
                                         (equal "nil" (buffer-name b))))
                                (equal "*Backtrace*" (buffer-name b))
                                (equal "*Quail Completions*" (buffer-name b))
                                (equal "*trace of SMTP session to smtp.gmail.com*" (buffer-name b))
                                (equal "mu4e-update" (buffer-name b))
                                (equal "TAGS" (buffer-name b))
                                (memq (buffer-local-value 'major-mode b)
                                      '(mu4e-main-mode mu4e-view-mode mu4e-compose-mode mu4e-headers-mode message-mode mail-mode))
                                (string-match "\\*draft\\*.*" (buffer-name b))
                                (string-match "\\*JDEE.*\\*" (buffer-name b))
                                (string-match "\\*emacs\\*.*" (buffer-name b))
                                (string-match "\\*ediff\\*.*" (buffer-name b))
                                (string-match "\\*Customize.*\\*" (buffer-name b))
                                (memq (buffer-local-value 'major-mode b)
                                      '(mpc-mode mpc-status-mode mpc-tagbrowser-mode mpc-tagbrowser-dir-mode mpc-songs-mode))
                                (equal "*undo-tree Diff*" (buffer-name b))) nil)
                           ((buffer-file-name b) b)
                           ((buffer-live-p b) b)))
                      (buffer-list)))))

;; place a space around the label to make it looks less crowd
(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value	(concat " " (concat ad-return-value " "))))
;; called each time the modification state of the buffer changed
(defun ztl-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
;; first-change-hook is called BEFORE the change is made
(defun ztl-on-buffer-modification ()
  (set-buffer-modified-p t)
  (ztl-modification-state-change))

(setq
 tabbar-scroll-left-help-function nil   ;don't show help information
 tabbar-scroll-right-help-function nil
 tabbar-help-on-tab-function nil
 tabbar-home-help-function nil
 tabbar-buffer-home-button (quote (("") "")) ;don't show tabbar button
 tabbar-scroll-left-button (quote (("") ""))
 tabbar-scroll-right-button (quote (("") "")))
