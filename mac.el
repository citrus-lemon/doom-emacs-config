;;; mac.el -*- lexical-binding: t; -*-

;; https://lists.gnu.org/archive/html/help-gnu-emacs/2016-01/msg00236.html
(defun my/handle-delete-frame-without-kill-emacs ()
  "Handle delete-frame events from the X server."
  (interactive)
  (let ((frame (selected-frame))
        (i 0)
        (tail (frame-list)))
    (while tail
      (and (frame-visible-p (car tail))
           (not (eq (car tail) frame))
           (setq i (1+ i)))
      (setq tail (cdr tail)))
    (if (> i 0)
        (delete-frame frame t)
      ;; Not (save-buffers-kill-emacs) but instead:
      (progn
        (cd default-directory)
        (+doom-dashboard/open (selected-frame))
        (ns-do-hide-emacs)))))

(when (eq system-type 'darwin)
  (advice-add 'handle-delete-frame :override
              #'my/handle-delete-frame-without-kill-emacs)
  (map! :map global-map "s-q"
        (lambda ()
          (interactive)
          (cd default-directory)
          (+doom-dashboard/open (selected-frame))
          (ns-do-hide-emacs))))
