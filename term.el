;;; term.el -*- lexical-binding: t; -*-

(define-minor-mode terminal-minor-mode
  "Terminal minor mode")

(defun my/new-terminal ()
  "Create a terminal in a new buffer"
  (interactive)
  (let ((buffer (generate-new-buffer "Terminal"))
        (dir (projectile-project-p)))
    (switch-to-buffer buffer)
    (if dir (cd dir))
    (vterm-mode)
    (terminal-minor-mode)
    (setq-local vterm-buffer-name-string "Term: %s")
    (setq mode-line-format (default-value 'mode-line-format))
    buffer))

(defun terminal-auto-new (&optional ARG)
  (if terminal-minor-mode
      (my/new-terminal)))

(map! :map vterm-mode-map
      "C-g" #'vterm-send-C-g)

(advice-add 'split-window-below :after #'terminal-auto-new)
(advice-add 'split-window-right :after #'terminal-auto-new)

(defalias '=term 'my/new-terminal)
