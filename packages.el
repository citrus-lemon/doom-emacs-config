;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(when (modulep! :app telegram)
  (package! telega
    :recipe (:files (:defaults "contrib/*.el" "etc" "server" "Makefile"))))
(when (modulep! :app mastodon)
  (package! mastodon
    :recipe (:host github :repo "WindProphet/mastodon.el")))
(when (modulep! :ui whichkey +childframe)
  (package! which-key-posframe))
(when (modulep! :completion vertico +childframe)
  (package! vertico-posframe))
(when nil
  (package! eldoc-posframe
    :recipe (:host github :repo "WindProphet/eldoc-posframe")))
(when IS-MAC
  (package! dash-at-point
    :recipe (:host github :repo "stanaka/dash-at-point")))
(package! devdocs
  :recipe (:host github :repo "astoff/devdocs.el"))
(when (modulep! :lang web)
  (package! graphql-mode))
(package! coffee-mode)
(package! w3m)
(when (modulep! :lang isar)
  (package! isar-mode
    :recipe (:host github :repo "m-fleury/isar-mode"))
  (package! lsp-isar
    :recipe (:host github
             :repo "m-fleury/isabelle-emacs"
             :branch "Isabelle2021-1-more-vscode"
             :pre-build (("./bin/isabelle" "components" "-I")
                         ("./bin/isabelle" "components" "-a")
                         ("./bin/isabelle" "build" "-b" "HOL"))
             :files ("src/Tools/emacs-lsp/lsp-isar/*.el")))
  (package! session-async))
(when (modulep! :lang swift)
  (package! ob-swift))
