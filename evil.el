;;; evil.el -*- lexical-binding: t; -*-

(when (featurep 'evil)
  (setq display-line-numbers-type 'relative)
  (map! :map evil-motion-state-map "C-e" #'evil-scroll-up)
  (map! :map evil-insert-state-map
        "C-n" nil
        "C-p" nil)
  (map! :leader
        :when (featurep! :ui workspaces)
        :prefix ("TAB" . "workspace")
        :desc "Display tab bar"           "."   #'+workspace/display
        :desc "Switch workspace"          "TAB" #'+workspace/switch-to
        :desc "New workspace"             "c"   #'+workspace/new
        :desc "New named workspace"       "C"   #'+workspace/new-named
        "N" nil))
