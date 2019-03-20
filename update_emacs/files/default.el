;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8
    gnuplot-mode
    magit
    jedi
    yaml-mode
    cython-mode
    auctex
    json-mode
    flycheck-cython))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
;; add theme directory
(let ((basedir "~/.emacs.d/themes/"))
  (dolist (f (directory-files basedir))
    (if (and (not (or (equal f ".") (equal f "..")))
             (file-directory-p (concat basedir f)))
        (add-to-list 'custom-theme-load-path (concat basedir f)))))
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'solarized t) ;; load solarized theme
(set-frame-parameter nil 'background-mode 'dark)
;; (global-linum-mode t) ;; enable line numbers globally
(setq flycheck-checker-error-threshold 2000)

;; PYTHON SPECIFICS
(package-initialize)
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; YAML SPECIFICS
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; C/C++ SPECIFICS
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-hook
          (lambda () (local-set-key (kbd "C-c C-e") 'compile)))
(add-hook 'c-mode-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'recompile)))
(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "C-c C-e") 'compile)))
(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'recompile)))


;; CYTHON SPECIFICS
(require 'flycheck-cython)
(add-hook 'cython-mode-hook 'flycheck-mode)

;; LaTeX SPECIFICS
(unless (image-type-available-p 'xpm)
  (setq LaTeX-enable-toolbar nil))
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; FORTRAN SPECIFICS (E.G. FOR VASP)
(add-to-list 'auto-mode-alist '("\\.f\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.F\\'" . f90-mode))
(add-hook 'f90-mode-hook
          (lambda () (local-set-key (kbd "C-c C-e") 'compile)))
(add-hook 'f90-mode-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'recompile)))

;; GNUPLOT SPECIFICS
(require 'gnuplot-mode)
(setq homedir (expand-file-name (getenv "HOME")))
(setq gnuplotprogramdir (format "%s/%s" homedir "/bin/gnuplot"))
(setq gnuplot-program gnuplotprogramdir)
(setq auto-mode-alist (append '(("\\.\\(gp\\|gnuplot\\|plt\\)$" . gnuplot-mode)) auto-mode-alist))

;; COMPILE SPECIFICS
(global-set-key (kbd "C-c C-c") 'recompile)

;; OTHER STUFF
;; put all backups in one place
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
;; menu bar go away
(menu-bar-mode -1)
