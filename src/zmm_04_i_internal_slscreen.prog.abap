*&---------------------------------------------------------------------*
*& Include          ZMM_04_I_INTERNAL_SLSCREEN
*&---------------------------------------------------------------------*

TABLES: zot_04_t_materia.

CLASS lcl_main DEFINITION DEFERRED.
DATA: go_main TYPE REF TO lcl_main.

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_index FOR zot_04_t_materia-matnr.
SELECTION-SCREEN END OF BLOCK blk1.
