;;Clean up user interface to make it more minimal

(setq inhibit-startup-message t)

(scroll-bar-mode -1)    ;;Disable visible scrollbar
(tool-bar-mode -1)     ;;Disable the toolbar
(tooltip-mode -1)      ;;Disable tooltips
(set-fringe-mode 10)   ;;Give some breathing room

(menu-bar-mode -1)     ;;Disable the menu bar

;;Setup the visible bell
(setq visible-bell t)

;;Setup line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;;Indent using spaces
(setq-default indent-tabs-mode nil)



;;Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
 (add-hook mode (lambda() (display-line-numbers-mode 0))))

;;Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-auto-revert-mode)

;;Auto pair brackets C++ and java
(add-hook 'c++-mode-hook 'electric-pair-local-mode)
(add-hook 'java-mode-hook 'electric-pair-local-mode)

;;java indentation
;;(defun my-indent-setup()
  ;;(c-set-offset 'arglist-intro '+))
;;(add-hook 'java-mode-hook 'my-indent-setup)


;;Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;;Theme settings
(use-package doom-themes
  :ensure t)
(load-theme 'doom-moonlight t)

;;Doom mode line
(use-package doom-modeline
  :ensure t
  :init(doom-modeline-mode 1))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(use-package counsel
  :bind(("M-x" . counsel-M-x)
	("C-x b" . counsel-ibuffer)
	("C-x C-f" . counsel-find-file)
	:map minibuffer-local-map
	("C-r" . 'counsel-minibuffer-history)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package swiper)



(use-package ivy-rich
  :init
  (ivy-rich-mode 1))



;;Helpful package
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;Use package which key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-delay 0.3))

;;Evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-scroll nil)
  ;;:hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  (use-package key-chord)

  :init
  (setq key-chord-two-keys-delay 0.1)
  :config
  (key-chord-mode 1))

;;Switch colon and semicolon on normal mode
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map ":" 'evil-repeat-find-char)

;;Remap esc key
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(use-package undo-tree
  :ensure t 
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))


;;Latex settings
(use-package auctex
  :defer t
  :ensure t)
(add-hook 'LaTeX-mode-hook 'prettify-symbols-mode)

(use-package cdlatex
  :config
  (define-key cdlatex-mode-map "^" nil)
  (define-key cdlatex-mode-map "_" nil)
  )
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

(use-package aas
  :hook (LaTeX-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets
   'latex-mode
   ;;Expand only in math mode
   :cond #'texmathp
   "sr" "^2"
   "cb" "^3"
   "td" (lambda () (interactive) (insert " td")
	  (yas-expand))
   "df" (lambda() (interactive) (yas-expand-snippet "\\diff{$1}{$2}$0"))
   "dp" (lambda() (interactive) (yas-expand-snippet "\\diffp{$1}{$2}$0"))
   "_"  (lambda() (interactive) (yas-expand-snippet "_{$1}$0"))
   "lapl" (lambda() (interactive) (insert " lapl") (yas-expand))
   )
  (aas-set-snippets
   `latex-mode
   ;;Expand everywhere
   "mk" (lambda () (interactive) (insert "mk")
	  (yas-expand))
   "dm" (lambda () (interactive) (insert "dm")
	  (yas-expand))
   )
  (aas-set-snippets
   'latex-mode
   ;;Bind to functions
   ;;Only math mode
   :cond #'texmathp
   "//" (lambda () (interactive)
	  (yas-expand-snippet "\\frac{$1}{$2}$0")))
  )
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))
(require 'warnings)
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(org-mode aas cdlatex undo-tree key-chord which-key use-package ivy-rich helpful evil counsel command-log-mode))
 '(tool-bar-mode nil))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight normal :height 98 :width normal)))))
