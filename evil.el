;;; evil.el -*- lexical-binding: t; -*-

(when (featurep 'evil)
  (setq display-line-numbers-type 'relative)
  (setq evil-want-C-u-scroll nil)
  (map! :m "C-e" #'evil-scroll-up)
  ;; make insert mode same with emacs
  (map! :i "C-n" nil
        :i "C-p" nil
        :i "C-u" #'universal-argument
        :i "C-y" #'yank
        :i "C-d" #'delete-char
        :i "C-k" #'kill-line)
  (map! :map evil-window-map
        "SPC" #'ace-window)
  (map! :map evil-insert-state-map
        "C-<tab>" #'set-mark-command)
  ;; mute recording macro
  (map! :n "q" nil)
  (map! :leader
        :desc "M-x"               ";" #'execute-extended-command
        :desc "Eval Expression"   ":" #'pp-eval-expression)
  (map! :leader
        :when (featurep! :ui workspaces)
        :prefix ("TAB" . "workspace")
        :desc "Display tab bar"           "."   #'+workspace/display
        :desc "Switch workspace"          "TAB" #'+workspace/switch-to
        :desc "New workspace"             "c"   #'+workspace/new
        :desc "New named workspace"       "C"   #'+workspace/new-named
        "N" nil))
