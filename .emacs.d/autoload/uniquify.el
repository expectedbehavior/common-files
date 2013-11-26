;; make buffers that would have the same name be better named than default <n>
;; For example, if you open a file named "Gemfile" in two different folders
;; (project1 and project2), the buffer title for each file will be
;; "Gemfile|project1" and "Gemfile|project2" respectively.
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
