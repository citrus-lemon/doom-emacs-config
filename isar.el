;;; isar.el -*- lexical-binding: t; -*-

;; Isabelle setup
(use-package! isar-mode
  :mode "\\.thy\\'"
  :config
  ;; (add-hook 'isar-mode-hook 'turn-on-highlight-indentation-mode)
  ;; (add-hook 'isar-mode-hook 'flycheck-mode)
  (add-hook 'isar-mode-hook 'company-mode)
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet)))))
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'indent-tabs-mode) nil)))
  (add-hook 'isar-mode-hook
            (lambda ()
              (yas-minor-mode)))
  )

(use-package! lsp-isar-parse-args
  :custom
  (lsp-isar-parse-args-nollvm nil))

(use-package! lsp-isar
  :commands lsp-isar-define-client-and-start
  :custom
  (lsp-isar-output-use-async t)
  (lsp-isar-output-time-before-printing-goal nil)
  (lsp-isar-experimental t)
  (lsp-isar-split-pattern 'lsp-isar-split-pattern-three-columns)
  (lsp-isar-decorations-delayed-printing t)
  :init
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-right-spacemacs)
  (add-hook 'isar-mode-hook #'lsp-isar-define-client-and-start)

  (push (concat ".../isabelle-emacs/src/Tools/emacs-lsp/yasnippet")
   yas-snippet-dirs)
  (setq lsp-isar-path-to-isabelle ".../isabelle-emacs")
  )
