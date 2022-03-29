;;; browser.el -*- lexical-binding: t; -*-

(use-package! w3m
  :commands (w3m w3m-search)
  :config
  (setq w3m-search-default-engine "google-en")
  (setq w3m-use-tab-line nil))
