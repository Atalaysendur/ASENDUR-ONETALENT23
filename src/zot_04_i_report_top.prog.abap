*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_REPORT_TOP
*&---------------------------------------------------------------------*

TABLES: eban,ekpo.

TYPES: BEGIN OF gty_sat.
         INCLUDE STRUCTURE zot_04_s_sat.
TYPES:   line_color TYPE char4,
       END OF gty_sat.

TYPES: BEGIN OF gty_sas.
         INCLUDE STRUCTURE zot_04_s_sas.
TYPES:   line_color TYPE char4,
       END OF gty_sas.

CLASS lcl_main DEFINITION DEFERRED.
DATA: go_main TYPE REF TO lcl_main.

FIELD-SYMBOLS <itab> TYPE ANY TABLE.

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND radio.
  PARAMETERS: p_rad2 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK blk1.

SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME TITLE TEXT-002.
  PARAMETERS p_Ebanfn TYPE eban-banfn MODIF ID eb1.
  PARAMETERS p_Ebnfpo TYPE eban-bnfpo MODIF ID eb2.
  PARAMETERS p_Kbanfn TYPE ekpo-banfn MODIF ID ek1.
  PARAMETERS p_Kbnfpo TYPE ekpo-bnfpo MODIF ID ek2.
SELECTION-SCREEN END OF BLOCK blk2.









*DATA: go_docu TYPE REF TO cl_dd_document.
*DATA: gt_SAT TYPE TABLE OF gty_sat.
*DATA: gt_SAS TYPE TABLE OF gty_sas.

*DATA: go_spli TYPE REF TO cl_gui_splitter_container,
*      go_sub1 TYPE REF TO cl_gui_container,
*      go_sub2 TYPE REF TO cl_gui_container.
*
*DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
*      go_cont TYPE REF TO cl_gui_custom_container.
*
*DATA: gt_excluding TYPE ui_functions,
*      gv_excluding TYPE ui_func.
