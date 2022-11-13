meta:
  id: general
  endian: le
  imports:
    - net
types:
  packet:
    params:
      - id: id
        type: u4
        #enum: packet_id
    seq:
      - type:
          switch-on: id
          cases:
            0: handshake
            1: disconnect_notify
  handshake:
    seq:
      - id: network_version
        type: u4
        doc: The network protocol version of the server. For servers compatible with live, this is `171022`. This was relevant mainly back when LU was actively updated. Server projects making modifications to the network protocol should set this to a different value.
      - type: net::padding(4)
      - id: service_id
        doc: Service ID of the server
        type: u2
        enum: net::service_id
      - type: net::padding(2)
      - id: process_id
        type: u4
      - id: port
        type: u2
      - type: net::padding(35)
  disconnect_notify:
    seq:
      - id: reason
        type: u4
        enum: disconnect_reason
      - id: version
        type: u4
        if: reason == disconnect_reason::wrong_game_version or reason == disconnect_reason::wrong_server_version
enums:
  packet_id:
    0: handshake
    1: disconnect_notify
  disconnect_reason:
    # Unspecified disconnect reason.
    0: unknown_server_error
    # /// The client's [`network_version`](super::server::Handshake::network_version) did not match the server's [`network_version`](Handshake::network_version). The message contains the server network version number.
    1: wrong_game_version # with u32
    # Unused for client-server.
    2: wrong_server_version # with u32
    # Connection attempt on invalid port, server emulators probably won't send this as they usually won't have server-server communication using LU's protocol.
    3: connection_on_invalid_port
    # There was another login with your account and your session has been closed in favor of the new login.
    4: duplicate_login
    # The server is shutting down.
    5: server_shutdown
    # No server hosting this map is available.
    6: unable_to_load_map
    # The provided [`ClientValidation::session_key`](crate::world::server::ClientValidation::session_key) is incorrect.
    7: invalid_session_key
    # Server did not expect a [`ClientValidation`](crate::world::server::ClientValidation) at this time.
    8: account_not_in_pending_list
    # The provided [`CharacterLoginRequest::char_id`](crate::world::server::CharacterLoginRequest::char_id) was not a valid character ID of this account.
    9: character_not_found
    # The character seems to be corrupted in the database.
    10: character_corruption
    # You were kicked from the server.
    11: kick
    # Error saving or loading progress.
    12: save_failure
    # The account's time-limited free trial expired, unused.
    13: free_trial_expired
    # The parental controls for this account prevent it from further play.
    14: play_schedule_time_up