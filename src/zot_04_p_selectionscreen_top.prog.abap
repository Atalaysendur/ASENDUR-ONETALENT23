*&---------------------------------------------------------------------*
*& Include zot_04_p_selectionscreen_top
*&---------------------------------------------------------------------*

DATA: gv_sonuc TYPE p decimals 2,
      gv_message type char20.


SELECTION-SCREEN: BEGIN OF BLOCK BLK1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_sayi1 TYPE p DECIMALS 2,
            p_Sayi2 TYPE p DECIMALS 2   .
SELECTION-SCREEN END OF BLOCK BLK1.

SELECTION-SCREEN: BEGIN OF BLOCK BLK2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_tplma  RADIOBUTTON GROUP gr1  DEFAULT 'X' USER-COMMAND radio,
            p_ckrma  RADIOBUTTON GROUP gr1,
            p_carpma RADIOBUTTON GROUP gr1,
            p_bol    RADIOBUTTON GROUP gr1 .
SELECTION-SCREEN END OF BLOCK BLK2.
