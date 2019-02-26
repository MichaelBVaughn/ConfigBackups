
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3e83abe75cebf5621e34ce1cbe6e12e4d80766bed0755033febed5794d0c69bf" "af717ca36fe8b44909c984669ee0de8dd8c43df656be67a50a1cf89ee41bde9a" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "de0b7245463d92cba3362ec9fe0142f54d2bf929f971a8cdf33c0bf995250bcf" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "228c0559991fb3af427a6fa4f3a3ad51f905e20f481c697c6ca978c5683ebf43" "d61f6c49e5db58533d4543e33203fd1c41a316eddb0b18a44e0ce428da86ef98" "01e067188b0b53325fc0a1c6e06643d7e52bc16b6653de2926a480861ad5aa78" "c79c2eadd3721e92e42d2fefc756eef8c7d248f9edefd57c4887fbf68f0a17af" "e30f381d0e460e5b643118bcd10995e1ba3161a3d45411ef8dfe34879c9ae333" "c616e584f7268aa3b63d08045a912b50863a34e7ea83e35fcab8537b75741956" "66aea5b7326cf4117d63c6694822deeca10a03b98135aaaddb40af99430ea237" "a94f1a015878c5f00afab321e4fef124b2fc3b823c8ddd89d360d710fc2bddfc" "0cd56f8cd78d12fc6ead32915e1c4963ba2039890700458c13e12038ec40f6f5" "da538070dddb68d64ef6743271a26efd47fbc17b52cc6526d932b9793f92b718" "73a13a70fd111a6cd47f3d4be2260b1e4b717dbf635a9caee6442c949fad41cd" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "d057f0430ba54f813a5d60c1d18f28cf97d271fd35a36be478e20924ea9451bd" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(package-selected-packages
   (quote
    (autumn-light-theme auctex git-gutter helm-spotify-plus helm-spotify spotify sunshine jabber airline-themes powerline magit idris-mode intero company-irony irony-eldoc flycheck-irony irony ## gnuplot-mode gams-mode dash flycheck-rust elm-mode hy-mode company-racer racer cargo zenburn-theme w32-browser w3 unicode-fonts tuareg toml-mode slime seq rust-mode racket-mode go-complete go-autocomplete ghc fsharp-mode flycheck-haskell f dash-functional company-go cm-mode cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun zenburn-init ()
  (load-theme 'zenburn))

(add-hook 'after-init-hook 'zenburn-init)

(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(setq c-default-style "linux")

;;git stuff
(global-set-key (kbd "C-x g") 'magit-status)

;;Org-mode stuff
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


(load-file "/Users/michael/ProofGeneralSetup/ProofGeneral/generic/proof-site.el")

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'haskell-mode-hook 'intero-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;;racer: autocomplete for Rust
(setq racer-cmd "~/.cargo/bin/racer") ;;binaries for Rust completion tool

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'cargo-minor-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;;Go stuffs
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends)
			       '(company-go))
			  (company-mode)))

(eval-after-load "proof-script" '(progn
				   (define-key proof-mode-map "\C-c\r"
				     'proof-goto-point)))
(require 'rust-mode)
(define-key rust-mode-map (kbd "C-c i") 'racer-describe)

(setq inferior-lisp-program (executable-find "sbcl"))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require 'flycheck)
(add-hook 'c++-mode-hook
	  (lambda () (setq flycheck-clang-language-standard "c++11")))
(add-hook 'irony-mode-hook 'company-mode)
(require 'powerline)
(require 'airline-themes)
(setq powerline-utf-8-separator-left        #xe0b0
      powerline-utf-8-separator-right       #xe0b2
      airline-utf-glyph-separator-left      #xe0b0
      airline-utf-glyph-separator-right     #xe0b2
      airline-utf-glyph-subseparator-left   #xe0b1
      airline-utf-glyph-subseparator-right  #xe0b3
      airline-utf-glyph-branch              #xe0a0
      airline-utf-glyph-readonly            #xe0a2
      airline-utf-glyph-linenumber          #xe0a1)

;; (setq powerline-utf-8-separator-left        #xe0b8
;;       powerline-utf-8-separator-right       #xe0ba
;;       airline-utf-glyph-separator-left      #xe0b8
;;       airline-utf-glyph-separator-right     #xe0ba
;;       airline-utf-glyph-subseparator-left   #xe0b9
;;       airline-utf-glyph-subseparator-right  #xe0bb
;;       airline-utf-glyph-branch              #xe0a0
;;       airline-utf-glyph-readonly            #xe0a2
;;       airline-utf-glyph-linenumber          #xe0a1)

;;(powerline-default-theme)

(load-theme 'airline-murmur)
(setq airline-shortened-directory-length 15)

(global-set-key (kbd "C-c s s") 'helm-spotify-plus)  ;; s for SEARCH
(global-set-key (kbd "C-c s f") 'helm-spotify-plus-next)
(global-set-key (kbd "C-c s b") 'helm-spotify-plus-previous)
(global-set-key (kbd "C-c s p") 'helm-spotify-plus-play)
(global-set-key (kbd "C-c s g") 'helm-spotify-plus-pause) ;; g cause you know.. C-g stop things :)

(require 'sunshine)
(setq sunshine-location "53717,USA")
(setq sunshine-appid "0c0ddcd91e07af4e48a3a84c4684625a")
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

