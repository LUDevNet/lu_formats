meta:
  id: common
  endian: le
  bit-endian: le
types:
  vector2:
    doc: |
      Position in 2D Space
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
  vector3:
    doc: |
      Position in 3D Space
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  object_id:
    seq:
      - id: object_id
        type: u8
  lot:
    doc: |
      LU Object Template

      `-1` is the none value
    seq:
      - id: lot
        type: s4
  quaternion:
    doc: |
      Rotation in 3D Space
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
      - id: w
        type: f4
  quaternion_wxyz:
    seq:
      - id: w
        type: f4
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  transform3:
    doc: |
      Position and Rotation in 3D Space
    seq:
      - id: position
        type: vector3
      - id: rotation
        type: quaternion
  u1_color:
    doc: |
      8-bit RGB Color Value
    seq:
      - id: r
        type: u1
      - id: g
        type: u1
      - id: b
        type: u1
  u1_str:
    seq:
      - id: length
        type: u1
      - id: str
        type: str
        size: length
        encoding: ascii
  u1_wstr:
    seq:
      - id: length
        type: u1
      - id: str
        type: str
        size: length * 2
        encoding: utf-16le
  u4_str:
    seq:
      - id: length
        type: u4
      - id: str
        type: str
        size: length
        encoding: ascii
  u4_wstr:
    seq:
      - id: length
        type: u4
      - id: str
        type: str
        size: length * 2
        encoding: utf-16le
  bool:
    doc: |
      8-bit boolean value
    seq:
      - id: bool
        type: u1
        enum: boolean
enums:
  boolean:
    0: false
    1: true
