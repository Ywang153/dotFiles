;================================== Sections ==================================
;    -> General
;    -> Plugins
;    -> Misc
;    -> Helper functions
;
;==============================================================================

;;=================================== General ==================================
; Changing the default folder
(setq default-directory (concat (getenv "HOME") "/"))

; Splash Screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

; Scroll bar, Tool bar, Menu bar
(if (display-graphic-p) (scroll-bar-mode -1))
(if (display-graphic-p) (tool-bar-mode -1))
(if (not (display-graphic-p)) (menu-bar-mode -1))

; Display line numbers
(global-linum-mode t)
(column-number-mode t)

; Standard Copy Paste Keys
(cua-mode 1)

; Text Highlighting
(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing
(global-font-lock-mode 1) ; turn on syntax coloring
(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression

; Font
(set-face-attribute 'default nil :height 120)

; Marking text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

; Display Settings
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

; Indentation
(setq tab-width 4 indent-tabs-mode nil)

; Backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

; Recent mode
(recentf-mode 1)

; Line Margin, Line Wrap, Line Spacing
(setq line-move-visual nil)
(global-visual-line-mode 1)

; Toggle the right margin between `fill-column' or window width.  This command is convenient when reading novel, documentation."
(defun xah-toggle-margin-right ()
  (interactive)
  (if (eq (cdr (window-margins)) nil)
    (set-window-margins nil 0 (- (window-body-width) fill-column))
    (set-window-margins nil 0 0) ) )

; Toggle line spacing between no extra space to extra half line height."
(defun xah-toggle-line-spacing ()
  (interactive)
  (if (eq line-spacing nil)
    (setq line-spacing 0.5) ; add 0.5 height between lines
    (setq line-spacing nil)   ; no extra heigh between lines
    )
  (redraw-frame (selected-frame)))

; Fixed Scroll
(global-hl-line-mode 1)

; Yes and No
(defalias 'yes-or-no-p 'y-or-n-p)

; Key bindings
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)


;;=================================== Color Theme ==================================
; Solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
(if (display-graphic-p)
  (load-theme 'solarized-dark t)
  (load-theme 'solarized-light t))


;;=================================== Misc ==================================
; Turn down the time to echo keystrokes 
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

; How to set cursor to i-beam?
(modify-all-frames-parameters (list (cons 'cursor-type 'bar)))

; Deactivate vc-git
(setq vc-handled-backends ())


;;=================================== Package Management ==================================
; set package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("popkit" . "http://elpa.popkit.org/packages/")))

; Only support emacs 24 or above
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)

  (when (not package-archive-contents)
    (package-refresh-contents))

  (defvar comm-packages '(company
                           web-mode
                           evil
                           smex
                           yasnippet))

  (dolist (pkg comm-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg)))
  )

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

