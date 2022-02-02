;;; lang.el -*- lexical-binding: t; -*-

(set-formatter! 'swift-format '("swift-format" ("%S" (or buffer-file-name mode-result "")))
  :modes '(swift-mode))
