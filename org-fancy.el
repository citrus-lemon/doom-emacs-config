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
 '(org-block-begin-line ((t (:foreground nil :slant normal :inherit (shadow fixed-pitch)))))
 '(org-block-end-line ((t (:inherit (shadow fixed-pitch)))))
 '(org-todo ((t (:inherit fixed-pitch))))
 '(org-done ((t (:inherit fixed-pitch :foreground "#000000")))))

;; sources code block. from https://github.com/zzamboni/dot-emacs/blob/master/init.org#source-code-blocks

(with-eval-after-load 'org
  (defvar-local rasmus/org-at-src-begin -1
    "Variable that holds whether last position was a ")

  (defvar rasmus/ob-header-symbol ?☰
    "Symbol used for babel headers")

  (defun rasmus/org-prettify-src--update ()
    (let ((case-fold-search t)
          (re "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*")
          found)
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward re nil t)
          (goto-char (match-end 0))
          (let ((args (org-trim
                       (buffer-substring-no-properties (point)
                                                       (line-end-position)))))
            (when (org-string-nw-p args)
              (let ((new-cell (cons args rasmus/ob-header-symbol)))
                (cl-pushnew new-cell prettify-symbols-alist :test #'equal)
                (cl-pushnew new-cell found :test #'equal)))))
        (setq prettify-symbols-alist
              (cl-set-difference prettify-symbols-alist
                                 (cl-set-difference
                                  (cl-remove-if-not
                                   (lambda (elm)
                                     (eq (cdr elm) rasmus/ob-header-symbol))
                                   prettify-symbols-alist)
                                  found :test #'equal)))
        ;; Clean up old font-lock-keywords.
        (font-lock-remove-keywords nil prettify-symbols--keywords)
        (setq prettify-symbols--keywords (prettify-symbols--make-keywords))
        (font-lock-add-keywords nil prettify-symbols--keywords)
        (while (re-search-forward re nil t)
          (font-lock-flush (line-beginning-position) (line-end-position))))))

  (defun rasmus/org-prettify-src ()
    "Hide src options via `prettify-symbols-mode'.
        `prettify-symbols-mode' is used because it has uncollpasing. It's
        may not be efficient."
    (let* ((case-fold-search t)
           (at-src-block (save-excursion
                           (beginning-of-line)
                           (looking-at "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*"))))
      ;; Test if we moved out of a block.
      (when (or (and rasmus/org-at-src-begin
                     (not at-src-block))
                ;; File was just opened.
                (eq rasmus/org-at-src-begin -1))
        (rasmus/org-prettify-src--update))
      ;; Remove composition if at line; doesn't work properly.
      ;; (when at-src-block
      ;;   (with-silent-modifications
      ;;     (remove-text-properties (match-end 0)
      ;;                             (1+ (line-end-position))
      ;;                             '(composition))))
      (setq rasmus/org-at-src-begin at-src-block)))

  ;; This function helps to produce a single glyph out of a
  ;; string. The glyph can then be used in prettify-symbols-alist.
  ;; This function was provided by Ihor in the org-mode mailing list.
  (defun yant/str-to-glyph (str)
    "Transform string into glyph, displayed correctly."
    (let ((composition nil))
      (dolist (char (string-to-list str)
                    (nreverse (cdr composition)))
        (push char composition)
        (push '(Br . Bl) composition))))

  (defun rasmus/org-prettify-symbols ()
    (mapc (apply-partially 'add-to-list 'prettify-symbols-alist)
          (cl-reduce 'append
                     (mapcar (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                             `(("#+begin_src" . ?⎡) ;; ⎡ ➤ 🖝 ➟ ➤ ✎
                               ;; multi-character strings can be used with something like this:
                               ;; ("#+begin_src" . ,(yant/str-to-glyph "```"))
                               ("#+end_src"   . ?⎣) ;; ⎣ ✐
                               ("#+header:" . ,rasmus/ob-header-symbol)
                               ("#+begin_quote" . ?«)
                               ("#+end_quote" . ?»)))))
    (turn-on-prettify-symbols-mode)
    (add-hook 'post-command-hook 'rasmus/org-prettify-src t t))
  (add-hook 'org-mode-hook #'rasmus/org-prettify-symbols))

(setq +org-roam-open-buffer-on-find-file nil)
