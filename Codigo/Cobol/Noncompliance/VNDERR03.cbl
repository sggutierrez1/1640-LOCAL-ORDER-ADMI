000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNDERR03.
000300*--------------------------------------------------
000400* Forces an error by reading past the end of a file.
000500*--------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000 SELECT VENDOR-FILE
001100 		ASSIGN TO "vendor"
001200 		ORGANIZATION IS INDEXED
001300 		RECORD KEY IS VENDOR-NUMBER
001400 		ACCESS MODE IS DYNAMIC.
001500
001600 DATA DIVISION.
001700 FILE SECTION.
001800
001900* FD VENDOR-FILE
002000*    LABEL RECORDS ARE STANDARD.
002100* 01  VENDOR-RECORD.
002200*     05 VENDOR-NUMBER 	PIC 9(5).
002300*     05 VENDOR-NAME 	PIC X(30).
002400*     05 VENDOR-ADDRESS-1 	PIC X(30).
002500*     05 VENDOR-ADDRESS-2 	PIC X(30).
002600*     05 VENDOR-CITY 	PIC X(20).
002700*     05 VENDOR-STATE 	PIC X(2).
002800*     05 VENDOR-ZIP 	PIC X(10).
002900*     05 VENDOR-CONTACT 	PIC X(30).
003000*     05 VENDOR-PHONE 	PIC X(15).
003100*
       COPY FILEVTA.

003300 WORKING-STORAGE SECTION.
003400
003500 01 FILE-AT-END 	PIC 9.
003600
003700 PROCEDURE DIVISION.
003800     PROGRAM-BEGIN.
003900     PERFORM OPENING-PROCEDURE.
004000     PERFORM MAIN-PROCESS.
004100     PERFORM CLOSING-PROCEDURE.
004200
004300 PROGRAM-DONE.
004400     STOP RUN.
004500
004600 OPENING-PROCEDURE.
004600      MOVE SPACES TO FILE-AT-END
004700      OPEN I-O VENDOR-FILE.
004800      EVALUATE TRUE 
004800          WHEN FILE-AT-END = "Y" 
004800               MOVE "N" TO FILE-AT-END 
004800      END-EVALUATE
004800
004900 CLOSING-PROCEDURE.
005000     CLOSE VENDOR-FILE.
005100
005200 MAIN-PROCESS.
005300
005400     MOVE "N" TO FILE-AT-END.
005500     PERFORM READ-NEXT-RECORD.
005600     PERFORM READ-AND-DISPLAY
005700             UNTIL FILE-AT-END = "Y".
005800
005900 READ-AND-DISPLAY.
006000     DISPLAY VENDOR-NUMBER.
006100     PERFORM READ-NEXT-RECORD.
004800     EVALUATE TRUE 
004800        WHEN FILE-AT-END = "Y" 
004800             MOVE "N" TO FILE-AT-END 
004800     END-EVALUATE.
006200
006300 READ-NEXT-RECORD.
006400     READ VENDOR-FILE NEXT RECORD
006500          AT END MOVE "Y" TO FILE-AT-END.
006600