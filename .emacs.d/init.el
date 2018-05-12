;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; unicode
(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")
;;

;; Package
(require 'package)
;; Add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; initialize package.el
(package-initialize)
;;

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package
(eval-when-compile
  (require 'use-package))

;; Display line number
(global-linum-mode t)
;; Hight light current line
(global-hl-line-mode t)

(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't))

;; (add-to-list 'load-path "~/org-html5presentation.el")
;;(require 'ox-html5presentation)
;;(setq org-s5-theme "railscast")

;; ggtags
(use-package ggtags
  :ensure t)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	      (ggtags-mode 1)
	      )
	    )
	  )
;;(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;;(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;;(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;;(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;;(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;;(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
;;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; helm-gtags
;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-h") 'helm-gtags-find-tag-from-here)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
     ))
;;JDEE
;;(add-to-list 'load-path "~/.emacs.d/elpa/jdee-20170506.1514")
;;(load "jdee")
;;(add-hook 'jdee-mode-hook
;;	  (lambda()
;;	    (local-set-key [(control return)] 'jdee-complete)
;;	    ))



;; Bootstrap 'use-package
;;(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
;;  (package-install 'use-package))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append '("/usr/local/bin") exec-path))

;;(require 'xcscope)
;;(cscope-setup)

;;(use-package xcscope
;;  :ensure t
;;  :config
;;  (cscope-setup))

;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)
(use-package ecb
  :ensure t)
(require 'ecb)
(setq ecb-tip-of-the-day nil)

;; CEDET
;;(global-ede-mode 1) ;;will conflict with ecb C-c . g [s|d|h]

;; Semantic
(semantic-mode 1)
(require 'semantic/sb)
;; Start auto-complete with emacs
(use-package auto-complete)
;; Do default config for auto-complete
(use-package auto-complete-config
  :config
  (ac-config-default)
  )

;; Start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
;;(setq yas-snippet-dirs
;;      '("~/.emacs.d/plugins/yasnippet/snippets")
;;      )

;; Fix iedit bug in MAC
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; flyspell
;;(add-hook 'org-mode-hook 'flyspell-mode)
(use-package autopair
  :config
  (autopair-global-mode t))
;;
(use-package google-c-style
  :ensure t
  :config
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  )
;; set tab to 4 spaces
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)

;;

;; orgmode 
(eval-after-load 'org
'(progn
     (add-to-list 'org-structure-template-alist
				  '("h" "#+TITLE: title here \n#+AUTHOR: Jared Huang\n#+EMAIL: jared_huang@arcadyan.com\n#+OPTIONS: toc:t ^:nil\n#+SEQ_TODO: REPORTED(r) INVESTIGATING(i) FIXED(f) REOPEN(o) | CLOSED(c)\n#+SEQ_TODO: WAITING(w) TODO(t) NEXT(n) | DONE(d) CANCELLED(l)\n\n* First item")
				  )
	 )
)

;; Key mapping
;;(define-key global-map "\C-ca" 'org-agenda)
;;(define-key global-map "\C-cc" 'org-capture)
;;

;; OS dependence
(when (eq system-type 'darwin)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2016/bin/x86_64-darwin/"))
  (setq exec-path (append exec-path '("/usr/local/texlive/2016/bin/x86_64-darwin")))
  (setq org-latex-pdf-process
	'("xelatex -interaction nonstopmode %f"
	  "xelatex -interaction nonstopmode %f"))  
)


;; maximize window size
;;(add-hook 'after-init-hook '(lambda () (set-frame-size (selected-frame) 210 50) (set-default-font "STSongti-TC-Light-14")))
(add-hook 'after-init-hook '(lambda () (set-frame-size (selected-frame) 150 50)))
;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (light-blue)))
 '(ecb-options-version "2.50")
 '(ecb-source-path
   (quote
	(("/Volumes/jared-1/smart3" "Smart3-8.1")
	 ("/Volumes/jared/smart2_plus" "smart2_plus")
	 ("/Volumes/jared_huang/salt" "salt")
	 ("/Volumes/ExternalSD/smart2_plus_local" "smart2_plus_SD"))))
 '(jdee-compiler (quote ("javac")))
 '(jdee-jdk-registry
   (quote
	(("1.8" . "/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home"))))
 '(jdee-server-dir "~/bin/jars")
 '(org-ditaa-jar-path "~/bin/jars/ditaa0_9.jar")
 '(org-log-into-drawer t)
 '(package-selected-packages
   (quote
	(yasnippet xcscope which-key use-package org-bullets google-c-style ecb autopair)))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; active org-babel language
(org-babel-do-load-languages
 'org-babel-load-languages (quote ((sqlite . t)
				   (python . t)
				   ;;(shell . t)
				   (plantuml . t)
				   (dot . t)
				   (ditaa . t)
				   )))
 
(setq org-plantuml-jar-path
      (expand-file-name "~/bin/jars/plantuml.jar"))

;; stop emacs asking for confirmation
(setq org-confirm-babel-evaluate nil)
;; turn on Syntax coloring
(setq org-src-fontify-natively t)

;;(define-key global-map "\C-ca" 'org-agenda)
;;(define-key global-map "\C-cc" 'org-capture)

;;
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(add-hook 'org-babel-after-execute-hook
	  (lambda ()
	    (when org-inline-image-overlays
	      (org-redisplay-inline-images))))

;; Insert date string
(defun insert-date-string ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "%b %d %Y")))

(defun insert-comments-header-c ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "/**\n * %b %d %Y, Jared Huang\n * Start \n */\n")))

(defun insert-comments-tailer-c ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "/**\n * %b %d %Y, Jared Huang\n * End \n */\n")))

