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
      (setq default-directory (magit-toplevel))
      (insert magit-git-executable " "
              (mapconcat 'identity magit-git-standard-options " ")
              " grep -n "
              (shell-quote-argument pattern) "\n\n")
      (magit-git-insert (list "grep" "--line-number" pattern))
      (grep-mode)
      (pop-to-buffer (current-buffer)))))

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
