*&---------------------------------------------------------------------*
*& Report ZOT_04_P_TWITTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_twitter.

INCLUDE zot_04_i_twitter_top.
INCLUDE zot_04_i_twitter_class.

INITIALIZATION.
  go_main = NEW #( ).

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    screen-active = COND #( WHEN p_rad1 EQ abap_true THEN SWITCH #( screen-group1 WHEN 'ABC' THEN 0 )
                            WHEN p_rad3 EQ abap_true THEN SWITCH #( screen-group1 WHEN 'ABD' THEN 0
                                                                                  WHEN 'ABC' THEN 1 )
                            WHEN p_rad4 EQ abap_true THEN SWITCH #( screen-group1 WHEN 'ABD' THEN 0
                                                                                  WHEN 'ABC' THEN 1 ) ).
    MODIFY SCREEN.
  ENDLOOP.

START-OF-SELECTION.

cl_demo_output=>display( COND #(
                                 WHEN p_rad1 EQ 'X' THEN go_main->tweet_at( )
                                 WHEN p_rad2 EQ 'X' THEN go_main->tweet_degistir( )
                                 WHEN p_rad3 EQ 'X' THEN go_main->tweet_sil( )
                                 WHEN p_rad4 EQ 'X' THEN go_main->tweet_goster( ) ) ).
