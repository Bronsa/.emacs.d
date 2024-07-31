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
 ;;show-paren-style 'expression
 )

(set-background-color "#232323")

(defun my-theme ()
  (interactive)
  (color-theme-install
   '(my-theme
     ((foreground-color . "#d3d7cf")
      (background-mode . dark)
      (cursor-color . "white"))

     (default ((t (unspecified))))
     (font-lock-comment-face ((t (:foreground "#61635e"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#61635e"))))
     (font-lock-doc-face ((t (:foreground "#77507b"))))
     (font-lock-doc-string-face ((t (:foreground "#af5f00"))))
     (font-lock-string-face ((t (:foreground "#77507b"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf"))))
     (font-lock-builtin-face ((t (:foreground "#855c1b"))))
     (font-lock-function-name-face ((t (:foreground "#c4a000"))))
     (font-lock-variable-name-face ((t (unspecified))))
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
     (region ((t (:background "#464646"))))

     (show-paren-match ((t (:background "#2f2f2f" :foreground unspecified :weight bold))))
     (show-paren-match-expression ((t (:background unspecified :foreground unspecified :weight bold))))
     (show-paren-mismatch ((t (:foreground "#2e3436" :background "#ef2929"))))

     (highlight ((t (:background "#1f1f1f" :foreground unspecified))))
     (highlight-current-line-face ((t (:background "#1f1f1f" :foreground unspecified))))

     (which-func ((t (:foreground "#729fcf"))))

     (eval-sexp-fu-flash ((t (:background "gray50" :weight bold))))

     (tabbar-default ((t (:background "gray10"))))
     (tabbar-unselected ((t (:background "gray10" :foreground "gray60"))))
     (tabbar-modified ((t (:background "gray10" :foreground "#4e9a06" :weight extra-bold))))
     (tabbar-selected ((t (:background "black" :foreground "gray75" :weight extra-bold))))

     (magit-section-highlight ((t (:background unspecified))))
     (magit-diff-context ((t (:background unspecified :foreground "#454545"))))
     (magit-diff-context-highlight ((t (:background unspecified :foreground "#454545"))))
     (magit-diff-hunk-heading-highlight ((t (:background unspecified))))
     (magit-diff-lines-heading ((t (:background unspecified))))
     (magit-diff-hunk-heading ((t (:background unspecified))))
     (magit-file-header ((t (:background unspecified))))
     (magit-diff-added ((t (:background unspecified :foreground "dark sea green"))))
     (magit-diff-added-highlight ((t (:background unspecified :foreground "dark sea green"))))
     (magit-diff-removed ((t (:background unspecified :foreground "brown3"))))
     (magit-diff-removed-highlight ((t (:background unspecified :foreground "brown3"))))

     (ediff-current-diff-A ((t (:background "#343434" :foreground "brown3"))))
     (ediff-odd-diff-A ((t (:background unspecified :foreground "brown3"))))
     (ediff-even-diff-A ((t (:background unspecified :foreground "brown3"))))
     (ediff-fine-diff-A ((t (:background unspecified :foreground "brown3"))))
     (ediff-current-diff-B ((t (:background "#343434" :foreground "dark sea green"))))
     (ediff-even-diff-B ((t (:background unspecified :foreground "dark sea green"))))
     (ediff-odd-diff-B ((t (:background unspecified :foreground "dark sea green"))))
     (ediff-fine-diff-B ((t (:background unspecified :foreground "dark sea green"))))

     (diff-added ((t (:background unspecified :foreground "dark sea green"))))
     (diff-removed ((t (:background unspecified :foreground "brown3"))))
     (diff-hunk-header ((t (:background unspecified))))
     (diff-file-header ((t (:background unspecified))))
     (diff-header ((t (:background unspecified))))
     (diff-context ((t (:foreground "#555555"))))

     (smerge-refined-added ((t (:background unspecified :foreground "dark sea green"))))
     (smerge-other ((t (:background unspecified :foreground "dark sea green"))))
     (smerge-refined-removed ((t (:background unspecified :foreground "brown3"))))
     (smerge-mine ((t (:background unspecified))))
     (smerge-markers ((t (:background "#555555"))))

     (message-header-cc ((t (:foreground "color-33"))))
     (message-header-newsgroups ((t (:foreground "color-33" :slant italic :weight bold))))
     (message-header-subject ((t (:foreground "brightblue" :weight bold))))
     (message-header-to ((t (:foreground "color-33" :weight bold))))
     (apropos-symbol-face ((t (:background unspecified))))
     (match ((t (:background unspecified :foreground "red"))))

     ;; (erc-default-face ((t (:foreground "white"))))
     ;; (erc-input-face ((t (:foreground "white"))))
     ;; (erc-prompt-face ((t (:foreground "gray80" :weight bold))))
     ;; (erc-nick-default-face ((t (:foreground "green"))))
     ;; (erc-my-nick-face ((t (:foreground "white"))))
     ;; (erc-current-nick-face ((t (:foreground "yellow"))))
     ;; (fg:erc-color-face12 ((t (:foreground "brightblue"))))
     ;; (fg:erc-color-face2 ((t (:foreground "blue"))))

     ;; (cider-debug-code-overlay-face ((t (:background "#454545"))))
     ;; (cider-stacktrace-face ((t (:foregroiund "#575757"))))

     (company-tooltip ((t (:background "#333333" :foreground "white"))))
     (company-tooltip-annotation ((t (:background "#333333" :foreground "white"))))
     (company-scrollbar-bg ((t (:background "#0A0A0A"))))
     (company-scrollbar-fg ((t (:background "#555555"))))
     (company-tooltip-selection ((t (:background "gray60" :foreground "black"))))
     (company-tooltip-common ((t (:background "black" :foreground "gray50"))))
     (company-tooltip-common-selection ((t (:background "black" :foreground "gray80"))))

     ;;
     ;; (aggtags-global-line ((t (:background "#121212"))))
     )
   ))

;; (set-face-attribute
;;  'erc-notice-face nil
;;  :foreground "gray60")

;; (set-face-attribute
;;  'erc-prompt-face nil
;;  :foreground "gray60"
;;  :weight 'bold)

;; (set-face-attribute
;;  'erc-timestamp-face nil
;;  :foreground "gray40"
;;  :weight 'normal)

(defun mode-line-fill (reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (when
      (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display
              `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))))

(setq-default
 mode-line-format
 (list

  ;; the buffer name; the file name as a tool tip
  '(:eval (propertize " %b" 'face 'font-lock-keyword-face
                      'help-echo (buffer-file-name)))

  ;; line and column
  " (" ;; '%02' to set to 2 chars at least; prevents flickering
  '(:eval (propertize "%l" 'face 'font-lock-type-face))

  ;; current active region line length
  '(:eval
    (if (region-active-p)
        (format "[%s]"
                (propertize
                 (format "%d" (count-lines (region-beginning) (region-end)))
                 'face 'font-lock-type-face))))


  ","
  '(:eval (propertize "%02c" 'face 'font-lock-type-face))
  ") "

  ;; relative position, size of file
  "["
  '(:eval (propertize "%p" 'face 'font-lock-constant-face)) ;; % above top
  "]"

  ;; the current major mode for the buffer.
  " ["

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

  ;; '(:eval (or erc-modified-channels-object ""))

  ;; '(:eval (if (not (string= erc-modified-channels-object ""))
  ;;             (propertize " ")
  ;;           ""))

  ;; '(vc-mode vc-mode)

  '(:eval (if (symbol-value 'flycheck-mode) flycheck-mode-line))

  '(:eval (if (eq 'compilation-mode major-mode) compilation-mode-line-errors))

  '(:eval (if (eglot-managed-p) " "))
  '(:eval (if (eglot-managed-p) (eglot--mode-line-format)))

  (mode-line-fill 18)

  '(:eval (if (equal (cddr (window-pixel-edges))
                     (cddr (window-pixel-edges (frame-root-window))))
              (propertize (format-time-string " %d/%m/%Y %H:%M")
                          'help-echo "time")))


  ))

(my-theme)
