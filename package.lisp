(in-package :cl-user)

(defpackage :cl-enet 
  (:use :cl :cffi)
  (:export 
   ;;functions
   :enet-initialize
   :enet-host-create
   :enet-host-service
   :run-simple-server
   ;;enums
   :enet-version
   :enet-version-major
   :enet-socket-type
   :enet-socket-type-stream
   :enet-event-type
   :enet-event-type-none
   :enet-event-type-connect
   :enet-event-type-disconnect
   :enet-event-type-receive
   ;;structs
   :enet-address
   :enet-host
   :enet-event
   :enet-packet
   ;;enet-address slots
   :host
   :port
   ;;enet-host slots
   :socket
   :address
   :incoming-bandwidth
   :outgoing-bandwidth
   :bandwidth-throttle-epoch
   :mtu
   :random-seed
   :recalculate-bandwidth-limits
   :peers
   :peer-count
   :channel-limit
   :service-time
   :dispatch-queue
   :continue-sending
   :packet-size
   :header-flags
   :commands
   :command-count
   :buffers
   :buffer-count
   :checksum
   :compressor
   :packet-data
   :received-address
   :received-data
   :received-data-length
   :total-sent-data
   :total-sent-packets
   :total-received-data
   :total-received-packets
   ;;enet-event slots
   :event-type
   :peer
   :channel-id
   :data
   :packet
   ;;enet-packet slots
   :reference-count
   :flags
   :data
   :data-length
   :free-callback))
           