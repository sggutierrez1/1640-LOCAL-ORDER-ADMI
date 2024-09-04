      **************** Top of Data ****************  
          EXEC SQL DECLARE SAM-TAB TABLE
           ( SAM_ID           CHAR(06)  NOT NULL,
             SAM_NAME         CHAR(30)  NOT NULL,
             SAM_ADDRESS      CHAR(30)  NOT NULL,
             SAM_CONTACT      CHAR(30)  NOT NULL
           ) END-EXEC.
      *********************************************
      *COBOL DECLARATION FOR TABLE SAM
      *********************************************
       01  DCLSAM.
           10 SAM-ID           PIC X(06).
           10 SAM-NAME         PIC X(30).
           10 SAM-ADDRESS      PIC X(30).
           10 SAM-CONTACT      PIC X(30).
      ************** Bottom of Data ***************