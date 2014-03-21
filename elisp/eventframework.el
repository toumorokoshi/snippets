(defvar my-events (make-hash-table :test 'equal))

(defun fire-event (event-name)
  "Fire an event"
  (interactive "sEvent Name: ")
  (let ((hook (gethash event-name my-events)))
        (if (not (eq hook nil))
          (funcall hook)
          (message (format "%s not found!" event-name))
        )
  )
)

(defun listen-event (event-name event-method)
  (puthash event-name event-method my-events)
)

(defun my-hello-world ()
  (message "hello world!")
)

(listen-event "hello" 'my-hello-world)

(fire-event "hello")
