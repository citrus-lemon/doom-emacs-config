;;; other.el -*- lexical-binding: t; -*-


(after! haskell-mode
  (setq haskell-process-args-cabal-repl '("--ghc-option=-ferror-spans -fshow-loaded-modules"))
  (setq haskell-process-args-ghci '("-ferror-spans" "-fshow-loaded-modules"))
  (setq haskell-process-args-stack-ghci
        '("--ghc-options=-ferror-spans -fshow-loaded-modules" "--no-build" "--no-load")))

(setq vterm-shell "/bin/zsh --login -c /opt/homebrew/bin/fish")

(use-package! devdocs
  :config
  (setq devdocs-data-dir (expand-file-name "devdocs" doom-local-dir)))
