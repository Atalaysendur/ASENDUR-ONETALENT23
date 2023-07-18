*&---------------------------------------------------------------------*
*& Report ZOT_04_P_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_report.

INCLUDE ZOT_04_I_REPORT_top.
INCLUDE ZOT_04_I_REPORT_class.
INCLUDE ZOT_04_I_REPORT_pai_pbo.

INITIALIZATION.
  go_main = lcl_main=>create_instance( ).

AT SELECTION-SCREEN OUTPUT.
  go_main->at_selection_screen_output( ).

START-OF-SELECTION.
  go_main->get_data( ).

END-OF-SELECTION.
  go_main->end_of_selection( ).
