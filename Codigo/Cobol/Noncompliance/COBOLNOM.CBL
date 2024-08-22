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
       COPY SAM-FILE.
 
       WORKING-STORAGE SECTION.

       EXEC SQL
            INCLUDE SQLCA
       END-EXEC.
    
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
     
       EXEC SQL
            INCLUDE DCLSAM
       END-EXEC.
 
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