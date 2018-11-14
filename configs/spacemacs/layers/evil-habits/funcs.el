;; Trying to build good habits
;; These functions limit me to one keypress per second in evil-normal-state
;; In the case of j and k, I should be using a count or avy
;; In the case of h and l, I should be using f and t instead

;; these vars store the last time that their respective key was pressed, in
;; the format returned by `current-time'
(defvar evil-habits/last-keypress-j (current-time))
(defvar evil-habits/last-keypress-k (current-time))
(defvar evil-habits/last-keypress-h (current-time))
(defvar evil-habits/last-keypress-l (current-time))

(defvar evil-habits/enabled t)

(defun evil-habits/build (count)
  "Prevents the victim (user) from pressing the h, j, k, or l keys in
   succession more than once a second without a count"
  (interactive "p")
  (let* ((r (recent-keys))
         (key (aref r (- (length r) 1))))
    (if evil-habits/enabled
        (let* ((prev-key (aref r (- (length r) 2)))
               (cur (current-time))
               (prev (cond
                      ((= key ?j) 'evil-habits/last-keypress-j)
                      ((= key ?k) 'evil-habits/last-keypress-k)
                      ((= key ?h) 'evil-habits/last-keypress-h)
                      ((= key ?l) 'evil-habits/last-keypress-l)))
               (delta (time-subtract cur
                                     (symbol-value prev))))
          ;; predicate checks if user pressed the same key twice consecutively,
          ;; without using a count, in the space of less than a second
          (if (and (= key prev-key)
                   (= count 1)
                   (= 0 (nth 1 delta)))
              (message (cond
                        ((or (= key ?j)
                             (= key ?k)) "Use a count!")
                        ((or (= key ?h)
                             (= key ?l)) "Use f or t!")))
            (funcall (cond
                      ((= key ?j) 'evil-next-visual-line)
                      ((= key ?k) 'evil-previous-visual-line)
                      ((= key ?h) 'evil-backward-char)
                      ((= key ?l) 'evil-forward-char))
                     count))
          (set prev cur))
      (funcall (cond
                ((= key ?j) 'evil-next-visual-line)
                ((= key ?k) 'evil-previous-visual-line)
                ((= key ?h) 'evil-backward-char)
                ((= key ?l) 'evil-forward-char)
                count)))))

(defun evil-habits/enable ()
  (setq evil-habits/enabled t)
  (message "evil-habits enabled"))

(defun evil-habits/disable ()
  (setq evil-habits/enabled nil)
  (message "evil-habits disabled"))

(defun evil-habits/toggle ()
  (interactive)
  (if evil-habits/enabled
      (evil-habits/disable)
    (evil-habits/enable)))
