*&---------------------------------------------------------------------*
*& Report ZOT_04_P_ASALSAYI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_04_p_asalsayi.

*PARAMETERS: p_prmtr1 TYPE numc5 OBLIGATORY.
*PARAMETERS: p_prmtr2 TYPE numc2 OBLIGATORY.
*
*DATA: i    TYPE i,
*      j    TYPE i VALUE 2,
*      flaggg TYPE C LENGTH 1.
*
*i = p_prmtr1.
*
*WHILE ( i LE p_prmtr2 ).
*
*
*  IF ( i EQ 1 ) OR ( i EQ 0 ).
*      i = i + 1.
*    CONTINUE.
*  ENDIF.
*
*  flaggg = abap_true.
*
*  WHILE ( j LE i ).
*    j = j + 1.
*    i = i / j.
*
*    IF ( i MOD j EQ 0 ).
*
*      flaggg = abap_false.
*      EXIT.
*    ENDIF.
*
**    j = j + 1.
*,
*  ENDWHILE.
*
*  IF ( flaggg EQ abap_true ).
*    WRITE i.
*  ENDIF.
*
*  i = i + 1.
*
*ENDWHILE.
