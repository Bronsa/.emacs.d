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
(global-set-key (kbd "C-p")     'previous-line)
(global-set-key (kbd "C-n")     'next-line)
(global-set-key (kbd "C-x C-p") 'tabbar-backward-tab)
(global-set-key (kbd "C-x C-n") 'tabbar-forward-tab)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; (define-key erc-mode-map (kbd "C-<up>") 'erc-previous-command)
;; (define-key erc-mode-map (kbd "C-<down>") 'erc-next-command)

(global-set-key (kbd "M-q") 'join-line)
(global-set-key (kbd "ESC <up>") 'paredit-splice-sexp-killing-backward)
(global-set-key (kbd "C-c g") 'magit-status)

;; (define-key mpc-songs-mode-map (kbd "RET") 'mpc-play-at-point)
;; (define-key mpc-songs-mode-map (kbd "M-RET") 'mpc-play)
;; (define-key mpc-mode-map (kbd "j") 'mpc-select)
;; (define-key mpc-mode-map (kbd "s") 'mpc-songs-search)
;; (define-key mpc-mode-map (kbd "y") 'mpc-playlist-add)
;; (define-key mpc-mode-map (kbd "k") 'mpc-playlist-delete)
;; (define-key mpc-mode-map (kbd "SPC") 'mpc-toggle-pause)
;; (define-key mpc-mode-map (kbd "m") 'mpc-select-toggle)
;; (define-key mpc-mode-map (kbd "S-SPC") 'mpc-select-extend)
;; (define-key mpc-mode-map (kbd "n") 'mpc-next)
;; (define-key mpc-mode-map (kbd "p") 'mpc-prev)
;; (define-key mpc-mode-map (kbd "l") 'mpc-playlist)
;; (define-key mpc-mode-map (kbd "M-a") 'mpc-jump-to-albums)
;; (define-key mpc-mode-map (kbd "a") 'mpc-jump-to-artists)
;; (define-key mpc-mode-map (kbd "M-s") 'mpc-jump-to-songs)

(global-set-key (kbd "C-x l") 'toggle-input-method)

(global-unset-key (kbd "C-o"))

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

(global-set-key (kbd "C-\\") 'company-complete-common)

(global-set-key (kbd "TAB")
                (lambda (&optional arg)
                  (interactive "P")
                  (let ((old-tick (buffer-chars-modified-tick))
                        (old-point (point))
                        (tab-always-indent t))
                    (call-interactively #'indent-for-tab-command)
                    (when (and (eq old-point (point))
                               (eq old-tick (buffer-chars-modified-tick))
                               (not (or (bolp) (string-match-p "\\s-\\|\\s)\\|\\s(" (string (char-before))))))
                      (company-complete-common)))))

(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous-or-abort)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; ;; (define-key cider-mode-map (kbd "C-c C-p") nil)

;; (define-key cider-clojure-interaction-mode-map (kbd "M-RET") #'cider-eval-print-last-sexp)
;; (define-key cider-repl-mode-map (kbd "C-c C-l") #'cider-repl-clear-buffer)
(define-key sql-interactive-mode-map (kbd "C-c C-l") #'comint-clear-buffer)
(define-key tuareg-interactive-mode-map (kbd "C-c C-l") #'comint-clear-buffer)

(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") 'subword-left)
(global-set-key (kbd "M-<left>") 'subword-left)
(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") 'subword-right)
(global-set-key (kbd "M-<right>") 'subword-right)

(global-set-key (kbd "S-<left>" ) 'ahs-backward)
(global-set-key (kbd "S-<right>" ) 'ahs-forward)

;; (define-key clojure-mode-map "{" #'paredit-open-curly)
;; (define-key clojure-mode-map "}" #'paredit-close-curly)

(define-key minibuffer-inactive-mode-map [mouse-1] 'ignore)
(define-key minibuffer-inactive-mode-map [mouse-2] 'ignore)
(define-key minibuffer-inactive-mode-map [mouse-3] 'ignore)

(global-unset-key (kbd "<menu-bar> <mouse-1>"))
(global-unset-key (kbd "<menu-bar> <mouse-2>"))
(global-unset-key (kbd "<menu-bar> <mouse-3>"))
(global-unset-key (kbd "<M-drag-mouse-1>"))
(global-unset-key (kbd "<M-mouse-1>"))
(global-unset-key (kbd "<M-down-mouse-1>"))
(global-unset-key (kbd "<M-mouse-3>"))
(global-unset-key (kbd "<M-mouse-2>"))

;; (define-key erc-mode-map (kbd "C-M-i") nil)

(define-key paredit-mode-map (kbd "C-M-d") 'mark-sexp)

(global-set-key (kbd "C-c <right>") 'hs-show-block)
(global-set-key (kbd "C-c <left>")  'hs-hide-block)
(global-set-key (kbd "C-c <up>")    'hs-hide-all)
(global-set-key (kbd "C-c <down>")  'hs-show-all)

;; (define-key cider-repl-mode-map (kbd "C-M-q") #'prog-indent-sexp)

(global-set-key (kbd "C-x j") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-j") 'ido-switch-buffer)

(define-key tuareg-mode-map (kbd "M-q") 'join-line)
(define-key tuareg-mode-map (kbd "C-c C-k") 'tuareg-eval-buffer)
(define-key tuareg-mode-map (kbd "C-c M-j") 'tuareg-run-ocaml)
(define-key tuareg-mode-map (kbd "C-c C-c") 'tuareg-compile)
(define-key tuareg-mode-map (kbd "C-c C-n") 'merlin-phrase-next)
(define-key tuareg-mode-map (kbd "C-c C-p") 'merlin-phrase-prev)

(define-key merlin-mode-map (kbd "M-.") 'merlin-locate)
(define-key merlin-mode-map (kbd "M-,") 'merlin-pop-stack)
(define-key merlin-mode-map (kbd "C-c m") 'merlin-restart)

(global-set-key (kbd "C-c n") 'neotree)

(define-key merlin-mode-map (kbd "C-c l") 'flycheck-list-errors-or-hide)
(define-key merlin-mode-map (kbd "C-c C-l") 'flycheck-list-errors-or-hide)
(global-set-key (kbd "C-f") 'imenu-anywhere)

(global-set-key (kbd "C-c r") 'rename-current-buffer-file)

(define-key flymake-mode-map (kbd "C-c C-x") 'flymake-goto-next-error)
