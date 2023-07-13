*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_TWITTER_TOP
*&---------------------------------------------------------------------*



  SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME TITLE TEXT-002.
    PARAMETERS: p_id TYPE zot_04_t_p_twtr-id MATCHCODE OBJECT ZOT_04_SH_TWEETID MODIF ID abc.
    PARAMETERS: p_txt TYPE zot_04_t_p_twtr-text MODIF ID abd.
  SELECTION-SCREEN END OF BLOCK blk2.

  SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
    PARAMETERS: p_rad1 RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND radio .
    PARAMETERS: p_rad2 RADIOBUTTON GROUP gr1.
    PARAMETERS: p_rad3 RADIOBUTTON GROUP gr1.
    PARAMETERS: p_rad4 RADIOBUTTON GROUP gr1.
  SELECTION-SCREEN END OF BLOCK blk1.

  CLASS lcl_main DEFINITION DEFERRED.
  DATA: go_main TYPE REF TO lcl_main.

  DATA: gs_twitter TYPE zot_04_t_p_twtr.
