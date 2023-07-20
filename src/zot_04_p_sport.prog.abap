*&---------------------------------------------------------------------*
*& Report ZOT_04_P_SPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_04_P_SPORT.

TYPES: BEGIN OF gty_takimlar,
         takim_id    TYPE num2,
         takım_adı   TYPE char30,
         takım_uyruk TYPE char2,
         group_adi   TYPE char1,
         torba       TYPE char10,
       END OF gty_takimlar.


TYPES: BEGIN OF gty_groupA,
         takim_id    TYPE num2,
         takım_adı   TYPE char30,
         takım_uyruk TYPE char2,
         group_adi   TYPE char1,
         torba       TYPE char10,
       END OF gty_groupA.

TYPES: BEGIN OF gty_groupB,
         takim_id    TYPE num2,
         takım_adı   TYPE char30,
         takım_uyruk TYPE char2,
         group_adi   TYPE char1,
         torba       TYPE char10,
       END OF gty_groupB.

TYPES: BEGIN OF gty_groupC,
         takim_id    TYPE num2,
         takım_adı   TYPE char30,
         takım_uyruk TYPE char2,
         group_adi   TYPE char1,
         torba       TYPE char10,
       END OF gty_groupC.

TYPES: BEGIN OF gty_groupD,
         takim_id    TYPE num2,
         takım_adı   TYPE char30,
         takım_uyruk TYPE char2,
         group_adi   TYPE char1,
         torba       TYPE char10,
       END OF gty_groupD.

DATA:
  gt_takimlar TYPE TABLE OF gty_takimlar,
  gt_groupA   TYPE TABLE OF gty_groupA,
  gt_groupB   TYPE TABLE OF gty_groupB,
  gt_groupC   TYPE TABLE OF gty_groupC,
  gt_groupD   TYPE TABLE OF gty_groupD.

DATA:
  gt_bastir TYPE TABLE OF gty_takimlar.

gt_takimlar = VALUE #(  ( takim_id = 01 takim_adi = 'Liverpool'   takim_uyruk = 'EN'  torba = '1.TORBA' )
                        ( takim_id = 02 takim_adi = 'Bayern M.l'  takim_uyruk = 'DE'  torba = '1.TORBA' )
                        ( takim_id = 03 takim_adi = 'Inter'       takim_uyruk = 'IT'  torba = '1.TORBA' )
                        ( takim_id = 04 takim_adi = 'PSG'         takim_uyruk = 'FR'  torba = '1.TORBA' )
                        ( takim_id = 05 takim_adi = 'Manch. City' takim_uyruk = 'EN'  torba = '2.TORBA' )
                        ( takim_id = 06 takim_adi = 'PSU'         takim_uyruk = 'NE'  torba = '2.TORBA' )
                        ( takim_id = 07 takim_adi = 'Porto'       takim_uyruk = 'PO'  torba = '2.TORBA' )
                        ( takim_id = 08 takim_adi = 'Real Madrid' takim_uyruk = 'ES'  torba = '2.TORBA' )
                        ( takim_id = 09 takim_adi = 'Dortmund'    takim_uyruk =  'DE' torba = '3.TORBA' )
                        ( takim_id = 10 takim_adi = 'Galatasaray' takim_uyruk = 'TR'  torba = '3.TORBA' )
                        ( takim_id = 11 takim_adi = 'Marsilya'    takim_uyruk = 'FR'  torba = '3.TORBA' )
                        ( takim_id = 12 takim_adi = 'Ajax'        takim_uyruk = 'NE'  torba = '3.TORBA' )
                        ( takim_id = 13 takim_adi = 'AEK'         takim_uyruk = 'GR'  torba = '4.TORBA' )
                        ( takim_id = 14 takim_adi = 'Roma'        takim_uyruk = 'IT'  torba = '4.TORBA' )
                        ( takim_id = 15 takim_adi = 'Bükreş'      takim_uyruk = 'RO'  torba = '4.TORBA' )
                        ( takim_id = 16 takim_adi = 'Atletico M.' takim_uyruk = 'ES'  torba = '4.TORBA' ) ).


DATA: gv_random_i TYPE int4.

DATA: lv_count TYPE int4.


DATA: lv_bool TYPE char1.
lv_bool = 'X'.

