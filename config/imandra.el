(defvar imandra-cli-file-path "/usr/local/bin/imandra-cli")

(defvar imandra-prompt-regexp "^# ")

(defun imandra ()
  (interactive)
  (let* ((imandra-program imandra-cli-file-path)
         (buffer (comint-check-proc "Imandra")))

    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'imandra-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer "*Imandra*"))
       (current-buffer)))

    (unless buffer
      (apply 'make-comint-in-buffer "Imandra" buffer
             imandra-program nil nil)
      (imandra-mode))))

(define-derived-mode imandra-mode comint-mode "Imandra"
  "Major mode for `imandra`" nil "Imandra"
  (require 'tuareg)
  (tuareg-install-font-lock)
  (setq comint-prompt-regexp imandra-prompt-regexp)
  (set (make-local-variable 'comint-input-sender-no-newline) t)
  (set (make-local-variable 'comint-input-sender) 'comint-simple-send)
  (set (make-local-variable 'comint-get-old-input) 'comint-get-old-input-default)
  (set (make-local-variable 'comint-process-echoes) t)
  (set (make-local-variable 'comint-prompt-read-only) t)
  (set (make-local-variable 'font-lock-defaults) '(tuareg-font-lock-keywords t))
  (set (make-local-variable 'comint-eol-on-send) t))

(define-key imandra-mode-map (kbd "C-c C-l") #'comint-clear-buffer)
