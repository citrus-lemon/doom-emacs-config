;;; org.el -*- lexical-binding: t; -*-

(setq org-image-actual-width 400)

;; https://misohena.jp/blog/2020-05-26-limit-maximum-inline-image-size-in-org-mode.html
(defcustom org-limit-image-size '(0.99 . 0.5) "Maximum image size") ;; integer or float or (width-int-or-float . height-int-or-float)

(defun org-limit-image-size--get-limit-size (width-p)
  (let ((limit-size (if (numberp org-limit-image-size)
                        org-limit-image-size
                      (if width-p (car org-limit-image-size)
                        (cdr org-limit-image-size)))))
    (if (floatp limit-size)
        (ceiling (* limit-size (if width-p (frame-text-width) (frame-text-height))))
      limit-size)))

(defvar org-limit-image-size--in-org-display-inline-images nil)

(defun org-limit-image-size--create-image
    (old-func file-or-data &optional type data-p &rest props)

  (if (and org-limit-image-size--in-org-display-inline-images
           org-limit-image-size
           (null type)
           ;;(image-type-available-p 'imagemagick) ;;Emacs27 support scaling by default?
           (null (plist-get props :width)))
      ;; limit to maximum size
      (apply
       old-func
       file-or-data
       (if (image-type-available-p 'imagemagick) 'imagemagick)
       data-p
       (plist-put
        (plist-put
         (org-plist-delete props :width) ;;remove (:width nil)
         :max-width (org-limit-image-size--get-limit-size t))
        :max-height (org-limit-image-size--get-limit-size nil)))

    ;; default
    (apply old-func file-or-data type data-p props)))

(defun org-limit-image-size--org-display-inline-images (old-func &rest args)
  (let ((org-limit-image-size--in-org-display-inline-images t))
    (apply old-func args)))

(defun org-limit-image-size-activate ()
  (interactive)
  (advice-add #'create-image :around #'org-limit-image-size--create-image)
  (advice-add #'org-display-inline-images :around #'org-limit-image-size--org-display-inline-images))

(defun org-limit-image-size-deactivate ()
  (interactive)
  (advice-remove #'create-image #'org-limit-image-size--create-image)
  (advice-remove #'org-display-inline-images #'org-limit-image-size--org-display-inline-images))

(advice-add 'org-roam-dailies--capture :after (lambda (&rest r) (company-mode 0)))
