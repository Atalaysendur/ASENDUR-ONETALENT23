*&---------------------------------------------------------------------*
*& Report ZOT_04_P_FIBONACHI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_fibonachi.

PARAMETERS: p_prmtr1 TYPE numc5 OBLIGATORY. "28
PARAMETERS: p_prmtr2 TYPE numc1 OBLIGATORY. "3

DATA: n1 TYPE int4,
      n2 TYPE int4 VALUE 1,
      n3 TYPE int4.

DATA: lv_counter TYPE int1 VALUE 2.
DATA: lv_counter2 TYPE int1 VALUE 1.
START-OF-SELECTION.

  IF ( p_prmtr1 > 10000 OR p_prmtr1 < 0 ) OR " 28    3
     ( p_prmtr2 > 10 OR p_prmtr1 < 0 ).
    MESSAGE 'Lütfen geçerli bir sayı giriniz.' TYPE 'I'.
  ELSE.
    WHILE ( lv_counter LT p_prmtr1 ).
      IF lv_counter2 MOD p_prmtr2 = 0.
        n3 = n1 + n2.
        IF n3 GE p_prmtr1.
          EXIT.
        ENDIF.
        WRITE  n3.
        n1 = n2.
        n2 = n3.
        NEW-LINE.
      ELSE.
        n3 = n1 + n2.
        IF n3 GE p_prmtr1.
          EXIT.
        ENDIF.
        WRITE  n3.
        n1 = n2.
        n2 = n3.
      ENDIF.
      lv_counter = lv_counter + 1.
      lv_counter2 = lv_counter2 + 1.
    ENDWHILE.
  ENDIF.
