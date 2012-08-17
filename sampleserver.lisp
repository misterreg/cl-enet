#!/usr/bin/env sbcl --script

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load (merge-pathnames ".sbclrc" (user-homedir-pathname)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl-enet)
(use-package :cl-enet)
(use-package :cffi)

(defun send-pong (peer)
  (with-foreign-string (str "pong!")
    (let* ((packet (enet-packet-create str 5 0))
           (result (enet-peer-send peer 0 packet)))
      (if (= result 0) 
          (format t "pong sent~%")
          (format t "pong not sent~%")))))

(let ((result (enet-initialize)))
  (format t "initialize:~a~%" result)
  (with-foreign-object (address 'enet-address)
    (setf (foreign-slot-value address 'enet-address 'host) 0
          (foreign-slot-value address 'enet-address 'port) 27275)
    (let ((host (enet-host-create address 32 4 0 0)))
      (with-foreign-object (event 'enet-event)
        (do () (nil)
          (setf result (enet-host-service host event 1000))
          (format t "result:~a~%" result)
          (clear-output)
          (when (>= result 0)
            (with-foreign-slots ((event-type packet peer) event enet-event)
              (cond ((equal event-type :enet-event-type-connect)
                     (format t "new connection~%"))
                    ((equal event-type :enet-event-type-receive)
                     (with-foreign-slots ((data-length data) packet enet-packet)
                       (format t "receive data:~a~%" (foreign-string-to-lisp data)))
                     (send-pong peer))
                    ((equal event-type :enet-event-type-disconnect)
                     (format t "disconnect~%"))
                    (t t)))))))))
