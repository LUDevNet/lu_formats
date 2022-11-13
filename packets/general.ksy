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
        # enum: packet_id
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
    0:
      id: unknown_server_error
      doc: Unspecified disconnect reason.
    1:
      id: wrong_game_version
      doc: |
        The client's [`network_version`](super::server::Handshake::network_version)
        did not match the server's [`network_version`](Handshake::network_version).
        The message contains the server network version number.
    2:
      id: wrong_server_version # with u32
      doc: Unused for client-server.
    3:
      id: connection_on_invalid_port
      doc: |
        Connection attempt on invalid port, server emulators probably won't send
        this as they usually won't have server-server communication using LU's protocol.
    4:
      id: duplicate_login
      doc: |
        There was another login with your account and your session has been
        closed in favor of the new login.
    5:
      id: server_shutdown
      doc: The server is shutting down.
    6:
      id: unable_to_load_map
      doc: No server hosting this map is available.
    7:
      id: invalid_session_key
      doc: |
        The provided [`ClientValidation::session_key`](crate::world::server::ClientValidation::session_key)
        is incorrect.
    8:
      id: account_not_in_pending_list
      doc: |
        Server did not expect a [`ClientValidation`](crate::world::server::ClientValidation)
        at this time.
    9:
      id: character_not_found
      doc: |
        The provided [`CharacterLoginRequest::char_id`](crate::world::server::CharacterLoginRequest::char_id)
        was not a valid character ID of this account.
    10:
      id: character_corruption
      doc: The character seems to be corrupted in the database.
    11:
      id: kick
      doc: You were kicked from the server.
    12:
      id: save_failure
      doc: Error saving or loading progress.
    13:
      id: free_trial_expired
      doc: The account's time-limited free trial expired, unused.
    14:
      id: play_schedule_time_up
      doc: The parental controls for this account prevent it from further play.
