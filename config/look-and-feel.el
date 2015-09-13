(setq
 cursor-in-non-selected-windows nil

 inhibit-splash-screen t
 initial-scratch-message nil

 redisplay-dont-pause t
 scroll-margin 1
 scroll-step 1
 scroll-conservatively 10000
 scroll-preserve-screen-position 1

 eval-sexp-fu-flash-duration 0.5
 truncate-lines t

 show-paren-delay 0
 show-paren-style 'expression)

(defun my-theme ()
  (interactive)
  (color-theme-install
   '(my-theme
     ((foreground-color . "#d3d7cf")
      (background-mode . dark)
      (cursor-color . "white"))

     (default ((t (nil))))
     (font-lock-comment-face ((t (:foreground "#61635e"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#61635e"))))
     (font-lock-doc-face ((t (:foreground "#77507b"))))
     (font-lock-doc-string-face ((t (:foreground "#77507b"))))
     (font-lock-string-face ((t (:foreground "#77507b"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf"))))
     (font-lock-builtin-face ((t (:foreground "#855c1b"))))
     (font-lock-function-name-face ((t (:foreground "#c4a000"))))
     (font-lock-variable-name-face ((t (nil))))
     (font-lock-preprocessor-face ((t (:foreground "#888a85"))))
     (font-lock-constant-face ((t (:foreground "#4e9a06"))))
     (font-lock-type-face ((t (:foreground "#ad7fa8"))))
     (font-lock-warning-face ((t (:bold t :foreground "#cc0000"))))

     (isearch ((t (:foreground "#ddda02" :background "#454545" :weight extra-bold))))
     (isearch-lazy-highlight-face ((t (:foreground "#b0aa02" :background "#232323"))))
     (isearch-fail ((t (:background "#660500"))))

     (fringe ((t (:background "#0f0f0f"))))
     (border ((t (:background "#0f0f0f"))))
     (mode-line ((t (:background "#1f1f1f" :foreground "#eeeeec"))))
     (mode-line-buffer-id ((t (:background "#1f1f1f" :foreground "#eeeeec"))))
     (mode-line-inactive ((t (:background "#1f1f1f" :foreground "#888a85"))))
     (minibuffer-prompt ((t (:foreground "#729fcf"))))
     (region ((t (:background "#343434"))))

     (show-paren-match-face ((t (:background nil :foreground nil :weight extra-bold))))
     (show-paren-mismatch-face ((t (:foreground "#2e3436" :background "#ef2929"))))

     (highlight ((t (:background "#1f1f1f" :foreground nil))))
     (highlight-current-line-face ((t (:background "#1f1f1f" :foreground nil))))

     (which-func ((t (:foreground "#729fcf"))))

     (eval-sexp-fu-flash ((t (:background "gray50" :weight bold))))

     (tabbar-default ((t (:background "gray10"))))
     (tabbar-unselected ((t (:background "gray10" :foreground "gray60"))))
     (tabbar-modified ((t (:background "gray10" :foreground "#4e9a06" :weight extra-bold))))
     (tabbar-selected ((t (:background "black" :foreground "gray75" :weight extra-bold))))

     (magit-section-highlight ((t (:background nil))))
     (magit-diff-context ((t (:background nil :foreground "#454545"))))
     (magit-diff-context-highlight ((t (:background nil :foreground "#454545"))))
     (magit-diff-hunk-heading-highlight ((t (:background nil))))
     (magit-diff-lines-heading ((t (:background nil))))
     (magit-diff-hunk-heading ((t (:background nil))))
     (magit-file-header ((t (:background nil))))
     (magit-diff-added ((t (:background nil :foreground "dark sea green"))))
     (magit-diff-added-highlight ((t (:background nil :foreground "dark sea green"))))
     (magit-diff-removed ((t (:background nil :foreground "brown3"))))
     (magit-diff-removed-highlight ((t (:background nil :foreground "brown3"))))

     (ediff-current-diff-A ((t (:background "#343434" :foreground "brown3"))))
     (ediff-odd-diff-A ((t (:background nil :foreground "brown3"))))
     (ediff-even-diff-A ((t (:background nil :foreground "brown3"))))
     (ediff-fine-diff-A ((t (:background nil :foreground "brown3"))))
     (ediff-current-diff-B ((t (:background "#343434" :foreground "dark sea green"))))
     (ediff-even-diff-B ((t (:background nil :foreground "dark sea green"))))
     (ediff-odd-diff-B ((t (:background nil :foreground "dark sea green"))))
     (ediff-fine-diff-B ((t (:background nil :foreground "dark sea green"))))

     (diff-added ((t (:background nil :foreground "dark sea green"))))
     (diff-removed ((t (:background nil :foreground "brown3"))))
     (diff-hunk-header ((t (:background nil))))
     (diff-file-header ((t (:background nil))))
     (diff-header ((t (:background nil))))
     (diff-context ((t (:foreground "#555555"))))

     (smerge-refined-added ((t (:background nil :foreground "dark sea green"))))
     (smerge-refined-removed ((t (:background nil :foreground "brown3"))))
     (smerge-mine ((t (:background nil))))
     (smerge-markers ((t (:background "lightgrey"))))

     (message-header-cc ((t (:foreground "color-33"))))
     (message-header-newsgroups ((t (:foreground "color-33" :slant italic :weight bold))))
     (message-header-subject ((t (:foreground "brightblue" :weight bold))))
     (message-header-to ((t (:foreground "color-33" :weight bold))))
     (apropos-symbol-face ((t (:background nil))))
     (match ((t (:background nil :foreground "red"))))

     (erc-default-face ((t (:foreground "white"))))
     (erc-input-face ((t (:foreground "white"))))
     (erc-prompt-face ((t (:foreground "gray80" :weight bold))))
     (erc-nick-default-face ((t (:foreground "green"))))
     (erc-my-nick-face ((t (:foreground "white"))))
     (erc-current-nick-face ((t (:foreground "yellow"))))
     (fg:erc-color-face12 ((t (:foreground "brightblue"))))
     (fg:erc-color-face2 ((t (:foreground "blue"))))

     (cider-debug-code-overlay-face ((t (:background "#454545"))))

     (company-tooltip ((t (:background "#333333" :foreground "white"))))
     (company-tooltip-annotation ((t (:background "#333333" :foreground "white"))))
     (company-scrollbar-bg ((t (:background "#0A0A0A"))))
     (company-scrollbar-fg ((t (:background "#555555"))))
     (company-tooltip-selection ((t (:background "gray60" :foreground "black"))))
     (company-tooltip-common ((t (:background "black" :foreground "gray50"))))
     (company-tooltip-common-selection ((t (:background "black" :foreground "gray80"))))

     (ggtags-global-line ((t (:background "#121212")))))))

(my-theme)

(set-face-attribute
 'erc-notice-face nil
 :foreground "gray60")

(set-face-attribute
 'erc-prompt-face nil
 :foreground "gray60"
 :weight 'bold)

(set-face-attribute
 'erc-timestamp-face nil
 :foreground "gray40"
 :weight 'normal)

(setq-default
 mode-line-format
 (list

  '(:eval (propertize (format-time-string "%d/%m/%Y %H:%M ")
                      'help-echo "time"))

  ;; the buffer name; the file name as a tool tip
  '(:eval (propertize "%b" 'face 'font-lock-keyword-face
                      'help-echo (buffer-file-name)))

  '(vc-mode vc-mode)

  ;; line and column
  " (" ;; '%02' to set to 2 chars at least; prevents flickering
  '(:eval (propertize "%l" 'face 'font-lock-type-face))
  ","
  '(:eval (propertize "%02c" 'face 'font-lock-type-face))
  ") "

  ;; relative position, size of file
  "["
  '(:eval (propertize "%p" 'face 'font-lock-constant-face)) ;; % above top
  "] "

  '(:eval (or erc-modified-channels-object ""))

  '(:eval (if (not (string= erc-modified-channels-object ""))
              (propertize " ")
            ""))

  "["
  '(:eval (propertize (format "%s" new-mail)
                      'face (if (> new-mail 0)
                                'font-lock-warning-face
                              'font-lock-constant-face)))
  "/"
  '(:eval (propertize (format "%s" total-mail)
                      'face 'font-lock-constant-face))
  "] "

  ;; the current major mode for the buffer.
  "["

  '(:eval (propertize "%m" 'face 'font-lock-string-face
                      'help-echo buffer-file-coding-system))
  "]"


  ;; overwrite mode?
  '(:eval (propertize (if overwrite-mode " Ins" "")
                      'face 'font-lock-warning-face
                      'help-echo "Buffer is in overwrite mode"))

  ;; was this buffer modified since the last save?
  '(:eval (if (buffer-modified-p)
              (propertize " Mod"
                          'face 'font-lock-warning-face
                          'help-echo "Buffer has been modified")
            ""))

  ;; is this buffer read-only?
  '(:eval (if buffer-read-only
              (propertize " RO"
                          'face 'font-lock-type-face
                          'help-echo "Buffer is read-only")
            ""))
  " -- "

  minor-mode-alist  ;; list of minor modes
  " %-" ;; fill with '-'
  ))