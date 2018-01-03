;; .emacs

(setq visible-bell 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           확장자 관리
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-mode-alist
      (append '(
				("CMakeLists\\.txt\\'" . cmake-mode)
				("\\.cmake\\'" . cmake-mode))
			  auto-mode-alist ))
(setq auto-mode-alist
      (append '(
				("\\.proto\\'" . protobuf-mode))
			  auto-mode-alist ))

(add-to-list 'auto-mode-alist '("\\.json\\'" . js-mode))
(add-to-list 'magic-mode-alist '("#!/usr/bin/python" . python-mode))
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           tabbar 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (and window-system (load "tabbar" t))

  (tabbar-mode t)
  (global-set-key [(control f10)] 'tabbar-local-mode)
  (global-set-key (kbd "<M-right>") 'tabbar-forward-tab)
  (global-set-key (kbd "<M-left>") 'tabbar-backward-tab)
  (global-set-key (kbd "<M-up>") 'tabbar-forward-group)
  (global-set-key (kbd "<M-down>") 'tabbar-backward-group))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           cscope 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'xcscope)
(define-key global-map [(f5)]  'cscope-find-this-symbol)
(define-key global-map [(f6)]  'cscope-find-global-definition)
(define-key global-map [(f7)]
  'cscope-find-global-definition-no-prompting)
(define-key global-map [(f8)]  'cscope-pop-mark)
 
(define-key global-map [(f9)] 'compile)
 
(windmove-default-keybindings 'shift)
;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
 
 
;; enable visual feedback on selections
;(setq transient-mark-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           title 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           indent, coding style 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(setq-default indent-tab-mode nil)
(setq default-tab-width 4)
(add-hook 'c-mode-hook
          (lambda ()       
            (setq c-basic-offset 4)))
(add-hook 'c-mode-common-hook '(lambda () (c-set-style "Stroustrup")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           GDB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun gdb-in-new-frame ()
  (interactive)
  (select-frame-set-input-focus (make-frame))
  (call-interactively 'gdb) )
 
(global-set-key [(control c)(D)] 'gdb-in-new-frame)
 
(setq gdb-many-windows t)
(scroll-bar-mode nil)
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           개인 단축키
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; goto line
(global-set-key "\M-g" 'goto-line)
;; register
(global-set-key "\M-p" 'point-to-register)
(global-set-key "\M-[" 'jump-to-register)
 
;; hide and show
(define-key global-map [(f2)] 'hs-toggle-hiding)
(load-library "hideshow")
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
 
(defun my-insert-line()
  "insert blank line below the cursor"
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key "\M-o" 'my-insert-line)
 
;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))
 
;; Press [pause] key in each window you want to "freeze"
(global-set-key [pause] 'toggle-window-dedicated)
(global-cwarn-mode 1)
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           한글
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(global-set-key (kbd "M-1") 'toggle-input-method)
(global-set-key (kbd "S-SPC") 'toggle-input-method)
(global-set-key (kbd "<Hangul>") 'toggle-input-method)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-face-font 'default "NanumGothicCoding")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           ORG-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;;(setq org-agenda-files (list "~/Dropbox/org/priv/nako.org" "~/Dropbox/org/cpro_doc/todo.org"
(setq org-agenda-files (list  "~/Dropbox/org/cpro_doc/swteam/agenda.org"
							  "~/Dropbox/org/cpro_doc/swteam/agenda_2018.org"))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil) 
(setq column-number-mode t)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Clojure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(require 'clojure-mode)


(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")

(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           모양
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#102e4e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "outline" :family "NanumGothicCoding")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'helm-config)
;;(setq helm-idle-delay 0.1)
;;(setq helm-input-idle-delay 0.1)

;;(global-set-key (kbd "M-t") 'helm-for-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Color
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-deep-blue)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           기타
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 안쓰는 키 끄기
(global-unset-key "\C-z")

;; scroll
(define-key global-map [(f11)]  'scroll-up-line)
(define-key global-map [(f12)]  'scroll-down-line)
(setq scroll-step 3)

(setq make-backup-files nil)    

;; default to unified diffs
(setq diff-switches "-u")
 
;; always end a file with a newline
;(setq require-final-newline 'query)
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list (quote (("dvips and gv" "%(o?)dvips %d -o && gv %f"))))
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(default-input-method "korean-hangul390")
 '(package-selected-packages
   (quote
	(tabbar yasnippet xcscope color-theme-solarized cmake-mode clojure-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))


(global-auto-revert-mode 1)

;; TEST
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)


(require 'yasnippet)
(yas-global-mode 1)

(require 'iedit)


;; AucTex
(require 'tex-site)
(setq latex-run-command "pdflatex")
