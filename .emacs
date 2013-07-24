(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load-file "~/.emacs.d/ergoemacs_1.9.3.1/site-lisp/site-start.el")

(add-to-list 'load-path "~/.emacs.d/vendor")

(require 'tramp) ; Fixes "Recursive load" error for dired and projectile according to http://ergoemacs.org/emacs/emacs_dired_recursive_load_error.html

(require 'projectile)

(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'nrepl)

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(put 'erase-buffer 'disabled nil)

(global-linum-mode 1)
(global-auto-revert-mode t)

(global-set-key (kbd "M-m") 'menu-bar-open)

(setq load-path (cons "~/.emacs.d/vendor/geben-0.26" load-path))

(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)

;; Debug a simple PHP script.
;; Change the session key geben-xdebug to any session key text you like
;; To debug from web use http://localhost/index.php?XDEBUG_SESSION_START=geben-xdebug
(defun geben-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='geben-xdebug' /usr/bin/php5 "
    (buffer-file-name) " &"))
  )

; infix expressions without priority
(defun tree2 (args)
  (if (< (length args) 2) (car args)
    (let ((oparg (last args 2)))
      (list (car oparg) 
            (tree2 (butlast args 2)) 
            (nth 1 oparg)
            ))))

(defmacro inf (&rest args) `,(tree2 args))

; open file by pattern
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