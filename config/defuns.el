(defun indent-file ()
  "indent whole buffer and untabify it"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun nopaste ()
  "Posts the current buffer or region to sprunge"
  (interactive)
  (let* ((start (if (use-region-p) (region-beginning) (point-min)))
         (end (if (use-region-p) (region-end) (point-max)))
         (content (buffer-substring-no-properties start end)))
    (async-start
     `(lambda ()
        ,(async-inject-variables "\\`content\\'")
        (let ((filename "/tmp/sprunge-post"))
          (with-temp-buffer
            (let ((coding-system-for-read 'utf-8)
                  (coding-system-for-write 'utf-8))
              (insert content)
              (write-file filename)))
          (substring (shell-command-to-string (concat "curl -s -F 'sprunge=<" filename "' http://sprunge.us")) 0 -1)))

     (lambda (res)
       (kill-new res)
       (message res)))))

(defun wc (&optional start end)
  "Prints number of lines, words and characters in region or whole buffer."
  (interactive)
  (let ((n 0)
        (start (if mark-active (region-beginning) (point-min)))
        (end (if mark-active (region-end) (point-max))))
    (save-excursion
      (goto-char start)
      (while (< (point) end) (if (forward-word 1) (setq n (1+ n)))))
    (message "%3d %3d %3d" (count-lines start end) n (- end start))))


(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

(defun magit-grep (&optional pattern)
  (interactive)
  (let ((pattern (or pattern
                     (read-string "git grep: " ""))))
    (with-current-buffer (generate-new-buffer "*Magit Grep*")
      (let ((dir (magit-toplevel)))
        (if dir
            (progn
              (setq default-directory dir)
              (insert "-*- mode: grep; default-directory \"" default-directory "\" -*-\n\n" magit-git-executable
                      " grep -n "
                      (shell-quote-argument pattern) "\n\n")
              (magit-git-insert (list "grep" "--line-number" pattern))
              (grep-mode)
              (pop-to-buffer (current-buffer)))
          (message "not in a git directory"))))))

(defun calculate-stops ()
  (save-excursion
    (let ((start
           (condition-case e
               (while t (backward-sexp))
             (error (point))))
          stops)
      (push start stops)
      (condition-case e
          (while t
            (forward-sexp)
            (when (looking-at "\\s-*,")
              (push (point) stops)))
        (error (push (point) stops)))
      (nreverse stops))))

(defun transpose-args ()
  (interactive)
  (when (looking-at "\\s-") (backward-sexp))
  (cl-loop with p = (point)
           with previous = nil
           for stop on (calculate-stops)
           for i upfrom 0
           when (<= p (car stop)) do
           (when previous
             (let* ((end (cadr stop))
                    (whole (buffer-substring previous end))
                    middle last)
               (delete-region previous end)
               (goto-char previous)
               (setf middle (if (> i 1) (- (car stop) previous)
                              (string-match "[^, \\t]" whole
                                            (- (car stop) previous)))
                     last (if (> i 1) (substring whole 0 middle)
                            (concat (substring whole (- (car stop) previous) middle)
                                    (substring whole 0 (- (car stop) previous)))))
               (insert (substring whole middle) last)))
           (cl-return)
           end do (setf previous (car stop))))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun decrement-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1- (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)
(global-set-key (kbd "C-c -") 'decrement-number-at-point)

;; (defun merlin/call (command &rest args)
;;   "Execute a command and parse output: return an sexp on success or throw an error"
;;   (let ((result (merlin--call-merlin command args)))
;;     (condition-case err
;;         (setq result (car (read-from-string result)))
;;       (error ()))
;;     (let ((notifications (cdr-safe (assoc 'notifications result)))
;;           (class (cdr-safe (assoc 'class result)))
;;           (value (cdr-safe (assoc 'value result))))
;;       (dolist (notification notifications)
;;         (message "(merlin) %s" notification))
;;       (cond ((string-equal class "return") value)
;;             (t ())))))

(defun dos2unix (buffer)
  "Automate M-% C-q C-m RET C-q C-j RET"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      (replace-match (string ?\C-j) nil t))))
