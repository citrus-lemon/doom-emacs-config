;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load! "personal.el")
(load! "style.el")
(load! "key.el")
(load! "mac.el")

(load! "other.el")
(load! "web.el")
(when (featurep! :lang org +pretty)
  (load! "org-fancy.el"))

(load! "dashboard.el")
(load! "posframe.el")
(load! "search.el")
(load! "util.el")
(load! "quickmove.el")

(load! "telegram.el")
(load! "evil.el")
