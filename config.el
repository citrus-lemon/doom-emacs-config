;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load! "style.el")
(load! "key.el")
(load! "mac.el")

(load! "other.el")
;; TODO: still need to clean the writing env for TeX
(load! "org.el")
(when (featurep! :lang org +pretty)
  (load! "org-fancy.el"))

(load! "term.el")
(load! "dashboard.el")
(load! "posframe.el")
(load! "search.el")
(load! "util.el")
(load! "evil.el")
(load! "quickmove.el")
(load! "dired.el")

;; tool
(load! "vendor/change-case.el")

(load! "web.el")
(load! "lang.el")
(load! "browser.el")

;; apps
(load! "telegram.el")

(load! "personal.el")
