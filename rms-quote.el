;;;  rms-quote.el  --- get a juicy quote from RMS. -*- lexical-binding: t; -*-

;;  Copyright (C) 2019 by m0nt3

;;  Author:     m0nt3 <m0nt3@protonmail.com>
;;  Created     19 Sep 2019
;;  Name:       rms-quote
;;  Version:    0.1.2
;;  Keywords:   RMS Stallman wisdom sex parrot
;;  License:    GPL v3
;;  URL:        https://github.com/m0n73/rms-quote
;;  Package-Requires: ((emacs "24.1"))

;;  This file is not part of GNU Emacs.

;;; Commentary:

;;  This package introduces a bit of wisdom into
;;  your workflow: a random quote by our beloved
;;  RMS on sensitive subjects.  Don't see a quote
;;  you love? No problem -- adding a quote is as
;;  easy as "C-h C-y".

;;  rms-quote - messages out a pearl of wisdom from RMS.
;;  rms-quote-add - adds the current line to the quotes.

;;;  Install:

;;  Place rms-quote.el and rms-quotes.list
;;  in "~/.emacs.d/rms-quote/".

;;  Add the following to your emacs init:
;;  (add-to-list 'load-path "~/.emacs.d/rms-quote")
;;  (require 'rms-quote)

;;  Add your personal keybindings. I use:

;;  (global-set-key (kbd "C-h C-u") 'rms-quote)
;;  (global-set-key (kbd "C-h C-y") 'rms-quote-add)

;;; Code:

(random t)
(setq quotes-list-file
      (concat (file-name-directory load-file-name) "rms-quotes.list"))

(defun read-rms-quotes(path)
  "Read quotes from PATH into a list."
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(defun rms-qstr-add(path qstr)
  "Save QSTR into a file PATH."
  (when (y-or-n-p "Add current line to RMS quotes? ")
    (write-region qstr nil path t)))

(setq rms-quotes-list
      (read-rms-quotes quotes-list-file))

(defun rms-quote()
  "Enjoy another fantastic quote by RMS."
  (interactive)
  (message (nth
             (random
             (length rms-quotes-list))
            rms-quotes-list)))

(defun rms-quote-add()
  "Add the current line to the quotes file."
  (interactive)
  (rms-qstr-add quotes-list-file
               (thing-at-point 'line t)))

(provide 'rms-quote)

;;; rms-quote.el ends here
