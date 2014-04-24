(defun insert-date()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%a, %e %b %Y, %k:%M" (current-time))))

(global-set-key "\C-cd" 'insert-date)
