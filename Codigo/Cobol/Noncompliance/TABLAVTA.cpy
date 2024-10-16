      **************** Top of Data ****************  
          EXEC SQL DECLARE TABVTA TABLE
           ( NOMBRE           CHAR(30)  NOT NULL,
             CIUDAD           CHAR(30)  NOT NULL,
             ESTADO           CHAR(30)  NOT NULL 
           ) END-EXEC.
      *********************************************
      *COBOL DECLARATION FOR TABLE TABVTA
      *********************************************
       01  DCLVTA.
           10 NOMBRE           PIC X(30).
           10 CIUDAD           PIC X(30).
           10 ESTADO           PIC X(30).
      ************** Bottom of Data ***************