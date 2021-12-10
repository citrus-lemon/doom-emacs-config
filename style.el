;;; style.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-solarized-light)
(add-hook! emacs-startup :append
  (set-fontset-font t 'cjk-misc "LXGW WenKai" nil 'prepend)
  (set-fontset-font t 'han "LXGW WenKai" nil 'prepend)
  (set-fontset-font t 'japanese-jisx0208 "LXGW WenKai" nil 'prepend)
  (set-fontset-font t 'korean-ksc5601 "LXGW WenKai" nil 'prepend)
  (set-fontset-font t nil "Menlo" nil 'append))
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Helvetica")))))
(setq default-frame-alist
      `((left . 400)
        (top . 100)
        (width . 120)
        (height . 60)
        ,@default-frame-alist))
(setq display-line-numbers-type t)
(add-to-list 'default-frame-alist '(cursor-type . bar))

(use-package! prettify-symbols
  :hook
  (emacs-lisp-mode . prettify-symbols-mode)
  (python-mode     . prettify-symbols-mode)
  (ruby-mode       . prettify-symbols-mode))

;; Workspace buffer not showing all buffers
;; https://github.com/hlissner/doom-emacs/issues/1189
(after! persp-mode
  (remove-hook 'persp-add-buffer-on-after-change-major-mode-filter-functions #'doom-unreal-buffer-p))

(after! treemacs
  (advice-add 'treemacs-find-file :after #'treemacs-select-window))

(add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)

;;(setq doom-modeline-persp-name t)
(setq doom-modeline-persp-icon nil)
