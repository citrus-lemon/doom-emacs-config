;;; lang.el -*- lexical-binding: t; -*-

(set-formatter! 'swift-format '("swift-format" ("%S" (or buffer-file-name mode-result "")))
  :modes '(swift-mode))

(when (featurep! :lang rust)
  (setq lsp-rust-analyzer-proc-macro-enable t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t))
