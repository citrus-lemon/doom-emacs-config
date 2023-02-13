;;; $DOOMDIR/dashboard.el -*- lexical-binding: t; -*-

(defun my/dashboard-draw-ascii-banner-fn ()
  (let* ((banner
          '("██╗░░░░░███████╗███╗░░░███╗░█████╗░███╗░░██╗"
            "██║░░░░░██╔════╝████╗░████║██╔══██╗████╗░██║"
            "██║░░░░░█████╗░░██╔████╔██║██║░░██║██╔██╗██║"
            "██║░░░░░██╔══╝░░██║╚██╔╝██║██║░░██║██║╚████║"
            "███████╗███████╗██║░╚═╝░██║╚█████╔╝██║░╚███║"
            "╚══════╝╚══════╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚══╝"
            ""
            "                Emacs Master                "
            ""))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my/dashboard-draw-ascii-banner-fn)

(setq +doom-dashboard-menu-sections
      '(("Find note from org-roam"
         :icon (all-the-icons-faicon "sticky-note" :face 'doom-dashboard-menu-title)
         :action org-roam-node-find)
        ("Open org-agenda"
         :icon (all-the-icons-faicon "calendar" :face 'doom-dashboard-menu-title)
         :action org-agenda)
        ("Write diary today"
         :icon (all-the-icons-faicon "lemon-o" :face 'doom-dashboard-menu-title)
         :action org-roam-dailies-goto-today)))

(when (modulep! :app telegram)
  (setq +doom-dashboard-menu-sections
        `(("Telegram: Keyboard War"
           :icon (all-the-icons-faicon "paper-plane" :face 'doom-dashboard-menu-title)
           :action telega)
          ,@+doom-dashboard-menu-sections)))

(advice-remove '+doom-dashboard/open "delete-other-windows")
(advice-add '+doom-dashboard/open :before
            (lambda (&rest _) (delete-other-windows))
            '((name . "delete-other-windows")))
