(in-package :cl-enet)

(include "/usr/local/include/enet/enet.h")

;;;
;; (ctype enet-address-ptr "struct ENetAddress*")
;; (ctype enet-host-ptr "struct ENetHost*")
;; (ctype enet-event-ptr "struct ENetEvent*")
;; (ctype enet-peer-ptr "struct ENetEvent*")
;; (ctype enet-packet-ptr "struct ENetEvent*")

;;;bitfields
(bitfield enet-packet-flag
          ((enet-packet-flag-reliable "ENET_PACKET_FLAG_RELIABLE"))
          ((enet-packet-flag-unsequenced "ENET_PACKET_FLAG_UNSEQUENCED"))
          ((enet-packet-flag-no-allocate "ENET_PACKET_FLAG_NO_ALLOCATE"))
          ((enet-packet-flag-unreliable-fragment "ENET_PACKET_FLAG_UNRELIABLE_FRAGMENT")))       

;;;constantenums
(constantenum enet-version
              ((:enet-version-major "ENET_VERSION_MAJOR")))

;;;enums
(cenum enet-socket-type
       ((:enet-socket-type-stream "ENET_SOCKET_TYPE_STREAM")))

(cenum enet-event-type
   ((:enet-event-type-none "ENET_EVENT_TYPE_NONE"))
   ((:enet-event-type-connect "ENET_EVENT_TYPE_CONNECT"))
   ((:enet-event-type-disconnect "ENET_EVENT_TYPE_DISCONNECT"))
   ((:enet-event-type-receive "ENET_EVENT_TYPE_RECEIVE")))
;;;structs
(cstruct enet-address "ENetAddress" 
         (host "host" :type :uint32) 
         (port "port" :type :uint16))

(cstruct enet-host "ENetHost"
         (socket "socket" :type :char)
         (address "address" :type :char)
         (incoming-bandwidth "incomingBandwidth" :type :uint32)
         (outgoing-bandwidth "outgoingBandwidth" :type :uint32)
         (bandwidth-throttle-epoch "bandwidthThrottleEpoch" :type :uint32)
         (mtu "mtu" :type :uint32)
         (random-seed "randomSeed" :type :uint32)
         (recalculate-bandwidth-limits "recalculateBandwidthLimits" :type :int)
         (peers "peers" :type :pointer)
         (peer-count "peerCount" :type :ulong)
         (channel-limit "channelLimit" :type :ulong)
         (service-time "serviceTime" :type :uint32)
         (dispatch-queue "dispatchQueue" :type :char)
         (continue-sending "continueSending" :type :int)
         (packet-size "packetSize" :type :ulong)
         (header-flags "headerFlags" :type :uint16)
         (commands "commands" :type :char)
         (command-count "commandCount" :type :char)
         (buffers "buffers" :type :char)
         (buffer-count "bufferCount" :type :ulong)
         (checksum "checksum" :type :pointer)
         (compressor "compressor" :type :char)
         (packet-data "packetData" :type :char)
         (received-address "receivedAddress" :type :char)
         (received-data "receivedData" :type :pointer)
         (received-data-length "receivedDataLength" :type :ulong)
         (total-sent-data "totalSentData" :type :uint32)
         (total-sent-packets "totalSentPackets" :type :uint32)
         (total-received-data "totalReceivedData" :type :uint32)
         (total-received-packets "totalReceivedPackets" :type :uint32))

(cstruct enet-event "ENetEvent"
         (event-type "type" :type enet-event-type)
         (peer "peer" :type :pointer)
         (channel-id "channelID" :type :uint8)
         (data "data" :type :uint32 )
         (packet "packet" :type :pointer))

(cstruct enet-packet "ENetPacket"
         (reference-count "referenceCount" :type :ulong)
         (flags "flags" :type :uint32)
         (data "data" :type :pointer)
         (data-length "dataLength" :type :ulong)
         (free-callback "freeCallback" :type :pointer))

