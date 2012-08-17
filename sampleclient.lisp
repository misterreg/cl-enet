#!/usr/bin/env sbcl --script

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load (merge-pathnames ".sbclrc" (user-homedir-pathname)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl-enet)
(use-package :cl-enet)
(use-package :cffi)

(let ((result (enet-initialize)))
  (format t "initialize:~a~%" result)
  (let* ((host (enet-host-create (null-pointer) 32 4 0 0)))
    (with-foreign-object (address 'enet-address)
      (enet-address-set-host address "127.0.0.1")
      (setf (foreign-slot-value address 'enet-address 'port) 27275)
      (let ((peer (enet-host-connect host address 4 0)))
        (if (null-pointer-p peer)
            (format t "unable to make peer~%")
            (format t "connected!~%"))))))