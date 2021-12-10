;;; search.el -*- lexical-binding: t; -*-

;; 什么奇怪魔法，再定义一遍就行了
(defun my/search-symbol-at-point ()
  (interactive)
  (consult-line (thing-at-point 'symbol)))

(defun my/project-search ()
  (interactive)
  (+vertico/project-search nil (thing-at-point 'symbol)))

(defun +my/search-books ()
  "Search in Books Library"
  (interactive)
  (+vertico/find-file-in "~/Documents/Library/"))
