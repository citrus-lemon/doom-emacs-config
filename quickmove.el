;;; quickmove.el -*- lexical-binding: t; -*-

(define-minor-mode quickmove-mode
  "Toggle QuickMove mode.
Release little finger from control"
  :init-value nil
  :keymap
  '(([?n] . next-line)
    ([?p] . previous-line)
    ([?f] . forward-char)
    ([?b] . backward-char)
    ([?a] . move-beginning-of-line)
    ([?e] . move-end-of-line)
    ([?v] . scroll-up-command)
    ([?c] . scroll-down-command)
    ([?l] . recenter-top-bottom)))

(defun quickmove-auto-enable ()
  (if buffer-read-only
      (quickmove-mode 1)
    (quickmove-mode 0)))

(add-hook 'read-only-mode-hook #'quickmove-auto-enable)
