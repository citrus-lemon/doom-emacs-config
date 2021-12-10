;;; org-fancy.el -*- lexical-binding: t; -*-

(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)))
(defface my-org-variable-pitch
  '((t (:family "CMU Serif" :height 180)))
  "Face for text of org-mode"
  :group 'org-mode)
(defun my/org-format-hook-fn ()
  (interactive)
  (buffer-face-mode-invoke 'my-org-variable-pitch t)
  (display-line-numbers-mode 0)
  (setq-local org-hide-emphasis-markers t)
  (setq-local left-margin-width 2)
  (setq-local right-margin-width 2)
  (setq-local indicate-empty-lines nil))
(add-hook 'org-mode-hook #'my/org-format-hook-fn)
(custom-theme-set-faces
 'user
 '(fixed-pitch ((t (:family "Fira Code"))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-quote ((t (:family "Baskerville" :height 1.2))))
 '(org-formula ((t (:inherit fixed-pitch))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(org-drawer ((t (:inherit fixed-pitch))))
 '(org-superstar-header-bullet ((t (:family "LXGW WenKai" :inherit fixed-pitch))))
 '(org-block-begin-line ((t (:inherit (shadow fixed-pitch)))))
 '(org-block-end-line ((t (:inherit (shadow fixed-pitch)))))
 '(org-todo ((t (:inherit fixed-pitch))))
 '(org-done ((t (:inherit fixed-pitch :foreground "#000000")))))

(setq +org-roam-open-buffer-on-find-file nil)