WHILE lv_bool EQ 'X'.

  DESCRIBE TABLE gt_groupa LINES DATA(birinci_lines).
  DESCRIBE TABLE gt_groupb LINES DATA(ikinci_lines).
  DESCRIBE TABLE gt_groupc LINES DATA(ucuncu_lines).
  DESCRIBE TABLE gt_groupd LINES DATA(dorduncu_lines).

  IF birinci_lines EQ 4 AND ikinci_lines EQ 4 AND ucuncu_lines EQ 4 AND dorduncu_lines EQ 4.
    EXIT .
  ENDIF.

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max   = 16
      ran_int_min   = 1
    IMPORTING
      ran_int       = gv_random_i
    EXCEPTIONS
      invalid_input = 1
      OTHERS        = 2.

  DATA(gv_random_num) = CONV num2( gv_random_i ).


  "----------------------GroupA
  CLEAR: lv_count.

  READ TABLE gt_takimlar INTO DATA(ls_takimlar) WITH KEY takim_id = gv_random_num.
  IF sy-subrc EQ 0.


    READ TABLE gt_groupa INTO DATA(ls_check) WITH KEY torba = ls_takimlar-torba .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    READ TABLE gt_groupa INTO ls_check WITH KEY takim_uyruk = ls_takimlar-takim_uyruk .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    IF lv_count EQ 2.
      APPEND VALUE #(
      takim_id = ls_takimlar-takim_id
      takım_adı  = ls_takimlar-takim_adi
      takım_uyruk = ls_takimlar-takim_uyruk
      group_adi  = 'A'
      torba     = ls_takimlar-torba ) TO gt_groupa.
      DELETE gt_takimlar WHERE takim_id = ls_takimlar-takim_id.
      CLEAR: lv_count.
    ENDIF.


    READ TABLE gt_takimlar INTO ls_takimlar WITH KEY takim_id = gv_random_num.
    IF sy-subrc NE 0.
      CONTINUE.

    ENDIF.



