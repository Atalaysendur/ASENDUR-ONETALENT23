*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZOT_04_T_MATERIA................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_MATERIA              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_MATERIA              .
CONTROLS: TCTRL_ZOT_04_T_MATERIA
            TYPE TABLEVIEW USING SCREEN '0009'.
*...processing: ZOT_04_T_P_AILE.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_AILE               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_AILE               .
CONTROLS: TCTRL_ZOT_04_T_P_AILE
            TYPE TABLEVIEW USING SCREEN '0005'.
*...processing: ZOT_04_T_P_ATUR.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_ATUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_ATUR               .
CONTROLS: TCTRL_ZOT_04_T_P_ATUR
            TYPE TABLEVIEW USING SCREEN '0004'.
*...processing: ZOT_04_T_P_EGTM.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_EGTM               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_EGTM               .
CONTROLS: TCTRL_ZOT_04_T_P_EGTM
            TYPE TABLEVIEW USING SCREEN '0007'.
*...processing: ZOT_04_T_P_ETUR.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_ETUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_ETUR               .
CONTROLS: TCTRL_ZOT_04_T_P_ETUR
            TYPE TABLEVIEW USING SCREEN '0006'.
*...processing: ZOT_04_T_P_ILTSM................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_ILTSM              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_ILTSM              .
CONTROLS: TCTRL_ZOT_04_T_P_ILTSM
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZOT_04_T_P_ITUR.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_ITUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_ITUR               .
CONTROLS: TCTRL_ZOT_04_T_P_ITUR
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZOT_04_T_P_MAST.................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_P_MAST               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_P_MAST               .
CONTROLS: TCTRL_ZOT_04_T_P_MAST
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZOT_04_T_ZMN....................................*
DATA:  BEGIN OF STATUS_ZOT_04_T_ZMN                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_04_T_ZMN                  .
CONTROLS: TCTRL_ZOT_04_T_ZMN
            TYPE TABLEVIEW USING SCREEN '0008'.
*.........table declarations:.................................*
TABLES: *ZOT_04_T_MATERIA              .
TABLES: *ZOT_04_T_P_AILE               .
TABLES: *ZOT_04_T_P_ATUR               .
TABLES: *ZOT_04_T_P_EGTM               .
TABLES: *ZOT_04_T_P_ETUR               .
TABLES: *ZOT_04_T_P_ILTSM              .
TABLES: *ZOT_04_T_P_ITUR               .
TABLES: *ZOT_04_T_P_MAST               .
TABLES: *ZOT_04_T_ZMN                  .
TABLES: ZOT_04_T_MATERIA               .
TABLES: ZOT_04_T_P_AILE                .
TABLES: ZOT_04_T_P_ATUR                .
TABLES: ZOT_04_T_P_EGTM                .
TABLES: ZOT_04_T_P_ETUR                .
TABLES: ZOT_04_T_P_ILTSM               .
TABLES: ZOT_04_T_P_ITUR                .
TABLES: ZOT_04_T_P_MAST                .
TABLES: ZOT_04_T_ZMN                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
