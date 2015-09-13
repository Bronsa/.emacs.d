;;backward kill word (forward kill word is M-d)
(global-set-key (kbd "M-D") 'backward-kill-word)

;;delete current word
(global-set-key (kbd "M-W") (lambda () (interactive) (backward-word) (kill-word 1)))

;; C-backspace
(global-set-key (kbd "S-<f9>") 'backward-kill-word)

;;kill regions
(global-set-key (kbd "C-x C-k") 'kill-region)

;;set the mark
(global-set-key (kbd "C-SPC") 'set-mark-command)

;;fast vertical naviation
(global-set-key (kbd "M-P") (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "M-N") (lambda () (interactive) (next-line 10)))
(global-set-key (kbd "M-p") 'outline-previous-visible-heading)
(global-set-key (kbd "M-n") 'outline-next-visible-heading)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "C-c C-a") 'align-cljlet)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Enable autoindentation on RET
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(global-set-key (kbd "M-RET") 'newline-and-indent)

;; Navigate tabs
(global-set-key (kbd "C-p")     'tabbar-backward-tab)
(global-set-key (kbd "C-n")     'tabbar-forward-tab)
(global-set-key (kbd "C-x C-p") 'tabbar-backward-group)
(global-set-key (kbd "C-x C-n") 'tabbar-forward-group)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(define-key erc-mode-map (kbd "C-<up>") 'erc-previous-command)
(define-key erc-mode-map (kbd "C-<down>") 'erc-next-command)

(global-set-key (kbd "M-q") 'join-line)
(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key (kbd "C-x c") 'mu4e-compose-new)
(global-set-key (kbd "C-x m") 'mu4e)

(define-key mpc-songs-mode-map (kbd "RET") 'mpc-play-at-point)
(define-key mpc-songs-mode-map (kbd "M-RET") 'mpc-play)
(define-key mpc-mode-map (kbd "j") 'mpc-select)
(define-key mpc-mode-map (kbd "s") 'mpc-songs-search)
(define-key mpc-mode-map (kbd "y") 'mpc-playlist-add)
(define-key mpc-mode-map (kbd "k") 'mpc-playlist-delete)
(define-key mpc-mode-map (kbd "SPC") 'mpc-toggle-pause)
(define-key mpc-mode-map (kbd "m") 'mpc-select-toggle)
(define-key mpc-mode-map (kbd "S-SPC") 'mpc-select-extend)
(define-key mpc-mode-map (kbd "n") 'mpc-next)
(define-key mpc-mode-map (kbd "p") 'mpc-prev)
(define-key mpc-mode-map (kbd "l") 'mpc-playlist)
(define-key mpc-mode-map (kbd "M-s") 'mpc-play)
(define-key mpc-mode-map (kbd "M-a") 'mpc-jump-to-albums)
(define-key mpc-mode-map (kbd "a") 'mpc-jump-to-artists)
(define-key mpc-mode-map (kbd "M-s") 'mpc-jump-to-songs)

(global-set-key (kbd "C-x l") 'toggle-input-method)

(global-unset-key (kbd "C-o"))

(define-key mu4e-headers-mode-map (kbd "r") 'mu4e-compose-reply)
(define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
(define-key paredit-mode-map (kbd "M-D") 'paredit-backward-kill-word)
(define-key paredit-mode-map (kbd "S-<f9>") 'paredit-backward-kill-word)
(define-key paredit-mode-map (kbd "M-q") 'join-line)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key [S-up] (lambda () (interactive) (scroll-down 2)))
(global-set-key [S-down] (lambda () (interactive) (scroll-up 2)))

(global-unset-key (kbd "<insertchar>"))

(define-key magit-mode-map (kbd "X") (lambda () (interactive) (magit-reset-hard "master")))

(global-set-key (kbd "C-c C-k") 'compile)

(global-set-key (kbd "TAB")
                '(lambda ()
                   (interactive)
                   (if (and company-mode (looking-at "\\_>"))
                       (company-complete-common)
                     (indent-according-to-mode))))

(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous-or-abort)