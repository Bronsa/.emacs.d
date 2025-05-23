(setq tabbar-buffer-groups-function
      (lambda ()
        (list (cond
               ((memq major-mode '(shell-mode term-mode eshell-mode))
                "Shell")
               ((or
                 (equal "*cider-scratch*" (buffer-name b))
                 (string-match "\\*cider-repl.*\\*" (buffer-name b))
                 (string-match "\\*nrepl.*\\*" (buffer-name b))
                 (string-match "\\*cider-error.*\\*" (buffer-name b))
                 (string-match "\\*inf-clojure.*\\*" (buffer-name b))
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
                                                  magit-reflog-mode magit-stash-mode))
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
                           ((or
                             (eq major-mode 'compilation-mode)
                             (string-match "\\.~.*~" (buffer-name b))
                             (string-match "\\*tramp.*" (buffer-name b))
                             (string-match "\\*.*-format errors\\*" (buffer-name b))
                             (and (string-match "\\*cider-.*" (buffer-name b))
                                  (not (equal "*cider-scratch*" (buffer-name b)))
                                  (not (string-match "\\*cider-repl.*\\*" (buffer-name b)))
                                  (not (string-match "\\*cider-error.*\\*" (buffer-name b))))
                             (member (buffer-name b)
                                     (list
                                      "*Async-native-compile-log*"
                                      "*Native-compile-Log*"
                                      "*eldoc*"
                                      "*Flymake log*"
                                      "*Flycheck errors*"
                                      "*Flycheck error messages*"
                                      "*xref*"
                                      "*merlin-occurrences*"
                                      "*Messages*"
                                      "*ocamlformat*"
                                      "*Help*"
                                      "*Warnings*"
                                      "*Buffer List*"
                                      "*clang-complete*"
                                      "*tuareg-compilation*"
                                      "*elm-format errors*"
                                      "elm-oracle"
                                      "*Shell Command Output*"
                                      "*Ido Completions*"
                                      "*ggtags-global*"
                                      "*Completions*"
                                      "*Compile-Log*"
                                      "*compilation*"
                                      "*copy*"
                                      "*Occur*"
                                      "*vc*"
                                      "*edn*"
                                      "*eww*"
                                      "*clang-complete*"
                                      "*grep*"
                                      "*Open Recent*"
                                      "*ERC Accidental Paste Overflow*"
                                      "*Directory*"
                                      "*Process List*"
                                      "*Disabled Command*"
                                      "*Warning*"
                                      "*merlin-types*"
                                      "*merlin-errors*"
                                      "*Backtrace*"
                                      "*Quail Completions*"
                                      "*trace of SMTP session to smtp.gmail.com*"
                                      "mu4e-update"
                                      "TAGS"
                                      "*undo-tree Diff*" ))
                             (and (eq major-mode 'erc-mode)
                                  (or (string-match ".*:.*" (buffer-name b))
                                      (equal "freenode" (buffer-name b))
                                      (equal "nil" (buffer-name b))))
                             (memq (buffer-local-value 'major-mode b)
                                   '(mu4e-main-mode mu4e-view-mode mu4e-compose-mode mu4e-headers-mode message-mode mail-mode))
                             (string-match "\\*draft\\*.*" (buffer-name b))
                             (string-match "\\*JDEE.*\\*" (buffer-name b))
                             (string-match "\\*EGLOT.*\\*" (buffer-name b))
                             (string-match "\\*emacs\\*.*" (buffer-name b))
                             (string-match "\\*ediff\\*.*" (buffer-name b))
                             (string-match "\\Ediff\\*.*" (buffer-name b))
                             (string-match "\\*Customize.*\\*" (buffer-name b))
                             (memq (buffer-local-value 'major-mode b)
                                   '(mpc-mode mpc-status-mode mpc-tagbrowser-mode mpc-tagbrowser-dir-mode mpc-songs-mode))) nil)
                           ((buffer-file-name b) b)
                           ((buffer-live-p b) b)))
                      (buffer-list)))))


(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value	(concat " " (concat ad-return-value " "))))

(setq
 tabbar-scroll-left-help-function nil   ;don't show help information
 tabbar-scroll-right-help-function nil
 tabbar-help-on-tab-function nil
 tabbar-home-help-function nil
 tabbar-buffer-home-button (quote (("") "")) ;don't show tabbar button
 tabbar-scroll-left-button (quote (("") ""))
 tabbar-scroll-right-button (quote (("") "")))
