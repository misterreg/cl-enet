
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

(defcfun "enet_packet_create" enet-packet
  (data :pointer)
  (data-length :ulong)
  (flags :uint32))

(defcfun "enet_peer_send" :int
  (peer enet-peer)
  (channel-id :uint8)
  (packet enet-packet))

(defcfun "enet_packet_destroy" :int
  (packet enet-packet))
    
;;;
;;;
;;;

;; (defmacro with-enet-packet ((name data data-length flags) &rest body)
;;   `(unwind-protect ,@body
;;      (format t "hi~%")))
  