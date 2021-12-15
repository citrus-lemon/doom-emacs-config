;;; evil.el -*- lexical-binding: t; -*-

(when (featurep 'evil)
  (setq display-line-numbers-type 'relative)
  (setq evil-want-C-u-scroll nil)
  (map! :m "C-e" #'evil-scroll-up)
  ;; make insert mode same with emacs
  (map! :i "C-n" nil
        :i "C-p" nil
        :i "C-y" #'yank
        :i "C-d" #'delete-char
        :i "C-k" #'kill-line)
  (map! :leader
        :when (featurep! :ui workspaces)
        :prefix ("TAB" . "workspace")
        :desc "Display tab bar"           "."   #'+workspace/display
        :desc "Switch workspace"          "TAB" #'+workspace/switch-to
        :desc "New workspace"             "c"   #'+workspace/new
        :desc "New named workspace"       "C"   #'+workspace/new-named
        "N" nil))
