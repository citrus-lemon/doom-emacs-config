;;; quickmove.el -*- lexical-binding: t; -*-

(define-minor-mode quickmove-mode
  "Toggle QuickMove mode.
Release little finger from control"
  :init-value nil
  :keymap
  '(([?n] . next-line)
    ([?p] . previous-line)
    ([?f] . forward-char)
    ([?b] . backward-char)
    ([?a] . move-beginning-of-line)
    ([?e] . move-end-of-line)
    ([?v] . scroll-up-command)
    ([?c] . scroll-down-command)
    ([?l] . recenter-top-bottom)))

(map! :map quickmove-mode-map
      "TAB" #'+fold/toggle)

(defun quickmove-auto-enable ()
  (if buffer-read-only
      (quickmove-mode 1)
    (quickmove-mode 0)))

(add-hook 'read-only-mode-hook #'quickmove-auto-enable)

(map! "C-x C-<tab>" #'ace-window)

(defhydra hydra-viewer (:color pink :hint nil)
  "
                                                                        ╔════════╗
   Char/Line^^^^^^  Word/Page^^^^^^^^  Line/Buff^^^^   Paren                              ║ Window ║
  ──────────────────────────────────────────────────────────────────────╨────────╜
       ^^_k_^^          ^^_u_^^          ^^_g_^^       _(_ ← _y_ → _)_
       ^^^↑^^^          ^^^↑^^^          ^^^↑^^^       _,_ ← _/_ → _._
   _h_ ← _d_ → _l_  _H_ ← _D_ → _L_  _a_ ← _K_ → _e_
       ^^^↓^^^          ^^^↓^^^          ^^^↓^
       ^^_j_^^          ^^_n_^^          ^^_G_
  ╭──────────────────────────────────────────────────────────────────────────────╯
                           [_q_]: quit, [_<SPC>_]: center
          "
  ("j" scroll-down-in-place)
  ("k" scroll-up-in-place)
  ("l" forward-char)
  ("d" delete-char)
  ("h" backward-char)
  ("L" forward-word)
  ("H" backward-word)
  ("u" scroll-up-command)
  ("n" scroll-down-command)
  ("D" delete-word-at-point)
  ("a" mwim-beginning-of-code-or-line)
  ("e" mwim-end-of-code-or-line)
  ("g" beginning-of-buffer)
  ("G" end-of-buffer)
  ("K" kill-whole-line)
  ("(" backward-list)
  (")" forward-list)
  ("y" yank-inner-sexp)
  ("." backward-forward-next-location)
  ("," backward-forward-previous-location)
  ("/" avy-goto-char :exit t)
  ("<SPC>" recenter-top-bottom)
  ("q" nil)
  ("C-g" nil))
