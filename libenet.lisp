
(in-package :cl-enet)

(cl:eval-when (:load-toplevel :execute)
  (define-foreign-library libenet
    (t (:default "libenet")))
  (use-foreign-library libenet))

;;;
;;;
;;;




#| 
  Initializes ENet globally.  Must be called prior to using any functions in
  ENet.
  @returns 0 on success, < 0 on failure
|#
;;ENET_API int enet_initialize (void);
(export 'enet-initialize)
(defcfun "enet_initialize" :int)

#|
  Initializes ENet globally and supplies user-overridden callbacks. Must be called prior to using any functions in ENet. Do not use enet_initialize() if you use this variant. Make sure the ENetCallbacks structure is zeroed out so that any additional callbacks added in future versions will be properly ignored.

  @param version the constant ENET_VERSION should be supplied so ENet knows which version of ENetCallbacks struct to use
  @param inits user-overridden callbacks where any NULL callbacks will use ENet's defaults
  @returns 0 on success, < 0 on failure
|#
;;ENET_API int enet_initialize_with_callbacks (ENetVersion version, const ENetCallbacks * inits)

#| 
  Shuts down ENet globally.  Should be called when a program that has
  initialized ENet exits.
|#
;;ENET_API void enet_deinitialize (void);
(export 'enet-deinitialize)
(defcfun "enet_deinitialize" :void)

#|
  Gives the linked version of the ENet library.
  @returns the version number 
|#
;;ENET_API ENetVersion enet_linked_version (void);

#|
  Returns the wall-time in milliseconds.  Its initial value is unspecified
  unless otherwise set.
  |#
;;ENET_API enet_uint32 enet_time_get (void);
#|
  Sets the current wall-time in milliseconds.
  |#
;;ENET_API void enet_time_set (enet_uint32);

;;ENET_API ENetSocket enet_socket_create (ENetSocketType);
;;ENET_API int        enet_socket_bind (ENetSocket, const ENetAddress *);
;;ENET_API int        enet_socket_get_address (ENetSocket, ENetAddress *);
;;ENET_API int        enet_socket_listen (ENetSocket, int);
;;ENET_API ENetSocket enet_socket_accept (ENetSocket, ENetAddress *);
;;ENET_API int        enet_socket_connect (ENetSocket, const ENetAddress *);
;;ENET_API int        enet_socket_send (ENetSocket, const ENetAddress *, const ENetBuffer *, size_t);
;;ENET_API int        enet_socket_receive (ENetSocket, ENetAddress *, ENetBuffer *, size_t);
;;ENET_API int        enet_socket_wait (ENetSocket, enet_uint32 *, enet_uint32);
;;ENET_API int        enet_socket_set_option (ENetSocket, ENetSocketOption, int);
;;ENET_API int        enet_socket_get_option (ENetSocket, ENetSocketOption, int *);
;;ENET_API int        enet_socket_shutdown (ENetSocket, ENetSocketShutdown);
;;ENET_API void       enet_socket_destroy (ENetSocket);
;;ENET_API int        enet_socketset_select (ENetSocket, ENetSocketSet *, ENetSocketSet *, enet_uint32);

#| Attempts to resolve the host named by the parameter hostName and sets
    the host field in the address parameter if successful.
    @param address destination to store resolved address
    @param hostName host name to lookup
    @retval 0 on success
    @retval < 0 on failure
    @returns the address of the given hostName in address on success
|#
;;ENET_API int enet_address_set_host (ENetAddress * address, const char * hostName);
(export 'enet-address-set-host)
(defcfun "enet_address_set_host" :int
  (address enet-address)
  (host-name :string))

#| Gives the printable form of the IP address specified in the address parameter.
    @param address    address printed
    @param hostName   destination for name, must not be NULL
    @param nameLength maximum length of hostName.
    @returns the null-terminated name of the host in hostName on success
    @retval 0 on success
    @retval < 0 on failure
|#
;;ENET_API int enet_address_get_host_ip (const ENetAddress * address, char * hostName, size_t nameLength);

#| Attempts to do a reverse lookup of the host field in the address parameter.
    @param address    address used for reverse lookup
    @param hostName   destination for name, must not be NULL
    @param nameLength maximum length of hostName.
    @returns the null-terminated name of the host in hostName on success
    @retval 0 on success
    @retval < 0 on failure
|#
;;ENET_API int enet_address_get_host (const ENetAddress * address, char * hostName, size_t nameLength);

;;ENET_API ENetPacket * enet_packet_create (const void *, size_t, enet_uint32);
(export 'enet-packet-create)
(defcfun "enet_packet_create" enet-packet
  (data :pointer)
  (data-length :ulong)
  (flags :uint32))

;;ENET_API void         enet_packet_destroy (ENetPacket *);
(export 'enet-packet-destroy)
(defcfun "enet_packet_destroy" :int
  (packet enet-packet))

;;ENET_API int          enet_packet_resize  (ENetPacket *, size_t);
;;ENET_API enet_uint32  enet_crc32 (const ENetBuffer *, size_t);

;;ENET_API ENetHost * enet_host_create (const ENetAddress *, size_t, size_t, enet_uint32, enet_uint32);
(export 'enet-host-create)
(defcfun "enet_host_create" enet-host
  (address enet-address)
  (max-conections :uint32)
  (num-channels :uint32)
  (incoming-bandwidth :uint32)
  (outgoing-bandwidth :uint32))

;;ENET_API void       enet_host_destroy (ENetHost *);
(export 'enet-host-destroy)
(defcfun "enet_host_destroy" :void
  (host enet-host))

;;ENET_API ENetPeer * enet_host_connect (ENetHost *, const ENetAddress *, size_t, enet_uint32);
(export 'enet-host-connect)
(defcfun "enet_host_connect" :pointer
  (host enet-host)
  (address enet-address)
  (channel-count :ulong)
  (data :uint32))

;;ENET_API int        enet_host_check_events (ENetHost *, ENetEvent *);

;;ENET_API int        enet_host_service (ENetHost *, ENetEvent *, enet_uint32);
(export 'enet-host-service)
(defcfun "enet_host_service" :int
  (host enet-host)
  (event enet-event)
  (timeout :uint32))



;;ENET_API void       enet_host_flush (ENetHost *);
;;ENET_API void       enet_host_broadcast (ENetHost *, enet_uint8, ENetPacket *);
;;ENET_API void       enet_host_compress (ENetHost *, const ENetCompressor *);
;;ENET_API int        enet_host_compress_with_range_coder (ENetHost * host);
;;ENET_API void       enet_host_channel_limit (ENetHost *, size_t);
;;ENET_API void       enet_host_bandwidth_limit (ENetHost *, enet_uint32, enet_uint32);
;;extern   void       enet_host_bandwidth_throttle (ENetHost *);
;;extern  enet_uint32 enet_host_random_seed (void);

;;ENET_API int                 enet_peer_send (ENetPeer *, enet_uint8, ENetPacket *) ;
(export 'enet-peer-send)
(defcfun "enet_peer_send" :int
  (peer enet-peer)
  (channel-id :uint8)
  (packet enet-packet))


;;ENET_API ENetPacket *        enet_peer_receive (ENetPeer *, enet_uint8 * channelID);
;;ENET_API void                enet_peer_ping (ENetPeer *);
;;ENET_API void                enet_peer_ping_interval (ENetPeer *, enet_uint32);
;;ENET_API void                enet_peer_timeout (ENetPeer *, enet_uint32, enet_uint32, enet_uint32);
;;ENET_API void                enet_peer_reset (ENetPeer *);
;;ENET_API void                enet_peer_disconnect (ENetPeer *, enet_uint32);
;;ENET_API void                enet_peer_disconnect_now (ENetPeer *, enet_uint32);
;;ENET_API void                enet_peer_disconnect_later (ENetPeer *, enet_uint32);
;;ENET_API void                enet_peer_throttle_configure (ENetPeer *, enet_uint32, enet_uint32, enet_uint32);
;;extern int                   enet_peer_throttle (ENetPeer *, enet_uint32);
;;extern void                  enet_peer_reset_queues (ENetPeer *);
;;extern void                  enet_peer_setup_outgoing_command (ENetPeer *, ENetOutgoingCommand *);
;;extern ENetOutgoingCommand * enet_peer_queue_outgoing_command (ENetPeer *, const ENetProtocol *, ENetPacket *, enet_uint32, enet_uint16);
;;extern ENetIncomingCommand * enet_peer_queue_incoming_command (ENetPeer *, const ENetProtocol *, const void *, size_t, enet_uint32, enet_uint32);
;;extern ENetAcknowledgement * enet_peer_queue_acknowledgement (ENetPeer *, const ENetProtocol *, enet_uint16);
;;extern void                  enet_peer_dispatch_incoming_unreliable_commands (ENetPeer *, ENetChannel *);
;;extern void                  enet_peer_dispatch_incoming_reliable_commands (ENetPeer *, ENetChannel *);
;;extern void                  enet_peer_on_connect (ENetPeer *);
;;extern void                  enet_peer_on_disconnect (ENetPeer *);
;;
;;ENET_API void * enet_range_coder_create (void);
;;ENET_API void   enet_range_coder_destroy (void *);
;;ENET_API size_t enet_range_coder_compress (void *, const ENetBuffer *, size_t, size_t, enet_uint8 *, size_t);
;;ENET_API size_t enet_range_coder_decompress (void *, const enet_uint8 *, size_t, enet_uint8 *, size_t);
;;   
;;extern size_t enet_protocol_command_size (enet_uint8)
                                        ;
;;;
;;;
;;;

;; (defmacro with-enet-packet ((name data data-length flags) &rest body)
;;   `(unwind-protect ,@body
;;      (format t "hi~%")))


                

