;; .emacs
(global-linum-mode)
(ido-mode 1)
(menu-bar-mode -1)

;;(setq-default indent-tabs-mode  nil)
;;(setq tab-width 2
;;      c-basic-offset 2)


;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(desktop-save t)
 '(desktop-save-mode t)
 '(directory-abbrev-alist nil)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(global-hl-line-mode t)
 '(highlight-current-line-whole-line nil)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote right))
 '(indicate-empty-lines t)
 '(make-backup-files nil)
 '(python-guess-indent nil)
 '(python-indent 2)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tool-bar-mode nil))
'(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#202020" :foreground "#DDDDDD" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 161 :width normal :family "apple-consolas"))))
 '(column-marker-1 ((t (:background "red"))))
 '(cursor ((t (:background "white"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "red"))))
 '(hl-line ((t (:background "#444444"))))
 '(linum ((t (:inherit (shadow default)))))
 '(shadow ((((class color) (min-colors 8) (background dark)) (:foreground "green")))))

;; font configuration
;; (set-default-font "Monospace-12")

;; copy text from emacs
(setq x-select-enable-clipboard t)

(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

(setq load-path (cons "~/.emacs.el.d" load-path))
(require 'desktop)
(require 'msb)(msb-mode 1)
(require 'iswitchb)
;;(require 'column-marker)
(require 'google-c-style)
;;(require 'java-mode-indent-annotations)
;; (require 'php-mode)

;; shell mode colors
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'c-mode-common-hook 
          (lambda () 
            (interactive) 
            ;;(column-marker-1 80)
            (c-toggle-auto-hungry-state 1)
            (c-toggle-auto-newline 1)
            ))

;; c style
;; (add-hook 'c-mode-common-hook '(lambda () (c-set-style "stroustrup")))
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; c hungry mode
;; (add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-hungry-state 1)))

;; java annotation indent
;; (add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)
;; (add-hook 'java-mode-hook 'google-set-c-style)
;; (add-hook 'java-mode-hook 'google-make-newline-indent)


;;
;; count-words-region
;;
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
  (save-excursion
    (let ((count 0))
      (goto-char beginning)
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;;
;; zap tabs
;;
(defun untabify-buffer ()
  "Untabify an entire buffer"
  (interactive)
  (untabify (point-min) (point-max)))

;;
;; re-indent buffer
;;
(defun indent-buffer()
  "Reindent an entire buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil))

;;
;; Untabify, re-indent, make EOL be '\n' not '\r\n'
;;   and delete trailing whitespace
;;
(defun format-buffer()
  "Untabify and re-indent an entire buffer"
  (interactive)
  (if (equal buffer-file-coding-system 'undecided-unix )
      nil
    (set-buffer-file-coding-system 'undecided-unix))
  (untabify-buffer)
  (indent-buffer)
  (delete-trailing-whitespace))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)
;;(set-language-environment "han")
;; (set-default-coding-systems 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;;(set-fontset-font (frame-parameter nil 'font)
;;              han '("Microsoft YaHei" . "unicode-bmp"))


(defun switch-global-coding-system (coding-system)
  (interactive "zCoding system: ")
  (set-terminal-coding-system coding-system)
  (set-keyboard-coding-system coding-system))

(dolist (coding-system '(gbk utf-8))
  (prefer-coding-system coding-system))
(switch-global-coding-system 'utf-8)


;; format line number, add space after line number
(setq linum-format "%d ")
