;;; web.el -*- lexical-binding: t; -*-

(when (modulep! :lang javascript)
  (setq typescript-options
        '(:importModuleSpecifierPreference "relative"))
  (setq lsp-clients-typescript-init-opts typescript-options)
  (setq tide-format-options typescript-options)

  (when (modulep! :lang javascript +lsp)
    (defun typescript-eslint-ls-fn ()
      (setq-local lsp-enabled-clients '(ts-ls eslint))
      (add-hook! 'typescript-mode-hook     #'typescript-eslint-ls-fn)
      (add-hook! 'typescript-tsx-mode-hook #'typescript-eslint-ls-fn))))

(use-package! graphql-mode
  :hook (graphql-mode . lsp-deferred)
  :commands (lsp lsp-deferred)
  :when (modulep! :lang web)
  :config
  (load! "vendor/ob-graphql.el"))

(when (modulep! :tools lsp)
  (setq +format-with-lsp nil))
