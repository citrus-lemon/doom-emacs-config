;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (featurep! :app telegram)
  (package! telega
    :recipe (:files (:defaults "contrib/*.el" "etc" "server" "Makefile"))))
(when (featurep! :app mastodon)
  (package! mastodon
    :recipe (:host github :repo "WindProphet/mastodon.el")))
(when (featurep! :ui whichkey +childframe)
  (package! which-key-posframe))
(when (featurep! :completion vertico +childframe)
  (package! vertico-posframe))
(when nil
  (package! eldoc-posframe
    :recipe (:host github :repo "WindProphet/eldoc-posframe")))
(when IS-MAC
  (package! dash-at-point
    :recipe (:host github :repo "stanaka/dash-at-point")))
(package! devdocs
  :recipe (:host github :repo "astoff/devdocs.el"))
(when (featurep! :lang web)
  (package! graphql-mode))
(package! coffee-mode)
(package! w3m)

;; isabelle
(package! isar-mode
   :recipe (:local-repo ".../path/to/simp-isar-mode"))
(package! isar-goal-mode
   :recipe (:local-repo ".../path/to/simp-isar-mode"))
(package! lsp-isar
   :recipe (:local-repo ".../isabelle-emacs/src/Tools/emacs-lsp/lsp-isar/"))
(package! lsp-isar-parse-args
   :recipe (:local-repo ".../isabelle-emacs/src/Tools/emacs-lsp/lsp-isar/"))
(package! session-async)