*Group B

    CLEAR: lv_count.

    READ TABLE gt_groupb INTO ls_check WITH KEY torba = ls_takimlar-torba .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    READ TABLE gt_groupb INTO ls_check WITH KEY takim_uyruk = ls_takimlar-takim_uyruk .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    IF lv_count EQ 2.
      APPEND VALUE #(
      takim_id = ls_takimlar-takim_id
      takım_adı  = ls_takimlar-takim_adi
      takım_uyruk = ls_takimlar-takim_uyruk
      group_adi  = 'B'
      torba     = ls_takimlar-torba ) TO gt_groupb.
      DELETE gt_takimlar WHERE takim_id = ls_takimlar-takim_id.
      CLEAR: lv_count.
    ENDIF.


    READ TABLE gt_takimlar INTO ls_takimlar WITH KEY takim_id = gv_random_num.
    IF sy-subrc NE 0.
      CONTINUE.

    ENDIF.


    "Group C


    CLEAR: lv_count.

    READ TABLE gt_groupc INTO ls_check WITH KEY torba = ls_takimlar-torba .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    READ TABLE gt_groupc INTO ls_check WITH KEY takim_uyruk = ls_takimlar-takim_uyruk .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    IF lv_count EQ 2.
      APPEND VALUE #(
      takim_id = ls_takimlar-takim_id
      takım_adı  = ls_takimlar-takim_adi
      takım_uyruk = ls_takimlar-takim_uyruk
      group_adi  = 'C'
      torba     = ls_takimlar-torba ) TO gt_groupc.
      DELETE gt_takimlar WHERE takim_id = ls_takimlar-takim_id.
      CLEAR: lv_count.
    ENDIF.

    "Group D

    READ TABLE gt_takimlar INTO ls_takimlar WITH KEY takim_id = gv_random_num.
    IF sy-subrc NE 0.
      CONTINUE.

    ENDIF.


    CLEAR: lv_count.

    READ TABLE gt_groupd INTO ls_check WITH KEY torba = ls_takimlar-torba .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.

    READ TABLE gt_groupd INTO ls_check WITH KEY takim_uyruk = ls_takimlar-takim_uyruk .
    IF sy-subrc NE 0.
      lv_count = lv_count + 1.
    ENDIF.


    "- Son adım kontrolü
    DATA(gv_check) = birinci_lines + ikinci_lines + ucuncu_lines + dorduncu_lines.


    IF gv_check EQ 15.

      "Group A için torba Değişimi
      READ TABLE gt_groupd TRANSPORTING NO FIELDS WITH KEY takim_uyruk = ls_takimlar-takim_uyruk. "Son takımın uyruğu grup d'ye uygun mu
      IF sy-subrc EQ 0."Grup d'ye uygun değilse
        READ TABLE gt_groupa TRANSPORTING NO FIELDS WITH KEY takim_uyruk = ls_takimlar-takim_uyruk. "Son takımın uyruğu grup a'ya uygun mu
        IF sy-subrc NE 0."Son takımımın uyruğu grup a'ya uygunsa
          READ TABLE gt_groupa ASSIGNING FIELD-SYMBOL(<fs_grpa>) WITH KEY torba = ls_takimlar-torba.
          IF sy-subrc EQ 0.
            READ TABLE gt_groupd TRANSPORTING NO FIELDS WITH KEY takim_uyruk = <fs_grpa>-takim_uyruk. "Grup A'dan değiştireceğim takım grup d'ye uygun mu
            IF sy-subrc NE 0."Grup A'dan alacağım takım Grup D'ye uygunsa
              READ TABLE gt_groupd ASSIGNING FIELD-SYMBOL(<fs_grpd>) WITH KEY torba = ls_takimlar-torba.
              ls_takimlar-group_adi = 'A'.
              APPEND ls_takimlar TO gt_groupa.
              <fs_grpa>-group_adi = 'D'.
              APPEND <fs_grpa> TO gt_groupd.
              DELETE TABLE gt_groupa FROM <fs_grpa>.

            ENDIF.

          ENDIF.
        ENDIF.
        DESCRIBE TABLE gt_groupd LINES dorduncu_lines.
        IF dorduncu_lines NE 4.


          "Group B için torba Değişimi
          READ TABLE gt_groupb TRANSPORTING NO FIELDS WITH KEY takim_uyruk = ls_takimlar-takim_uyruk. "Son takımın uyruğu grup b'ya uygun mu
          IF sy-subrc NE 0."Son takımımın uyruğu grup a'ya uygunsa
            READ TABLE gt_groupb ASSIGNING FIELD-SYMBOL(<fs_grpb>) WITH KEY torba = ls_takimlar-torba.
            IF sy-subrc EQ 0.
              READ TABLE gt_groupd TRANSPORTING NO FIELDS WITH KEY takim_uyruk = <fs_grpb>-takim_uyruk. "Grup b'den değiştireceğim takım grup d'ye uygun mu
              IF sy-subrc NE 0."Grup b'dan alacağım takım Grup D'ye uygunsa
                READ TABLE gt_groupd ASSIGNING <fs_grpd> WITH KEY torba = ls_takimlar-torba.
                ls_takimlar-group_adi = 'B'.
                APPEND ls_takimlar TO gt_groupb.

                <fs_grpb>-group_adi = 'D'.
                APPEND <fs_grpb> TO gt_groupd.
                DELETE TABLE gt_groupb FROM <fs_grpb>.

              ENDIF.

            ENDIF.
          ENDIF.
        ENDIF.

        "Group C için torba Değişimi
        DESCRIBE TABLE gt_groupd LINES dorduncu_lines.
        IF dorduncu_lines NE 4.
          READ TABLE gt_groupc TRANSPORTING NO FIELDS WITH KEY takim_uyruk = ls_takimlar-takim_uyruk. "Son takımın uyruğu grup b'ya uygun mu
          IF sy-subrc NE 0."Son takımımın uyruğu grup a'ya uygunsa
            READ TABLE gt_groupc ASSIGNING FIELD-SYMBOL(<fs_grpc>) WITH KEY torba = ls_takimlar-torba.
            IF sy-subrc EQ 0.
              READ TABLE gt_groupd TRANSPORTING NO FIELDS WITH KEY takim_uyruk = <fs_grpc>-takim_uyruk."Grup b'den değiştireceğim takım grup d'ye uygun mu
              IF sy-subrc NE 0."Grup b'dan alacağım takım Grup D'ye uygunsa
                READ TABLE gt_groupd ASSIGNING <fs_grpd> WITH KEY torba = ls_takimlar-torba.
                ls_takimlar-group_adi = 'C'.
                APPEND ls_takimlar TO gt_groupc.
                <fs_grpc>-group_adi = 'D'.
                APPEND <fs_grpc> TO gt_groupd.
                DELETE TABLE gt_groupc FROM <fs_grpc>.

              ENDIF.

            ENDIF.
          ENDIF.
        ENDIF.

      ENDIF.
    ENDIF.



    IF lv_count EQ 2.
      APPEND VALUE #(
      takim_id = ls_takimlar-takim_id
      takım_adı  = ls_takimlar-takim_adi
      takım_uyruk = ls_takimlar-takim_uyruk
      group_adi  = 'D'
      torba     = ls_takimlar-torba ) TO gt_groupd.
      DELETE gt_takimlar WHERE takim_id = ls_takimlar-takim_id.
      CLEAR: lv_count.
    ENDIF.

    READ TABLE gt_takimlar INTO ls_takimlar WITH KEY takim_id = gv_random_num.
    IF sy-subrc NE 0.
      CONTINUE.

    ENDIF.

  ELSE.

    CONTINUE.
  ENDIF.

ENDWHILE.

APPEND LINES OF gt_groupa TO gt_bastir.
APPEND LINES OF gt_groupb TO gt_bastir.
APPEND LINES OF gt_groupc TO gt_bastir.
APPEND LINES OF gt_groupd TO gt_bastir.
SORT gt_bastir BY group_adi torba.

LOOP AT gt_bastir ASSIGNING FIELD-SYMBOL(<fs1>) GROUP BY <fs1>-group_adi.

  WRITE: / '  ', <fs1>-group_adi COLOR 5.

  LOOP AT GROUP <fs1> ASSIGNING FIELD-SYMBOL(<fs2>).

    WRITE: / '  ', <fs2>-takim_adi, <fs2>-takim_uyruk,<fs2>-torba.

  ENDLOOP.

  ULINE.

ENDLOOP.
