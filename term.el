;;; term.el -*- lexical-binding: t; -*-

(defun my/new-terminal ()
  "Create a terminal in a new buffer"
  (interactive)
  (let ((buffer (generate-new-buffer "Terminal"))
        (dir (projectile-project-p)))
    (switch-to-buffer buffer)
    (if dir (cd dir))
    (vterm-mode)
    (setq-local vterm-buffer-name-string "Term: %s")
    (setq mode-line-format (default-value 'mode-line-format))
    buffer))
(defalias '=term 'my/new-terminal)
