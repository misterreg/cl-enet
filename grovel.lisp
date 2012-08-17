(in-package :cl-enet)

(include "/usr/local/include/enet/enet.h")

;;;
(ctype enet-address "struct ENetAddress*")
(ctype enet-host "struct ENetHost*")
(ctype enet-event "struct ENetEvent*")
(ctype enet-peer "struct ENetEvent*")
(ctype enet-packet "struct ENetEvent*")

;;;
(constantenum enet-version
              ((:enet-version-major "ENET_VERSION_MAJOR")))

;;;
(cenum enet-socket-type
       ((:enet-socket-type-stream "ENET_SOCKET_TYPE_STREAM")))

(cenum enet-event-type
   ((:enet-event-type-none "ENET_EVENT_TYPE_NONE"))
   ((:enet-event-type-connect "ENET_EVENT_TYPE_CONNECT"))
   ((:enet-event-type-disconnect "ENET_EVENT_TYPE_DISCONNECT"))
   ((:enet-event-type-receive "ENET_EVENT_TYPE_RECEIVE")))
;;;
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
         (peer "peer" :type enet-peer)
         (channel-id "channelID" :type :uint8)
         (data "data" :type :uint32 )
         (packet "packet" :type enet-packet))

(cstruct enet-packet "ENetPacket"
         (reference-count "referenceCount" :type :ulong)
         (flags "flags" :type :uint32)
         (data "data" :type :pointer)
         (data-length "dataLength" :type :ulong)
         (free-callback "freeCallback" :type :pointer))