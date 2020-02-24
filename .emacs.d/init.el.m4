(require 'cask "CASK")
(cask-initialize)

(require 'helm-config)

(require 'evil)
(evil-mode 1)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
