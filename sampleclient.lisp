#!/usr/bin/env sbcl --script

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load (merge-pathnames ".sbclrc" (user-homedir-pathname)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl-enet)
(use-package :cl-enet)
(use-package :cffi)

(let ((result (enet-initialize)))
  (format t "initialize:~a~%" result)
  (let* ((host (enet-host-create (null-pointer) 1 4 0 0)))
    (with-foreign-object (address 'enet-address)
      (enet-address-set-host address "127.0.0.1")
      (setf (foreign-slot-value address 'enet-address 'port) 27275)
      (let ((peer (enet-host-connect host address 4 0)))
        (if (null-pointer-p peer)
            (format t "unable to make peer~%")
            (with-foreign-object (event 'enet-event)
              (do () (nil)
                (setf result (enet-host-service host event 1000))
                (format t "result:~a~%" result)
                (clear-output)
                (when (>= result 0)
                  (with-foreign-slots ((event-type) event enet-event)            
                    (cond ((equal event-type :enet-event-type-connect)
                           (format t "new connection~%"))
                          ((equal event-type :enet-event-type-receive)
                           (format t "receive data~%"))
                          ((equal event-type :enet-event-type-disconnect)
                           (format t "disconnect~%"))
                          (t t)))))))))))