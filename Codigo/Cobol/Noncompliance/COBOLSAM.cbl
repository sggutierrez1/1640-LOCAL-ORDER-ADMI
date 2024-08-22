      **********************************************************
      * COBOL-SQL-ESTANDARD                                    *
      *                                                        *
      * LECTURA DE ARCHIVO SAMPLE-FILE   -COPYBOOK SAM-FILE-   *
      *                               PARA FILE DESCRIPCION    *
      *                                                        *
      * ACCESO A LA TABLA SAM-TAB        - INCLUDE DCLSAM -    *
      *                               PARA ESTRUCTURAS SQL     *
      *                                                        *
      * POR CADA REGISTRO LEIDO EN ARCHIVO SAM-FILE            *
      * ACCESA LA TABLA SAM-TAB CON EL ID                      *
      *                                                        *
      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBOLSQL.
       ENVIRONMENT DIVISION.      
       INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     SELECT SAM-FILE
001100 		  ASSIGN TO "Sample-File"
001200 		  ORGANIZATION IS INDEXED
001300 		  RECORD KEY IS SAM-FILE-KEY-NUMBER
001400 		  ACCESS MODE IS DYNAMIC
                  FILE STATUS WS-SAM-FILE-STATUS.
001500   
001600 DATA DIVISION.
001700 FILE SECTION.
001800
      *COPY SAM-FILE.
       FD SAM-FILE
          RECORD NAME SAM-FILE-RECORD
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 96 CHARACTERS.
       01 SAM-FILE-RECORD.
          05 SAM-FILE-KEY-NUMBER 	PIC X(6).
          05 SAM-FILE-NAME    		PIC X(30).
          05 SAM-FILE-ADDRESS  		PIC X(30).
          05 SAM-FILE-CONTACT 		PIC X(30). 

       WORKING-STORAGE SECTION.

      *EXEC SQL
      *     INCLUDE SQLCA
      *END-EXEC.
       01 SQLCA.
          05 SQLCAID      PIC X(8).
          05 SQLCABC      PIC S9(9) COMP-5.   
          05 SQLCODE      PIC S9(9) COMP-5.
          05 SQLERRM.
             49 SQLERRML  PIC S9(4) COMP-5.
             49 SQLERRMC  PIC X(70).
          05 SQLERRP      PIC X(8).
          05 SQLERRD      OCCURS 6 TIMES
                          PIC S9(9) COMP-5.
          05 SQLWARN.
             10 SQLWARN0  PIC X.
             10 SQLWARN1  PIC X.
             10 SQLWARN2  PIC X.
             10 SQLWARN3  PIC X.
             10 SQLWARN4  PIC X.
             10 SQLWARN5  PIC X.
             10 SQLWARN6  PIC X.
             10 SQLWARN7  PIC X.
          05 SQLEXT.
             10 SQLWARN8  PIC X.
             10 SQLWARN9  PIC X.
             10 SQLWARNA  PIC X.
             10 SQLSTATE  PIC X(5)
    
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
     
      *EXEC SQL
      *     INCLUDE DCLSAM
      *END-EXEC.
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
       01 DCLSAM.
           10 SAM-ID           PIC X(06).
           10 SAM-NAME         PIC X(30).
           10 SAM-ADDRESS      PIC X(30).
           10 SAM-CONTACT      PIC X(30).
      ************** Bottom of Data ***************
       EXEC SQL END DECLARE SECTION END-EXEC.
      
       01  WS-AREA.
           05  WS-SAM-FILE-STATUS     PIC XX   VALUE SPACES.
               88 SAM-FILE-EOF                 VALUE '10'.
               88 SAM-FILE-OPEN                VALUE '00'.
 
       PROCEDURE DIVISION.
       0000-PROGRAMA.

           PERFORM 0100-INICIO  THRU 0100-FIN 

           PERFORM 0500-PROCESO THRU 0500-FIN 
                   UNTIL SAM-FILE-EOF.

           PERFORM 0900-TERMINA THRU 0900-FIN.

           STOP RUN.
          
       0100-INICIO.
           OPEN INPUT SAM-FILE.
           PERFORM 0120-LEE-SAM-FILE
                   THRU 0120-FIN.
       0100-FIN.
           EXIT.

       0120-LEE-SAM-FILE.
           READ SAM-FILE NEXT AT END
                DISPLAY "PROGRAMA FIN SAM-FILE".
       0120-FIN.
           EXIT.

       0140-SELECT-SAM-TAB.
           MOVE SAM-FILE-KEY-NUMBER TO SAM-ID.
           EXEC SQL
               SELECT SAM_ID, 
                      SAM_NAME,
                      SAM_ADDRESS,
                      SAM_CONTACT
               INTO   :SAM-ID, 
                      :SAM-NAME,
                      :SAM-ADDRESS,
                      :SAM-CONTACT
                 FROM SAM-TAB
                WHERE SAM_ID = :SAM-ID 
           END-EXEC.

           EVALUATE SQLCODE              
               WHEN ZERO           
                    DISPLAY "PROGRAMA SAME-ID " SAME-ID " FOUND "
               WHEN OTHER
                    DISPLAY "PROGRAMA SAME-ID " SAME-ID " NOT FOUND "
           END-EVALUATE.
       0140-FIN.
           EXIT.

       0500-PROCESO.
           MOVE SAM-FILE-ID  TO  SAM-ID.
           PERFORM 0140-SELECT-SAM-TAB THRU 0140-FIN. 
           PERFORM 0120-LEE-SAM-FILE   THRU 0120-FIN.
       0500-FIN.
           EXIT.

       0900-TERMINA.
           CLOSE SAM-FILE.
           DISPLAY "PROGRAMA FIN PROCESO"
       0900-FIN.
           EXIT.