;;Clean up user interface to make it more minimal

(setq inhibit-startup-message t)

(scroll-bar-mode -1)    ;;Disable visible scrollbar
(tool-bar-mode -1)     ;;Disable the toolbar
(tooltip-mode -1)      ;;Disable tooltips
(set-fringe-mode 10)   ;;Give some breathing room
;;(global-auto-revert-mode t)

(menu-bar-mode -1)     ;;Disable the menu bar

;;Setup the visible bell
(setq visible-bell t)

;;Setup line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;;Indent using spaces
(setq-default indent-tabs-mode nil)

;;Copy and paste to system clipboard
(setq x-select-enable-clipboard t)



;;Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;;Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-auto-revert-mode)

;;Julialang

;;Auto pair brackets C++ and java
(add-hook 'c++-mode-hook 'electric-pair-local-mode)
(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'java-mode-hook 'electric-pair-local-mode)

;;Indentation settings
(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)))

;;Set a ruler at the 80 chars column
(add-hook 'c-mode-hook 'display-fill-column-indicator-mode)
(add-hook 'c++-mode-hook 'display-fill-column-indicator-mode)
(add-hook 'c-mode-hook
          (lambda ()
          (set-fill-column 80)))
(add-hook 'c++-mode-hook
          (lambda ()
          (set-fill-column 80)))



;;ANSI colors on log files
(use-package ansi-color)
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(add-to-list 'auto-mode-alist '("\\.log\\'" . display-ansi-colors))

;;Show log files after testing projectile
(defun projectile-test-and-log ()
    "Open log files after testing projectile"
    (interactive)
    (projectile-test-project "")
    (find-file-other-window (concat (projectile-project-root) "build/Testing/Temporary/LastTest.log"))
    (revert-buffer-quick)
    (display-ansi-colors)
    (revert-buffer-quick)
    (save-buffer)
)


;;Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("elpa" . "http://elpa.gnu.org/packages/")))

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

(use-package julia-mode)

(use-package counsel
  :bind(("M-x" . counsel-M-x)
        ("C-x b" . counsel-ibuffer)
        ("C-x C-f" . counsel-find-file)
        :map minibuffer-local-map
        ("C-r" . 'counsel-minibuffer-history)))
(setq counsel-find-file-ignore-regexp "~")

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
  (setq evil-respect-visual-line-mode t)
  ;;:hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;;This works only if you change ':' and ';'
  ;;Execute macro
  (define-key evil-motion-state-map (kbd "SPC") (kbd "@a"))
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

(use-package magit
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-indexing-method 'hybrid)
  :bind
  (:map projectile-mode-map
        ("C-c p" . 'projectile-command-map)))
;;Ignore gtest directory
(add-to-list 'projectile-globally-ignored-directories '"gtest")
;; Org mode configuration
(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  )

(defun efs/org-mode-setup ()
  (org-indent-mode)
  ;;(variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :bind(
        :map org-mode-map
        ("TAB" . org-cycle)
        ("<tab>" . org-cycle))
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (efs/org-font-setup))

;; Org babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("cpp" . "src cpp"))

(setq org-agenda-files
      '("~/OrgFiles/Tasks.org"
        "~/OrgFiles/cassiopeia.org"))
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-refile-targets
      '(("Archive.org" :maxlevel . 1)
        (nil :maxlevel . 3)))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "PLAN(p)" "ACTIVE(a)" "UPDATE(u)"  "|" "COMPLETED(c)" "CANC(k@))")))

(setq org-tag-alist
      '((:startgroup)
                                        ; Put mutually exclusive tags here
        (:endgroup)
        ("@errand" . ?E)
        ("@home" . ?H)
        ("@work" . ?W)
        ("agenda" . ?a)
        ("planning" . ?p)
        ("publish" . ?P)
        ("batch" . ?b)
        ("note" . ?n)
        ("idea" . ?i)))
;;Set capture templates
(setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)))


;; Configure custom agenda views
(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 7)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))
          (todo "ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

        ("n" "Next Tasks"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ("W" "Work Tasks" tags-todo "+work-email")

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))

        ("w" "Workflow Status"
         ((todo "WAIT"
                ((org-agenda-overriding-header "Waiting on External")
                 (org-agenda-files org-agenda-files)))
          (todo "REVIEW"
                ((org-agenda-overriding-header "In Review")
                 (org-agenda-files org-agenda-files)))
          (todo "PLAN"
                ((org-agenda-overriding-header "In Planning")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "BACKLOG"
                ((org-agenda-overriding-header "Project Backlog")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "READY"
                ((org-agenda-overriding-header "Ready for Work")
                 (org-agenda-files org-agenda-files)))
          (todo "ACTIVE"
                ((org-agenda-overriding-header "Active Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "COMPLETED"
                ((org-agenda-overriding-header "Completed Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "CANC"
                ((org-agenda-overriding-header "Cancelled Projects")
                 (org-agenda-files org-agenda-files)))))))


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(with-eval-after-load 'org-faces
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :weight 'medium :height (cdr face))))

;;org roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/OrgFiles/orgRoam")
  (org-roam-completion-everywhere t)
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  :map org-mode-map
  ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)))
   

;;(use-package org-bibtex)
;;(require 'org-bibtex)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   '("745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" "47db50ff66e35d3a440485357fb6acb767c100e135ccdf459060407f8baea7b2" "cf922a7a5c514fad79c483048257c5d8f242b21987af0db813d3f0b138dfaf53" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "76ed126dd3c3b653601ec8447f28d8e71a59be07d010cd96c55794c3008df4d7" "e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "f7fed1aadf1967523c120c4c82ea48442a51ac65074ba544a5aefc5af490893b" default))
 '(global-display-line-numbers-mode t)
 '(org-agenda-files
   '("/home/artur/OrgFiles/cassiopeia.org" "/home/artur/OrgFiles/Tasks.org") t)
 '(package-selected-packages
   '(nhexl-mode org-roam org-bibtex highlight-doxygen org-mode aas cdlatex undo-tree key-chord which-key use-package ivy-rich helpful evil counsel command-log-mode))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight normal :height 120 :width normal)))))
(put 'upcase-region 'disabled nil)
