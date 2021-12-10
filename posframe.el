;;; posframe.el -*- lexical-binding: t; -*-

(setq which-key-idle-delay 0.01)

(defun my/posframe-poshandler-frame-bottom-right-corner (info)
  (cons (- (plist-get info :parent-frame-width)
           (plist-get info :posframe-width)
           10)
        (- (plist-get info :parent-frame-height)
           (plist-get info :posframe-height)
           (plist-get info :mode-line-height)
           (plist-get info :minibuffer-height)
           20)))

(use-package! which-key-posframe
  :when (featurep! :ui whichkey +childframe)
  :config
  (which-key-posframe-mode)
  (setq which-key-posframe-poshandler
        'my/posframe-poshandler-frame-bottom-right-corner))

(use-package! vertico-posframe
  :when (featurep! :completion vertico +childframe)
  :init
  (defun my/vertico-posframe-get-size ()
    "The size functon used by `vertico-posframe-size-function'."
    (list
     :height vertico-posframe-height
     :width vertico-posframe-width
     :max-width (min (frame-width) 150)
     :min-height (or vertico-posframe-min-height
                     (let ((height (+ vertico-count 1)))
                       (min height (or vertico-posframe-height height))))
     :min-width  (or vertico-posframe-min-width
                     (let ((width (round (* (frame-width) 0.62))))
                       (min width (or vertico-posframe-width width))))))
  :custom
  (vertico-posframe-size-function #'my/vertico-posframe-get-size)
  (vertico-posframe-border-width 1)
  :config
  (vertico-posframe-mode 1))

(use-package! eldoc-posframe
  :when nil
  :custom
  (eldoc-posframe-poshandler #'posframe-poshandler-point-bottom-left-corner-upward)
  (eldoc-posframe-max-width 50)
  (eldoc-posframe-padding 1)
  :custom-face
  (eldoc-posframe-background-face ((t :inherit tooltip)))
  :config
  (when (not (featurep! :lang javascript +lsp))
    (add-hook! 'typescript-mode-hook     #'eldoc-posframe-mode)
    (add-hook! 'typescript-tsx-mode-hook #'eldoc-posframe-mode)
    (add-hook! 'rjsx-mode-hook           #'eldoc-posframe-mode)))
