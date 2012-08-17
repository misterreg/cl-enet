
(declaim (optimize (speed 0) (space 0) (debug 3)))

(require 'cffi)

(in-package :cl-user)

(defpackage :cffi-user
  (:use :common-lisp :cffi))

(in-package :cffi-user)

(define-foreign-library libenet
    (t (:default "libenet")))

(use-foreign-library libenet)

;;;
;;; types
;;;
(defctype enet-address :pointer)
(defctype enet-host :pointer)
(defctype enet-event :pointer)
(defctype enet-peer :pointer)
(defctype enet-packet :pointer)

;;;
;;; enums
;;;

(defcenum enet-event-type
  (:enet-event-type-none 0)
  (:enet-event-type-connect 1)
  (:enet-event-type-disconnect 2)
  (:enet-event-type-receive 3))

;;;
;;; structs
;;;
(defcstruct enet-address
  (host :uint32)
  (port :uint16))

(defcstruct enet-event
  (event-type enet-event-type)
  (peer enet-peer)
  (channel-id :uint8)
  (data :uint32)
  (packet enet-packet))

(defcstruct enet-packet
  (reference-count :pointer) ;not really a pointer but we want it that size
  (flags :uint32)
  (data :pointer)
  (data-length :uint64)
  (free-callback :pointer))

;;;
;;; functions
;;;

(defcfun "enet_initialize" :int)

(defcfun "enet_host_create" enet-host
  (address enet-address)
  (max-conections :uint32)
  (num-channels :uint32)
  (incoming-bandwidth :uint32)
  (outgoing-bandwidth :uint32))

(defcfun "enet_host_service" :int
  (host enet-host)
  (event enet-event)
  (timeout :uint32))
    
;;;
;;;
;;;

(defun run-simple-server()
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
              (with-foreign-slots ((event-type) event enet-event)            
                (cond ((eql event-type 
                            (foreign-enum-value 'enet-event-type 
                                                :enet-event-type-connect))
                       (format t "new connection~%"))
                      ((eql event-type 
                            (foreign-enum-value 'enet-event-type 
                                                :enet-event-type-receive))
                       (format t "receive data~%"))
                      ((eql event-type 
                            (foreign-enum-value 'enet-event-type 
                                                :enet-event-type-disconnect))
                       (format t "disconnect~%"))
                      (t (format t "unknown event!~%")))))))))))
