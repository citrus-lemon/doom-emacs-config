;;; personal.el -*- lexical-binding: t; -*-

(setq default-directory "~/")
(setq user-full-name "Full Name"
      user-mail-address "name@example.com")

(setq frame-title-format '("%b – Emacs Master"))
(setq +doom-dashboard-name "*dashboard*")

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/")
(setq org-agenda-files
      (directory-files-recursively
       "~/org" "\\.org$"))

;; projectile auto projects discovery
;; M-x projectile-discover-projects-in-search-path
;; https://docs.projectile.mx/projectile/usage.html#automated-project-discovery
(setq projectile-project-search-path
      '("~/projects/"))
