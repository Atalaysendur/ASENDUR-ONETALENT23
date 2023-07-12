*&---------------------------------------------------------------------*
*& Report zot_04_p_selectionscreen
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_selectionscreen.

 INCLUDE zot_04_p_selectionscreen_top.


START-OF-SELECTION.

cl_demo_output=>display( COND #(
          WHEN p_tplma EQ 'X' THEN
            |Islemin Sonucu: { p_sayi1 + p_sayi2 } |
                      WHEN p_ckrma EQ 'X' THEN
            |Islemin Sonucu: { p_sayi1 - p_sayi2 } |
                      WHEN p_carpma EQ 'X' THEN
            |Islemin Sonucu: { p_sayi1 * p_sayi2 } |
                      WHEN ( P_BOL EQ 'X' ) AND ( p_sayi2 EQ 0 ) THEN |Girmiş olduğunuz sayı sıfıra bölünemez|
                      WHEN p_bol EQ 'X' THEN
            |Islemin Sonucu: { p_sayi1 / p_sayi2 } |

             ) ).
