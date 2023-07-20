*&---------------------------------------------------------------------*
*& Include          ZOT_04_I_REPORT_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION CREATE PRIVATE FINAL.

  PUBLIC SECTION.

    METHODS: at_selection_screen_output,
      get_data,
      end_of_selection,
*      fill_fcat,
*      modify_fca,
      display_alv,
      set_excluding.
    CLASS-METHODS: create_instance RETURNING VALUE(ro_main) TYPE REF TO lcl_main.
    METHODS handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING e_row_id e_column_id.
    METHODS handle_top_of_page FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING e_dyndoc_id
                table_index.


  PRIVATE SECTION.

    DATA: lv_fcat TYPE  dd02l-tabname.
    DATA: lt_sat TYPE TABLE OF gty_sat.
    DATA: lt_sas TYPE TABLE OF gty_sas.
    DATA: lo_docu TYPE REF TO cl_dd_document.
    DATA: lt_excluding TYPE ui_functions,
          lv_excluding TYPE ui_func.
    CLASS-DATA: mo_main TYPE REF TO lcl_main,
                mo_spli TYPE REF TO cl_gui_splitter_container,
                mo_sub1 TYPE REF TO cl_gui_container,
                mo_sub2 TYPE REF TO cl_gui_container,
                mo_alv  TYPE REF TO cl_gui_alv_grid,
                mo_cont TYPE REF TO cl_gui_custom_container.




    METHODS fill_main_fieldcat RETURNING VALUE(rt_fcat) TYPE lvc_t_fcat.
    METHODS fill_main_layout   RETURNING VALUE(rs_layo) TYPE lvc_s_layo.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create_instance.
    IF mo_main IS INITIAL.
      mo_main = NEW #( ).
    ENDIF.
    ro_main = mo_main.
  ENDMETHOD.

  METHOD at_selection_screen_output.

    LOOP AT SCREEN.

      screen-active = COND #( WHEN p_rad1 EQ abap_true THEN SWITCH #( screen-group1 WHEN 'EK1' THEN 0
                                                                                    WHEN 'EK2' THEN 0  )
                              WHEN p_rad2 EQ abap_true THEN SWITCH #( screen-group1 WHEN 'EB1' THEN 0
                                                                                    WHEN 'EB2' THEN 0 ) ).
      MODIFY SCREEN.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_data.

    IF p_rad1 EQ 'X'.

      SELECT eban~banfn,
             eban~bnfpo,
             eban~bsart,
             eban~matnr,
             eban~menge,
             eban~meins
        FROM eban
        INNER JOIN ekpo ON ekpo~banfn EQ eban~banfn AND ekpo~bnfpo EQ eban~bnfpo
        INTO CORRESPONDING FIELDS OF TABLE @lt_sat
      WHERE eban~banfn EQ @p_ebanfn OR eban~bnfpo EQ @p_ebnfpo .

      ASSIGN lt_sat TO  <itab>.

      lv_fcat = 'ZOT_04_S_SAT'.

      LOOP AT lt_sat ASSIGNING FIELD-SYMBOL(<fs_sat>) WHERE menge > '10.000'.
        <fs_sat>-line_color = 'C510'.
      ENDLOOP.

    ELSEIF p_rad2 EQ 'X'.

      SELECT ekpo~ebeln,
             ekpo~ebelp,
             ekpo~matnr,
             ekpo~menge,
             ekpo~meins
        FROM ekpo
        INNER JOIN eban ON ekpo~banfn EQ eban~banfn AND ekpo~bnfpo EQ eban~bnfpo
        INTO TABLE @lt_sas
        WHERE ekpo~banfn EQ @p_kbanfn OR ekpo~bnfpo EQ @p_kbanfn .

      ASSIGN lt_sas TO  <itab>.

      lv_fcat = 'ZOT_04_S_SAS'.

      LOOP AT lt_sas ASSIGNING FIELD-SYMBOL(<fs_sas>) WHERE menge > '10.000'.
        <fs_sas>-line_color = 'C510'.
      ENDLOOP.

    ENDIF.


  ENDMETHOD.

  METHOD end_of_selection.

    IF <itab> IS INITIAL.
      MESSAGE 'Veri Bulunamadı.' TYPE 'I'.
    ELSE.
      CALL SCREEN 0100.
    ENDIF.

  ENDMETHOD.


  METHOD fill_main_layout.

    rs_layo = VALUE lvc_s_layo(     zebra       = abap_true
                                    sel_mode    = 'A'
*                                    cwidth_opt  = abap_true
                                     info_fname = 'LINE_COLOR'
                                   ).
  ENDMETHOD.


  METHOD fill_main_fieldcat.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = lv_fcat
      CHANGING
        ct_fieldcat      = rt_fcat.


    IF p_rad1 EQ 'X'.

      LOOP AT rt_fcat ASSIGNING FIELD-SYMBOL(<fs_fcat>).
        <fs_fcat>-colddictxt = 'L'.
        <fs_fcat>-col_opt = abap_true.
        CASE <fs_fcat>-fieldname.
          WHEN 'BANFN' .
            <fs_fcat>-coltext = 'Sat No'.
          WHEN 'BNFPO' .
            <fs_fcat>-coltext = 'Sat Kalem No'.
          WHEN 'BSART' .
            <fs_fcat>-coltext = 'Sat Belge Türü'.
          WHEN 'MATNR' .
            <fs_fcat>-coltext = 'Sat Malzeme'.
          WHEN 'MENGE' .
            <fs_fcat>-coltext = 'Talep Miktarı'.
          WHEN 'MEINS' .
            <fs_fcat>-coltext = 'Ölçü Birimi'.
        ENDCASE.
      ENDLOOP.
    ELSEIF p_rad2 EQ 'X'.

      LOOP AT rt_fcat ASSIGNING <fs_fcat>.
        <fs_fcat>-colddictxt = 'L'.
        <fs_fcat>-col_opt = abap_true.
        CASE <fs_fcat>-fieldname.
          WHEN 'EBELN' .
            <fs_fcat>-coltext = 'Sas No'.
          WHEN 'EBELP' .
            <fs_fcat>-coltext = 'Sas Kalem No'.
          WHEN 'MATNR' .
            <fs_fcat>-coltext = 'Sas Malzeme'.
          WHEN 'MENGE' .
            <fs_fcat>-coltext = 'Sas Miktarı'.
          WHEN 'MEINS' .
            <fs_fcat>-coltext = 'Ölçü Birimi'.
        ENDCASE.
      ENDLOOP.

    ENDIF.



  ENDMETHOD.


  METHOD set_excluding.
    CLEAR: lv_excluding.
    lv_excluding = cl_gui_alv_grid=>mc_fc_loc_insert_row.
    APPEND lv_excluding TO lt_excluding.
    CLEAR: lv_excluding.
    lv_excluding = cl_gui_alv_grid=>mc_fc_loc_delete_row.
    APPEND lv_excluding TO lt_excluding.
  ENDMETHOD.

  METHOD display_alv.

    IF mo_alv IS INITIAL.


      mo_cont  = NEW #( container_name = 'CC_0110' ).

      mo_spli  = NEW #( parent  = mo_cont
                        rows    = 2
                        columns = 1 ).

      mo_spli->get_container( EXPORTING
                              row       = 1
                              column    = 1
                              RECEIVING container = mo_sub1 ).

      mo_spli->get_container( EXPORTING
                              row       = 2
                              column    = 1
                              RECEIVING container = mo_sub2 ).

      mo_spli->set_row_height( EXPORTING
                               id       = 1
                               height   = 16 ).

      lo_docu = NEW #( style = 'ALV_GRID' ).

      mo_alv   = NEW #( i_parent = mo_sub2  ).


      SET HANDLER:
                  me->handle_hotspot_click FOR mo_alv,
                  me->handle_top_of_page FOR   mo_alv.


      DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

      set_excluding( ).
      CALL METHOD mo_alv->set_table_for_first_display
        EXPORTING
          is_layout                     = me->fill_main_layout( )
          it_toolbar_excluding          = lt_excluding
        CHANGING
          it_outtab                     = <itab>
          it_fieldcatalog               = lt_fcat_main
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4.


      mo_alv->list_processing_events(
        EXPORTING
          i_event_name      =  'TOP_OF_PAGE'
          i_dyndoc_id       = lo_docu ).


    ELSE.
      mo_alv->refresh_table_display( is_stable = VALUE #( col = abap_true row = abap_true ) ).

    ENDIF.

  ENDMETHOD.


  METHOD handle_hotspot_click.
    BREAK asendur.
  ENDMETHOD.

  METHOD handle_top_of_page.

    DATA: lv_text TYPE sdydo_text_element.

    lv_text = COND #( WHEN p_rad1 EQ 'X' THEN 'SAT RAPORU' ELSE 'SAS RAPORU' ).


    lo_docu->add_text( EXPORTING
                       text      = lv_text
                       sap_style = cl_dd_document=>heading ).

    lo_docu->new_line( ).

    CLEAR: lv_text.

    lv_text = |Kullanıcı: { sy-uname }|.

    lo_docu->add_text( EXPORTING
                   text      = lv_text
                   sap_color = cl_dd_document=>list_positive
                   sap_fontsize = cl_dd_document=>medium ).

    lo_docu->new_line( ).

    CLEAR: lv_text.

    CONCATENATE  sy-datum+6(2)
                 sy-datum+4(2)
                 sy-datum(4) INTO lv_text SEPARATED BY '/'.

    lv_text = |Tarih: { lv_text }|.

    lo_docu->add_text( EXPORTING
                   text      = lv_text
                   sap_color = cl_dd_document=>list_positive
                   sap_fontsize = cl_dd_document=>medium ).

    lo_docu->new_line( ).

    CLEAR: lv_text.

    CONCATENATE  sy-datum(2)
                 sy-datum+2(2)
                 sy-datum+4(2) INTO lv_text SEPARATED BY ':'.

    lv_text = |Saat: { lv_text }|.

    lo_docu->add_text( EXPORTING
                   text      = lv_text
                   sap_color = cl_dd_document=>list_positive
                   sap_fontsize = cl_dd_document=>medium ).

    lo_docu->new_line( ).

    lo_docu->display_document( EXPORTING
                               parent  = mo_sub1 ).


  ENDMETHOD.

ENDCLASS.
