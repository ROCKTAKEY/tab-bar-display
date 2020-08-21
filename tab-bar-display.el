;;; tab-bar-display.el --- Display strings on tab-bar   -*- lexical-binding: t; -*-

;; Copyright (C) 2020  ROCKTAKEY

;; Author: ROCKTAKEY <rocktakey@gmail.com>
;; Keywords: tools

;; Version: 0.0.0
;; Package-Requires: ((emacs "27.1"))
;; URL: https://github.com/ROCKTAKEY/tab-bar-display

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'tab-bar)

(defgroup tab-bar-display ()
  "Group for tab-bar-display."
  :group 'tab-bar
  :prefix "tab-bar-display-")

(defcustom tab-bar-display-before nil
  "This is displayed before tabs on tab-bar.
Should be acceptable for `format-mode-line'."
  :group 'tab-bar-display
  :type [string list])

(defcustom tab-bar-display-after nil
  "This is displayed after tabs on tab-bar.
Should be acceptable for `format-mode-line'."
  :group 'tab-bar-display
  :type [string list])

(defun tab-bar-display-advice (result)
  "Advice for function `tab-bar-display-mode'.
Add `tab-bar-display-before' and `tab-bar-display-after' displayer to RESULT."
  (cons
   (car result)
   `((tab-bar-dislpay-before
      menu-item
      ,(format-mode-line tab-bar-display-before)
      ignore)
     ,@(cdr result)
     (tab-bar-dislpay-before
      menu-item
      ,(format-mode-line tab-bar-display-after)
      ignore))))

(define-minor-mode tab-bar-display-mode
  "Display `tab-bar-display-before' and `tab-bar-display-after' on tab-bar."
  nil nil nil
  (if tab-bar-display-mode
      (advice-add #'tab-bar-make-keymap-1 :filter-return #'tab-bar-display-advice)
    (advice-remove #'tab-bar-make-keymap-1 #'tab-bar-display-advice)))

(provide 'tab-bar-display)
;;; tab-bar-display.el ends here
