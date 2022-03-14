;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pierre Balayé"
      user-mail-address "pierre.balaye@gmail.com")

;; Fonts
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans Mono") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 20)
      doom-big-font (font-spec :family "DejaVu Sans Mono" :size 30))

;; Full screen at startup
(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(setq doom-theme 'doom-horizon)

;; Current projects
(projectile-add-known-project "~/WinHome/Nextcloud/Poste-AHU/INCLUDE/ENRICCO/SAS_REBOOT_2022")

;;
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-type nil)

;; Hybrid mode
(setq evil-disable-insert-state-bindings t)

(display-battery-mode 1)
(global-subword-mode 1)
(display-time-mode 1)                             ; Enable time in the mode-line

(setq confirm-kill-emacs nil)

(setq-default
 delete-by-moving-to-trash t            ; Delete files to trash
 window-combination-resize t            ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                    ; Stretch cursor to the glyph width

(setq undo-limit 80000000               ; Raise undo-limit to 80Mb
      evil-want-fine-undo t             ; Be more granular
      auto-save-default t               ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"   ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil         ; I can trust my computers ... can't I?
      ;; scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2)                            ; It's nice to maintain a little margin


;;
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :leader
      (:prefix-map ("a" . "applications")
       (:desc "dired" "d" #'dired)))
