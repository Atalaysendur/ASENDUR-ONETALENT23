*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_TWITTER_CLASS
*&---------------------------------------------------------------------*


CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    METHODS tweet_At       RETURNING VALUE(rv_insert) TYPE string.
    METHODS tweet_Degistir RETURNING VALUE(rv_update) TYPE string.
    METHODS tweet_Sil      RETURNING VALUE(rv_delete) TYPE string.
    METHODS tweet_Goster   RETURNING VALUE(rv_show)   TYPE string.

ENDCLASS.


CLASS lcl_main IMPLEMENTATION.

  METHOD tweet_at.

    DATA: lv_snro TYPE numc3.
    CLEAR gs_twitter.

    IF p_txt IS NOT INITIAL.

      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr = '01'
          object      = 'ZOT_04_SNR'
        IMPORTING
          number      = lv_snro.

      gs_twitter = VALUE #( id = lv_snro
                            text = p_txt  ).

      INSERT zot_04_t_p_twtr FROM gs_twitter.
      IF sy-subrc EQ 0.
        rv_insert  = |ID: { gs_twitter-id } - Tweet: { gs_twitter-text } |.
      ELSE.
        rv_insert = 'Kayıt İşlemi Gerçekleşemedi'.
      ENDIF.

    ELSE.
      MESSAGE 'Lütfen Bir Text Giriniz.' TYPE 'I'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDMETHOD.

  METHOD tweet_Degistir.

    SELECT COUNT( * )
      FROM zot_04_t_p_twtr
      INTO @DATA(lv_count)
      WHERE id EQ @p_id.

    IF sy-subrc EQ 0.

      UPDATE zot_04_t_p_twtr
      SET text = p_txt
      WHERE id = p_id.

      MESSAGE | İşlem Başarıyla Gerçekleşti. | TYPE 'I'.
      rv_update  = |ID: { p_id } - Tweet: { p_txt } |.

    ELSE.

      MESSAGE | Aramış olduğunuz Tweet Id'si Bulunamadı ! | TYPE 'I'.

      LEAVE LIST-PROCESSING.

    ENDIF.


  ENDMETHOD.

  METHOD tweet_Sil.

    SELECT COUNT( * )
      FROM zot_04_t_p_twtr
      INTO @DATA(lv_count)
      WHERE id EQ @p_id.

    IF sy-subrc EQ 0.

      DELETE FROM zot_04_t_p_twtr WHERE id = p_id.

      MESSAGE | İşlem Başarıyla Gerçekleşti. | TYPE 'I'.
      rv_delete  = | { p_id } ID'li Tweet Silindi. |.

    ELSE.

      MESSAGE | Aramış olduğunuz Tweet Id'si Bulunamadı ! | TYPE 'I'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDMETHOD.



  METHOD tweet_Goster.

    SELECT COUNT( * )
      FROM zot_04_t_p_twtr
      INTO @DATA(lv_count)
      WHERE id EQ @p_id.

    IF sy-subrc EQ 0.

      SELECT SINGLE id,
                    text
        FROM zot_04_t_p_twtr
        WHERE id = @p_id
        INTO @DATA(ls_twitter).

      MESSAGE | İşlem Başarıyla Gerçekleşti. | TYPE 'I'.
      rv_show  = |ID: { p_id } - Tweet: { ls_twitter-text } |.

    ELSE.

      MESSAGE | Aramış olduğunuz Tweet Id'si Bulunamadı ! | TYPE 'I'.

      LEAVE LIST-PROCESSING.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
