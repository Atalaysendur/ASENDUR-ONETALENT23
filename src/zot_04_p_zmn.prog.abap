*&---------------------------------------------------------------------*
*& Report ZOT_04_P_ZMN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_zmn.

INCLUDE zot_04_i_zmn_slscreen.
INCLUDE zot_04_i_zmn_class.

INITIALIZATION.
  go_main = lcl_main=>create_instance( ).

START-OF-SELECTION.
  go_main->start_of_selection( ).
