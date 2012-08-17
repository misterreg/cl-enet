(in-package :cl-user)

(defpackage :cl-enet 
  (:use :cl :cffi)
  (:export :enet-initialize
           :enet-host-create
           :enet-host-service
           :run-simple-server
           ;;
           :enet-version-major
           :enet-socket-type-stream
           :enet-event-type-none
           :enet-event-type-connect
           :enet-event-type-disconnect
           :enet-event-type-receive
           ;;
           :enet-address
           :enet-host
           :enet-event
           :enet-packet))
           