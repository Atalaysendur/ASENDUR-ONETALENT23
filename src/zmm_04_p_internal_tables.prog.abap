*&---------------------------------------------------------------------*
*& Report ZMM_04_P_INTERNAL_TABLES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_04_p_internal_tables.

INCLUDE zmm_04_i_internal_slscreen.
INCLUDE zmm_04_i_internal_class.

INITIALIZATION.
  go_main = lcl_main=>create_instance( ).


START-OF-SELECTION.
  go_main->start_of_selection( ).


  BREAK otasendur.
