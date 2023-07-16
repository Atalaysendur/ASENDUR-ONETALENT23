*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_ZMN_SLSCREEN
*&---------------------------------------------------------------------*

TABLES: zot_04_t_zmn.

CLASS lcl_main DEFINITION DEFERRED.
DATA: go_main TYPE REF TO lcl_main.

selection-screen BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS s_index FOR zot_04_t_zmn-indexx.
SELECTION-SCREEN END OF BLOCK blk1.
