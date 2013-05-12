;;; A quick & ugly PATH solution to Emacs on Mac OSX
(if (string-equal "darwin" (symbol-name system-type))
    (setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH"))))
