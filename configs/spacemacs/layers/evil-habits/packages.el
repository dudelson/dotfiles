(defconst evil-habits-packages '(evil))

(defun evil-habits/post-init-evil ()
  ;; ensure that evil-habit-builder is non-repeatable (because it is a motion)
  (evil-set-command-property 'du/evil-habit-builder :repeat nil)

  ;; now let's build those damn habits!
  (define-key evil-normal-state-map (kbd "h") 'evil-habits/build)
  (define-key evil-normal-state-map (kbd "j") 'evil-habits/build)
  (define-key evil-normal-state-map (kbd "k") 'evil-habits/build)
  (define-key evil-normal-state-map (kbd "l") 'evil-habits/build)

  (spacemacs/set-leader-keys "oe" 'evil-habits/toggle))

