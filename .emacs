(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load-file "~/.emacs.d/ergoemacs_1.9.3.1/site-lisp/site-start.el")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'nrepl)

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(put 'erase-buffer 'disabled nil)

(global-linum-mode 1)

(setq load-path (cons "~/.emacs.d/vendor/geben-0.26" load-path))

(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)

;; Debug a simple PHP script.
;; Change the session key geben-xdebug to any session key text you like
(defun geben-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='geben-xdebug' /usr/bin/php5 "
    (buffer-file-name) " &"))
  )

(defun filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun local-find-file ()
  (interactive)
  (let (name stdout files enumerated selected file open)
    (setq name (read-from-minibuffer (concat "Search in folder " default-directory " filename pattern: ")))
    (setq stdout (shell-command-to-string 
                  (concat "find -L . -wholename " name)))
    (setq files (mapcar (lambda (file) (substring file 2)) 
                        (filter (lambda (file) (not (string= "" file)))
                                (split-string stdout "\n"))))
    (setq enumerated (let ((n 0))
                       (mapconcat (lambda (file)
                                    (setq n (+ n 1))
                                    (format "%d: %s" n file))
                                  files "\n")))
    (setq selected (read-from-minibuffer 
                    (concat enumerated "\nResult number: ")))
    (setq file (nth (- (string-to-int selected) 1) files))
    (setq open (read-from-minibuffer 
                (concat "Your selected " file ", open it? (y/n): ")))
    (when (string= "y" open) (find-file file))))