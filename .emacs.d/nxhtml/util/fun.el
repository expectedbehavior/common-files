;;; fun.el --- 
;; 
;; Filename: fun.el
;; Description: 
;; Author: 
;; Maintainer: 
;; Created: 2012-01-15T23:25:49+0100
;; Version: 
;; Last-Updated: 
;;           By: 
;;     Update #: 0
;; URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(defun cat-command ()
 "A command for cats.
From Eric Schulte on Emacs Devel 2012-01-15."
 (interactive)
 (require 'animate)
 (let ((mouse "
          ___00
       ~~/____'>
         \"  \"")
       (h-pos (floor (/ (window-height) 2)))
       (contents (buffer-string))
       (mouse-buffer (generate-new-buffer "*mouse*")))
   (save-excursion
     (switch-to-buffer mouse-buffer)
     (insert contents)
     (setq truncate-lines t)
     (animate-string mouse h-pos 0)
     (dotimes (_ (window-width))
       (sit-for 0.01)
       (dotimes (n 3)
         (goto-line (+ h-pos n 2))
         (move-to-column 0)
         (insert " "))))
   (kill-buffer mouse-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; fun.el ends here
