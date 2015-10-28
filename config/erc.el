(custom-set-variables '(erc-modules '(autojoin
                                      track ;; track activity in chans
                                      completion
                                      irccontrols ;; enable bolding/underlining etc
                                      log
                                      netsplit
                                      match  ;; match own nick should probably use `notifications` instead
                                      noncommands
                                      readonly ;; displayed lines are read-only
                                      stamp ;; show timestamps [IMPORTANT: load AFTER match]
                                      autoaway
                                      log
                                      ;; services ;; nicksev
                                      scrolltobottom
                                      fill
                                      truncate ;; truncate the buffer to save memory
                                      ring ;; make the input a ring
                                      networks
                                      move-to-prompt)))


(setq erc-nick "Bronsa"
      erc-user-full-name "Nicola Mometto"
      erc-email-userid "bronco"
      erc-nick-uniquifier "`"
      erc-try-new-nick-p t

      erc-prompt-for-nickserv-password nil

      erc-autojoin-channels-alist '((".*\\freenode.net" "#distro" "#clojure" "#metamorphism"))
      erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" "477")
      erc-hide-list '()

      erc-track-exclude-server-buffer t
      erc-track-showcount t

      erc-query-display 'frame

      erc-autoaway-idle-seconds 1800
      erc-auto-discard-away t

      erc-auto-query 'bury
      erc-kill-buffer-on-part nil

      erc-fill-column (- (/ (frame-width) 2) 12)
      erc-fill-prefix "        | "

      erc-server-reconnect-timeout 2

      erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "%H:%M:%S "
      erc-insert-timestamp-function 'erc-insert-timestamp-left

      erc-button-url-regexp "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]"

      erc-header-line-uses-tabbar-p t

      erc-log-channels-directory "~/irclogs"

      erc-save-buffer-on-part nil
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t

      erc-interpret-mirc-color t
      erc-input-line-position -2
      erc-prompt (lambda ()
                   (format "[%s]" (buffer-name (current-buffer))))

      erc-current-nick-highlight-type 'nick

      erc-keywords '("emitter" "cinc" "analyzer")
      erc-track-position-in-mode-line 'after-modes
      erc-track-shorten-function nil

      erc-flood-protect nil

      erc-accidental-paste-threshold-seconds 0.2

      erc-track-faces-priority-list '(erc-error-face
                                      erc-current-nick-face
                                      erc-keyword-face
                                      erc-nick-msg-face
                                      erc-direct-msg-face
                                      erc-notice-face
                                      erc-prompt-face
                                      erc-nick-default-face))

(defun irc ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (erc-tls :server "irc.freenode.net" :port 6697 :nick "Bronsa" :password "password" :full-name "Nicola Mometto"))

(add-hook 'erc-mode-hook
          (lambda ()
            (setq mode-line-format
                  `(
                    (:propertize "%b " face font-lock-keyword-face
                                 help-echo (buffer-file-name))
                    (:eval (let ((ops 0)
                                 (members 0))
                             (when erc-channel-users
                               (maphash (lambda (k v)
                                          (when (erc-channel-user-op-p k)
                                            (incf ops))
                                          (incf members))
                                        erc-channel-users))
                             (format "%s(@%s) " members ops)))

                    (:eval (or erc-modified-channels-object ""))

                    (:eval (if (not (string= erc-modified-channels-object ""))
                               " "
                             ""))

                    "- "

                    (:eval (let* ((users (mapcar (lambda (user-data) (erc-server-user-nickname (car user-data)))
                                                 (erc-sort-channel-users-by-activity (erc-get-channel-user-list))))
                                  (user-string (mapconcat #'identity (delete* nil (subseq users 0 10)) ", ")))
                             (propertize user-string 'help-echo user-string)))))))

(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defadvice show-paren-function (around dont-paren-my-erc activate)
  (unless (eq major-mode 'erc-mode)
    ad-do-it))

(make-variable-buffer-local 'erc-fill-column)
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (save-excursion
               (walk-windows
                (lambda (w)
                  (let ((buffer (window-buffer w)))
                    (set-buffer buffer)
                    (when (eq major-mode 'erc-mode)
                      (setq erc-fill-column (- (window-width w) 2)))))))))

(add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
