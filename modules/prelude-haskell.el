;;; prelude-haskell.el ends here

;;; prelude-haskell.el --- Emacs Prelude: Nice config for Haskell programming.
;;
;; Copyright © 2011-2014 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Nice config for Haskell programming.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'prelude-programming)
(prelude-require-packages '(cl-lib ghc company-ghc haskell-mode))

(eval-after-load 'ghc
  '(progn
     (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))

(eval-after-load 'haskell-mode
  '(progn
     (defun prelude-haskell-mode-defaults ()
       (subword-mode +1)
       (turn-on-haskell-doc-mode)
       (turn-on-haskell-indentation)
       (interactive-haskell-mode +1)

       (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
       (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
       (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
       (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
       (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)

       (define-key interactive-haskell-mode-map [f5] 'haskell-process-load-or-reload)
       (define-key interactive-haskell-mode-map [f12] 'turbo-devel-reload)
       (define-key interactive-haskell-mode-map [f12] 'haskell-process-cabal-build-and-restart)
       (define-key interactive-haskell-mode-map (kbd "M-,") 'haskell-who-calls)
       (define-key interactive-haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
       (define-key interactive-haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
       (define-key interactive-haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
       (define-key interactive-haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
       (define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
       (define-key interactive-haskell-mode-map (kbd "C-?") 'haskell-mode-find-uses)
       (define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)

       (define-key haskell-interactive-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)
       (define-key haskell-interactive-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
       (define-key haskell-interactive-mode-map [f9] 'haskell-interactive-mode-visit-error)
       (define-key haskell-interactive-mode-map [f11] 'haskell-process-cabal-build)
       (define-key haskell-interactive-mode-map [f12] 'haskell-process-cabal-build-and-restart)
       (define-key haskell-interactive-mode-map (kbd "C-<left>") 'haskell-interactive-mode-error-backward)
       (define-key haskell-interactive-mode-map (kbd "C-<right>") 'haskell-interactive-mode-error-forward)
       (define-key haskell-interactive-mode-map (kbd "C-c c") 'haskell-process-cabal)

       (define-key haskell-mode-map (kbd "C-<right>") 'haskell-move-right)
       (define-key haskell-mode-map (kbd "C-<left>") 'haskell-move-left)
       (define-key haskell-mode-map (kbd "<space>") 'haskell-mode-contextual-space))

     (setq haskell-process-path-ghci "ghci-ng")
     (setq haskell-process-args-ghci '("-ferror-spans"))
     (setq haskell-process-args-cabal-repl
           '("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng"))
     (setq prelude-haskell-mode-hook 'prelude-haskell-mode-defaults)
     (setq haskell-process-generate-tags nil)

     (add-hook 'haskell-mode-hook (lambda ()
                                    (run-hooks 'prelude-haskell-mode-hook)))))

(provide 'prelude-haskell)

;;; prelude-haskell.el ends here
