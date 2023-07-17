*&---------------------------------------------------------------------*
*& Include          ZMM_04_I_INTERNAL_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS: create_instance RETURNING VALUE(ro_main) TYPE REF TO lcl_main.
    METHODS: start_of_selection.

ENDCLASS.


CLASS lcl_main IMPLEMENTATION.

  METHOD create_instance.
    ro_main = NEW lcl_main( ).

  ENDMETHOD.

  METHOD start_of_selection.


*ZOT_04_T_MATERİA TABLOSUNDAN VERİLER ÇEKİLİR.
    "---------------------------------------------------------------------------------------------------------------
    SELECT *
    FROM zot_04_t_materia
      INTO TABLE @DATA(lt_materia)
    WHERE matnr IN @s_index.
    "---------------------------------------------------------------------------------------------------------------


*MALZEME GRUBU 'C' OLAN 5 KAYITLI YENİ İNTERNAL TABLE OLUŞTURULUR.
    "---------------------------------------------------------------------------------------------------------------
    DATA: lt_itab TYPE TABLE OF zot_04_t_materia.

    lt_itab = VALUE #( ( matnr = '000000000000000006' maktx = 'Çekiç'     menge = '19.000' meins = 'STD' matkl = 'C')
                       ( matnr = '000000000000000007' maktx = 'Kapı'      menge = '5.000'  meins = 'STD' matkl = 'A')
                       ( matnr = '000000000000000008' maktx = 'Tornavida' menge = '7.000'  meins = 'STD' matkl = 'C')
                       ( matnr = '000000000000000009' maktx = 'Pencere'   menge = '10.000' meins = 'STD' matkl = 'A')
                       ( matnr = '000000000000000010' maktx = 'Menteşe'   menge = '41.000' meins = 'STD' matkl = 'C')
                   ).
    "---------------------------------------------------------------------------------------------------------------


*İSTENİLEN KOŞULA GÖRE Z'Lİ TABLODAKİ MENGE ALANINA 10 EKLENİR.
    "---------------------------------------------------------------------------------------------------------------
    SORT lt_itab BY matkl.

    LOOP AT lt_materia ASSIGNING FIELD-SYMBOL(<fs_materia>).

      READ TABLE lt_itab TRANSPORTING NO FIELDS WITH KEY matkl = 'C' BINARY SEARCH.
      IF sy-subrc EQ 0.

        <fs_materia>-menge = <fs_materia>-menge + '10.000'.

      ENDIF.

    ENDLOOP.
    "---------------------------------------------------------------------------------------------------------------



*Z'Lİ TABLODAN ÇEKİLEN VE PROGRAM İÇERİSİNDE DOLDURULAN İNTERNAL TABLE BİRLEŞTİRİLİR.
    "-------------------------------------------------------------------------------------------------------------------
    MOVE-CORRESPONDING lt_itab TO lt_materia.
    "------------------------------------------------------------------------------------------------------------------


*Bir İnternal table oluşturulur Collect İşlemi gerçekleştirilir.
    "-------------------------------------------------------------------------------------------------------------------
    TYPES: BEGIN OF lty_itab2,
             matkl TYPE matkl,
             menge TYPE menge_d,
           END OF lty_itab2.

    DATA: lt_itab2 TYPE TABLE OF lty_itab2.
    DATA: ls_itab2 TYPE lty_itab2.

    LOOP AT lt_materia ASSIGNING <fs_materia> .

      ls_itab2 = VALUE #( menge = <fs_materia>-menge
                          matkl = <fs_materia>-matkl ).

      COLLECT ls_itab2 INTO lt_itab2.
      CLEAR: ls_itab2.
    ENDLOOP.
    "------------------------------------------------------------------------------------------------------------------


*Menge 10'dan küçük olan satırlar birleştirilen internal table'dan silinir.
    "------------------------------------------------------------------------------------------------------------------
    LOOP AT lt_itab2 TRANSPORTING NO FIELDS WHERE menge < '10.000' .

      DELETE lt_itab2 WHERE menge < '10.000'.

    ENDLOOP.
    "-----------------------------------------------------------------------------------------------------------------


*Ekrana Menge küçükten büyüğe Maktl büyükten küçüğe sıralandırılarak basılır.
    "------------------------------------------------------------------------------------------------------------------
    SORT lt_itab2 ASCENDING BY menge DESCENDING matkl.

    DATA: lo_salv TYPE REF TO cl_salv_table.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table   = lo_salv
      CHANGING
        t_table        = lt_itab2
    ).
*CATCH cx_salv_msg.
    lo_salv->display( ).
    "------------------------------------------------------------------------------------------------------------------

  ENDMETHOD.



ENDCLASS.
