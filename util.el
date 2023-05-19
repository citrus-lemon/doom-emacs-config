;;; util.el -*- lexical-binding: t; -*-

(defun my/copy (&optional ARG)
  (interactive "p")
  (if mark-active
      (copy-region-as-kill (region-beginning) (region-end))
    (if ARG
        (copy-region-as-kill (line-beginning-position) (line-end-position))
      (kill-new (thing-at-point 'symbol)))))

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

(defun lift--least-recent-from-kill-ring (string &optional arg)
  (when string (kill-new string)))

(advice-add #'consult-yank-from-kill-ring :before #'lift--least-recent-from-kill-ring)

(defun my/load-org-tangle-config (id &optional sym)
  (when (and (not (featurep sym)) (org-id-find id))
    (save-window-excursion
      (org-id-goto id)
      (let* ((tangle-list (org-babel-tangle))
             (el-file (expand-file-name (car tangle-list) default-directory)))
        (when (file-exists-p el-file)
          (when sym (write-region (format "(provide '%s)" sym) nil el-file 'append))
          (load el-file t))))))
(defalias 'config! #'my/load-org-tangle-config)
