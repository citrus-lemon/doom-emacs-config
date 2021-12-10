;;; util.el -*- lexical-binding: t; -*-

(defun my/new-terminal ()
  "Create a terminal in a new buffer"
  (interactive)
  (let ((buffer (generate-new-buffer "Terminal"))
        (dir (projectile-project-p)))
    (switch-to-buffer buffer)
    (if dir (cd dir))
    (vterm-mode)
    (setq mode-line-format (default-value 'mode-line-format))
    buffer))
(defalias '=term 'my/new-terminal)

(defun my/copy ()
  (interactive)
  (if mark-active
      (copy-region-as-kill (region-beginning) (region-end))
    (kill-new (thing-at-point 'symbol))))
