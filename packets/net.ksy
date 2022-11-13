meta:
  id: net
  endian: le
types:
  padding:
    params:
      - id: size
        type: u2
    seq:
      - size: size
  header:
    seq:
      - id: raknet_user_packet_id
        contents: [ 83 ]
      - id: service_id
        type: u2
        enum: service_id
      - id: packet_id
        type: u4
      - type: u1
  lu_str:
    params:
      - id: size
        type: u2
    seq:
      - size: size
        type: strz
        encoding: latin1
  lu_wstr:
    params:
      - id: size
        type: u2
    seq:
      - size: size * 2
        type: strz
        encoding: utf16-le
enums:
  service_id:
    0: general
    1: auth
    2: chat
    4: world
    5: client
