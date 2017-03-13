(defun vendor (name) (concat "~/.emacs.d/vendor/" name "/"))
(defun add-to-load-path (name) (add-to-list 'load-path (vendor name)))
(add-to-load-path "popup-el")
(add-to-load-path "auto-complete")
(add-to-load-path "emacs-clang-complete-async")
(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable
        (concat (vendor "emacs-clang-complete-async") "clang-complete"))
  (setq ac-sources '(ac-source-clang-async))
  (setq ac-clang-cflags '("-std=c++11" "-pthread"))
  (ac-clang-launch-completion-process)
  )

(defun my-ac-config ()
  (ac-config-default)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(savehist-mode 1)