(cstruct enet-peer "ENetPeer"
   (dispatch-list "dispatchList" :type :char)
   (host "host" :type enet-host)
   (outgoing-peer-id "outgoingPeerID" :type :uint16)
   (incoming-peer-id "incomingPeerID" :type :uint16)
   (connect-id "connectID" :type :uint32)
   (outgoing-session-id "outgoingSessionID" :type :uint8)
   (incoming-session-id "incomingSessionID" :type :uint8)
   (address "address" :type :char)
   (data "data" :type :pointer)
   (state "state" :type :char)
   (channels "channels" :type :char)
   (channel-count "channelCount" :type :ulong)
   (incoming-bandwidth "incomingBandwidth" :type :uint32)
   (outgoing-bandwidth "outgoingBandwidth" :type :uint32)
   (incoming-bandwidth-throttle-epoch "incomingBandwidthThrottleEpoch" :type :uint32)
   (outgoing-bandwidth-throttle-epoch "outgoingBandwidthThrottleEpoch" :type :uint32)
   (incoming-data-total "incomingDataTotal" :type :uint32)
   (outgoing-data-total "outgoingDataTotal" :type :uint32)
   (last-send-time "lastSendTime" :type :uint32)
   (last-receive-time "lastReceiveTime" :type :uint32)
   (next-timeout "nextTimeout" :type :uint32)
   (earliest-timeout "earliestTimeout" :type :uint32)
   (packet-loss-epoch "packetLossEpoch" :type :uint32)
   (packets-sent "packetsSent" :type :uint32)
   (packets-lost "packetsLost" :type :uint32)
   (packet-loss "packetLoss" :type :uint32)
   (packet-loss-variance "packetLossVariance" :type :uint32)
   (packet-throttle "packetThrottle" :type :uint32)
   (packet-throttle-limit "packetThrottleLimit" :type :uint32)
   (packet-throttle-counter "packetThrottleCounter" :type :uint32)
   (packet-throttle-epoch "packetThrottleEpoch" :type :uint32)
   (packet-throttle-acceleration "packetThrottleAcceleration" :type :uint32)
   (packet-throttle-deceleration "packetThrottleDeceleration" :type :uint32)
   (packet-throttle-interval "packetThrottleInterval" :type :uint32)
   (ping-interval "pingInterval" :type :uint32)
   (timeout-limit "timeoutLimit" :type :uint32)
   (timeout-minimum "timeoutMinimum" :type :uint32)
   (timeout-maximum "timeoutMaximum" :type :uint32)
   (last-round-trip-time "lastRoundTripTime" :type :uint32)
   (lowest-round-trip-time "lowestRoundTripTime" :type :uint32)
   (last-round-trip-time-variance "lastRoundTripTimeVariance" :type :uint32)
   (highest-round-trip-time-variance "highestRoundTripTimeVariance" :type :uint32)
   (round-trip-time "roundTripTime" :type :uint32)
   (round-trip-time-variance "roundTripTimeVariance" :type :uint32)
   (mtu "mtu" :type :uint32)
   (window-size "windowSize" :type :uint32)
   (reliable-data-in-transit "reliableDataInTransit" :type :uint32)
   (outgoing-reliable-sequence-number "outgoingReliableSequenceNumber" :type :uint32)
   (acknowledgements "acknowledgements" :type :char)
   (sent-reliable-commands "sentReliableCommands" :type :char)
   (sent-unreliable-commands "sentUnreliableCommands" :type :char)
   (outgoing-reliable-commands "outgoingReliableCommands" :type :char)
   (outgoing-unreliable-commands "outgoingUnreliableCommands" :type :char)
   (dispatched-commands "dispatchedCommands" :type :char)
   (needs-dispatch "needsDispatch" :type :int)
   (incoming-unsequenced-group "incomingUnsequencedGroup" :type :uint16)
   (outgoing-unsequenced-group "outgoingUnsequencedGroup" :type :uint16)
   (unsequenced-window "unsequencedWindow" :type :char)
   (event-data "eventData" :type :uint32))
