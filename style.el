;;; style.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-solarized-light)

(defun font-exists-p (font)
  "Check if font exists"
  (let ((font-list (or (font-family-list) (fc-list))))
    (if (member font font-list)
        t
      nil)))

(defun font-fallback-from (font-list)
  "Get first font avaiable from a list"
  (if (or (not font-list)
          (font-exists-p (car font-list)))
      (car font-list)
   (font-fallback-from (cdr font-list))))

(setq my/cjk-font
      (font-fallback-from
       '("LXGW WenKai"
         "Noto Sans CJK SC"
         "Noto Sans CJK JP"
         "Noto Sans")))

(setq my/monospace-font
      (font-fallback-from
       '("Menlo"
         "Ubuntu Mono"
         "Inconsolata"
         "Noto Mono")))

(setq my/sans-font
      (font-fallback-from
       '("Helvetica"
         "Noto Sans")))

(add-hook! emacs-startup :append
  (set-fontset-font t 'cjk-misc my/cjk-font nil 'prepend)
  (set-fontset-font t 'han my/cjk-font nil 'prepend)
  (set-fontset-font t 'japanese-jisx0208 my/cjk-font nil 'prepend)
  (set-fontset-font t 'korean-ksc5601 my/cjk-font nil 'prepend)
  (set-fontset-font t nil my/monospace-font nil 'append))
(custom-theme-set-faces
 'user
 `(variable-pitch ((t (:family ,my/sans-font)))))
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
(setq doom-modeline-height 20)
(custom-set-faces
  '(mode-line ((t (:height 80))))
  '(mode-line-inactive ((t (:height 80)))))

;; custom folding style
(defun +fold-hideshow-set-up-overlay-fn (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (when (featurep 'vimish-fold)
      (overlay-put
       ov 'before-string
       (propertize "…" 'display
                   (list vimish-fold-indication-mode
                         'empty-line
                         'vimish-fold-fringe))))
    (overlay-put
     ov 'display (propertize " ... " 'face '+fold-hideshow-folded-face))))

(setq so-long-action #'so-long-minor-mode)
