
(in-package :cl-enet)

(cl:eval-when (:load-toplevel :execute)
  (define-foreign-library libenet
    (t (:default "libenet")))
  (use-foreign-library libenet))

;;;
;;;
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

(defcfun "enet_address_set_host" :int
  (address enet-address)
  (host-name :string))

(defcfun "enet_host_connect" :pointer
  (host enet-host)
  (address enet-address)
  (channel-count :ulong)
  (data :uint32))
    
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
