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

;; https://emacs.stackexchange.com/questions/30942/insert-a-string-from-eval-expression-without-the-quotes#answer-30960
(defun vicarie/eval-last-sexp-and-do (f)
  "Eval the last sexp and call F on its value."
  (let ((standard-output (current-buffer))
        (value (eval-last-sexp nil)))
    (funcall f value)))
(defun vicarie/eval-print-last-sexp ()
  "Evaluate and print the last sexp on the same line."
  (interactive)
  (vicarie/eval-last-sexp-and-do (lambda (value)
                                   (insert (format " (= %s ) " value)))))
(defun vicarie/eval-replace-last-sexp ()
  "Evaluate and replace last sexp with its value."
  (interactive)
  (vicarie/eval-last-sexp-and-do (lambda (value)
                                   (backward-kill-sexp)
                                   (insert (format "%s" value)))))

;;(map! :map emacs-lisp-mode-map "C-c +" #'vicarie/eval-replace-last-sexp)

(defun random-color ()
  (let* ((colors-list (defined-colors))
         (size (length colors-list))
         (index (random size))
         (color (nth index colors-list))
         (rgb (color-name-to-rgb color))
         (str (string-join
               (mapcar 'number-to-string rgb) ", ")))
    (propertize str 'font-lock-face `(:background ,color))))

(defun insert-random-color-rgb ()
  (interactive)
  (insert (random-color)))