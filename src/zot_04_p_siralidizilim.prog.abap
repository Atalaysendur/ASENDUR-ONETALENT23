*&---------------------------------------------------------------------*
*& Report ZOT_04_P_SIRALIDIZILIM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_siralidizilim.

PARAMETERS: p_prmtr1 TYPE numc3 OBLIGATORY.
PARAMETERS: p_prmtr2 TYPE numc1 OBLIGATORY.

DATA: lv_counter TYPE int1.

START-OF-SELECTION.

  IF ( p_prmtr1 > 100 OR p_prmtr1 < 0 ) OR  ( p_prmtr2 > 10 OR p_prmtr1 < 0 ).
    MESSAGE 'Lütfen geçerli bir sayı giriniz.' TYPE 'I'.

  ELSE.

    DO p_prmtr1 TIMES.

      lv_counter =  lv_counter + 1.

      IF lv_counter MOD p_prmtr2 = 0.
        WRITE: lv_counter.
        NEW-LINE.
      ELSE.
        WRITE: lv_counter.

      ENDIF.

    ENDDO.

  ENDIF.
