(dolist (hook '(cider-mode-hook
                cider-repl-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook #'eldoc-mode)
  (add-hook hook #'paredit-mode)
  (add-hook hook #'auto-highlight-symbol-mode))

(add-hook 'cider-mode-hook (lambda ()
                             (dolist (el '(("(\\(fn\\)[[:space:]]"         . "ƒ")
                                           ("\\(partial\\)[[:space:]]"     . "Ƥ")
                                           ("\\(comp\\)[[:space:]]"        . "·")
                                           ("\\(#\\)("                     . "λ")
                                           ("\\(#\\)_("                    . "#")
                                           ("(\\(not\\)[[:space:]]"        . "¬")
                                           ("\\(->\\)[[:space:]]"          . "→")
                                           ("\\(->>\\)[[:space:]]"         . "⇉")
                                           ("\\(<=\\)[[:space:]]"          . "≤")
                                           ("\\(>=\\)[[:space:]]"          . "≥")
                                           ("\\(not=\\)[[:space:]]"        . "≠")
                                           ("\\(identical\\?\\)[[:space:]]". "≡")
                                           ("[^\\]?\\(~\\)"                . "˷")
                                           ("\\(contains\\?\\)[[:space:]]" . "∈")
                                           ("\\(every\\?\\)[[:space:]]"    . "∀")
                                           ("[^\\]?\\(%\\)"                . "¯")
                                           ("\\(true\\)"                   . "т")
                                           ("\\(false\\)"                  . "ғ")
                                           ("\\(nil\\)"                    . "∅")))

                               (font-lock-add-keywords nil `((,(car el)
                                                              (0 (progn (compose-region (match-beginning 1)
                                                                                        (match-end 1)
                                                                                        ,(cdr el))
                                                                        nil))))))))

(dolist (hook '(cider-mode-hook cider-repl-mode-hook))
  (add-hook hook #'#'subword-mode)
  (add-hook hook (lambda ()
                   (clj-refactor-mode 1)
                   (cljr-add-keybindings-with-prefix "C-c r"))))

(setq nrepl-log-messages nil
      nrepl-hide-special-buffers t
      cider-repl-use-clojure-font-lock t
      cider-repl-use-pretty-printing nil
      cider-repl-popup-stacktraces t
      cider-auto-select-error-buffer t
      cider-stacktrace-default-filters nil
      cider-stacktrace-fill-column nil
      cider-use-overlays nil
      cider-prompt-save-file-on-load 'always-save
      cider-font-lock-dynamically nil
      cljr-suppress-middleware-warnings t)

(add-to-list 'auto-mode-alist '("\\.clj\\(s\\|c\\)?$" . clojure-mode))

;; enable cider even if no connection is available
(add-hook 'clojure-mode-hook #'cider-mode)

(defun figwheel-server-filter (process output)
  (with-current-buffer (process-buffer process)
    (save-excursion
      (goto-char (point-max))
      (insert output)))
  (let ((port 7888))
    (when (string-match "Figwheel Controls:" output)
      (message (format "Figwheel server started on %s" port))
      (with-current-buffer (process-buffer process)
        (let* ((client-proc (nrepl-start-client-process "localhost" port))
               (client-buffer (process-buffer client-proc)))
          (setq nrepl-client-buffers
                (cons client-buffer
                      (delete client-buffer nrepl-client-buffers))))))))

(defun figwheel-start-server-process (directory cmd &optional callback)
  (let* ((default-directory (or directory default-directory))
         (serv-buf (get-buffer-create (generate-new-buffer-name
                                       (nrepl-server-buffer-name directory))))
         (serv-proc (start-file-process-shell-command
                     "nrepl-server" serv-buf cmd)))
    (set-process-filter serv-proc 'figwheel-server-filter)
    (set-process-sentinel serv-proc 'nrepl-server-sentinel)
    (set-process-coding-system serv-proc 'utf-8-unix 'utf-8-unix)
    (with-current-buffer serv-buf
      (setq nrepl-project-dir directory)
      (setq nrepl-post-client-callback callback)
      (setq-local nrepl-create-client-buffer-function
                  nrepl-create-client-buffer-function)
      (setq-local nrepl-use-this-as-repl-buffer
                  nrepl-use-this-as-repl-buffer))
    (message "Starting nREPL server via %s..."
             (propertize cmd 'face 'font-lock-keyword-face))
    serv-proc))

(defun figwheel-jack-in ()
  (interactive)
  (setq cider-current-clojure-buffer (current-buffer))
  (add-hook 'cider-connected-hook
            (lambda ()
              (cider-nrepl-request:eval "(require 'figwheel-sidecar.repl-api)\n(figwheel-sidecar.repl-api/cljs-repl)"
                                        (cider-repl-switch-ns-handler (cider-current-connection)) nil))
            :local t)
  (let* ((project-dir (clojure-project-dir (cider-current-dir)))
         (cmd "lein figwheel"))
    (-when-let (repl-buff (cider-find-reusable-repl-buffer nil project-dir))
      (let ((nrepl-create-client-buffer-function #'cider-repl-create)
            (nrepl-use-this-as-repl-buffer repl-buff))
        (figwheel-start-server-process project-dir cmd nil)))))
