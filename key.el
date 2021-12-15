;;; key.el -*- lexical-binding: t; -*-

(setq mac-command-modifier      'super
      ns-command-modifier       'super
      mac-option-modifier       'meta
      ns-option-modifier        'meta
      mac-right-option-modifier 'none
      ns-right-option-modifier  'none)


;; set minibuffer TAB to complete
(map! :when (featurep! :completion ivy)
      :after ivy
      :map ivy-minibuffer-map "TAB" #'ivy-partial)

(map! :leader
      :when (featurep! :app telegram)
      (:prefix ("T" . "telega")
       :after telega
       (:desc "telega"                  "t" #'telega
        :desc "telega-kill"             "k" #'telega-kill
        :desc "telega-chat-with"        "c" #'telega-chat-with
        :desc "telega-switch-buffer"    "b" #'telega-switch-buffer
        :desc "telega-account-switch"   "a" #'telega-account-switch)))

(map! "s-c" #'my/copy)

(map! :map doom-leader-search-map
      "s" #'my/search-symbol-at-point
      "S" #'+default/search-buffer
      "p" #'my/project-search
      "l" #'+my/search-books)

(map! ;; disable ctrl mouse wheel zoom
 "<C-wheel-down>" nil
 "<C-wheel-up>"   nil)

;; C-<space> dose not work on macOS
(map! "C-<tab>" #'set-mark-command)

;; key for mouse logi M590
(map! "<mouse-8>" #'previous-buffer
      "<mouse-9>" #'next-buffer)

(map! :map npm-mode-keymap
      :when (featurep! :lang javascript)
      "C-c l n r" nil)