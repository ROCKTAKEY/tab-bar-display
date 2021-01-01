;;; tab-bar-display.el --- Display strings on tab-bar   -*- lexical-binding: t; -*-

;; Copyright (C) 2020  ROCKTAKEY

;; Author: ROCKTAKEY <rocktakey@gmail.com>
;; Keywords: tools

;; Version: 1.1.2
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

;; Turn on ~tab-bar-mode~ and ~tab-bar-display-mode~.
;; Then, you can see ~tab-bar-display-before~ formatted ~format-mode-line~
;; before tabs, and ~tab-bar-display-after~ after tabs.

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

(defcustom tab-bar-display-no-tabs nil
  "If non-nil, tabs by command `tab-bar-mode' are not displayed."
  :group 'tab-bar-display
  :type 'boolean)

(defun tab-bar-display-advice (result)
  "Advice for function `tab-bar-display-mode'.
Add `tab-bar-display-before' and `tab-bar-display-after' displayer to RESULT."
  (cons
   (car result)
   `((tab-bar-display-before
      menu-item
      ,(format-mode-line tab-bar-display-before)
      ignore)
     ,@(unless tab-bar-display-no-tabs (cdr result))
     (tab-bar-display-after
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
