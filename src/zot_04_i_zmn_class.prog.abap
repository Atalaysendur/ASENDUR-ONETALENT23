*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_ZMN_CLASS
*&---------------------------------------------------------------------*


CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS: create_instance RETURNING VALUE(ro_main) TYPE REF TO lcl_main.
    METHODS: start_of_selection.

  PRIVATE SECTION.

    DATA: lv_kalangun TYPE p.
    DATA: lv_asilgun  TYPE p.
    DATA: lv_ay       TYPE p.
    DATA: lv_yil      TYPE p.

    DATA: lv_kalanzaman TYPE uzeit.

    DATA: lt_mesaj TYPE  zot_04_tt_msg.


ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create_instance.

    ro_main = NEW lcl_main( ).

  ENDMETHOD.

  METHOD start_of_selection.


    SELECT *
    FROM zot_04_t_zmn AS zmn
    INTO TABLE @DATA(gt_itab)
    WHERE zmn~indexx IN @s_index.

    IF sy-subrc EQ 0 .

      LOOP AT gt_itab ASSIGNING FIELD-SYMBOL(<fs_itab>).

        lv_kalangun = ( <fs_itab>-bitis_tarihi - <fs_itab>-baslangic_tarihi ).
        lv_asilgun  = ( lv_kalangun MOD 30 ) .
        lv_ay       = ( floor( ( lv_kalangun MOD 365 ) - lv_asilgun ) / 30 ).
        lv_yil      =   floor( lv_kalangun / 365 ).

        lv_kalanzaman = ( <fs_itab>-bitis_saati - <fs_itab>-baslagic_saati ).

        DATA(lv_yil_output)     = | { COND string( WHEN lv_yil     EQ 0 THEN '' ELSE | { lv_yil     } Yıl | ) } | .
        DATA(lv_ay_output)      = | { COND string( WHEN lv_ay      EQ 0 THEN '' ELSE | { lv_ay      } Ay  | ) } | .
        DATA(lv_asilgun_output) = | { COND string( WHEN lv_asilgun EQ 0 THEN '' ELSE | { lv_asilgun } Gün | ) } | .

        DATA(lv_saat_output)    = | { COND string( WHEN lv_kalanzaman+0(2)   EQ '00' THEN '' ELSE | { lv_kalanzaman+0(2) } Saat   | ) } | .
        DATA(lv_dakika_output)  = | { COND string( WHEN lv_kalanzaman+2(2)   EQ '00' THEN '' ELSE | { lv_kalanzaman+2(2) } Dakika | ) } | .
        DATA(lv_saniye_output)  = | { COND string( WHEN lv_kalanzaman+4(2)   EQ '00' THEN '' ELSE | { lv_kalanzaman+4(2) } Saniye | ) } | .

        CONDENSE: lv_yil_output,lv_ay_output,lv_asilgun_output,lv_saat_output,lv_dakika_output,lv_saniye_output.
        DATA(lv_concat)  = | { lv_yil_output } { lv_ay_output } { lv_asilgun_output } { lv_saat_output } { lv_dakika_output } { lv_saniye_output } Fark Vardır. | .
        CONDENSE lv_concat.
        APPEND VALUE #( mesaj = lv_concat ) TO lt_mesaj.

        CLEAR: lv_kalangun,lv_asilgun,
               lv_ay,lv_yil,lv_kalanzaman,
               lv_yil_output,lv_ay_output,
               lv_asilgun_output,lv_saat_output,
               lv_dakika_output,lv_saniye_output,
               lv_concat.

      ENDLOOP.

      cl_demo_output=>display( lt_mesaj ).

    ELSE.
      MESSAGE 'Lütfen İndex Aralığı Doğru veriniz.' TYPE 'I'.
      LEAVE LIST-PROCESSING.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
