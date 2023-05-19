;;; personal.el -*- lexical-binding: t; -*-

(setq default-directory "~/")
(setq user-full-name "Full Name"
      user-mail-address "name@example.com")

(setq frame-title-format '("%b – Emacs Master"))
(setq +doom-dashboard-name "*dashboard*")

(defvar icloud-root-directory
  "~/Library/Mobile Documents/com~apple~CloudDocs/"
  "iCloud root directory")

(setq org-directory "~/org/")
;;; if org in iCloud
;; (setq org-directory (expand-file-name "Documents/Memo/" icloud-root-directory))
(setq org-roam-directory org-directory)
(setq org-id-locations-file (expand-file-name ".orgids" org-directory))
(setq org-agenda-files
      (directory-files-recursively org-directory "\\.org$"))

;; projectile auto projects discovery
;; M-x projectile-discover-projects-in-search-path
;; https://docs.projectile.mx/projectile/usage.html#automated-project-discovery
(setq projectile-project-search-path
      '("~/projects/"))

(after! 'magit-forge
  (add-to-list 'forge-alist
               ;; '(
               ;;   "example.gitlab.com"
               ;;   "example.gitlab.com/api/v4"
               ;;   "example.gitlab.com" forge-gitlab-repository)
               ))

(setq auth-sources '("~/.authinfo"))
