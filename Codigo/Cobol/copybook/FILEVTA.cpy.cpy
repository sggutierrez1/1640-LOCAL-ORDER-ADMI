       FD VENDOR-FILE
          LABEL RECORDS ARE STANDARD.
       01  VENDOR-RECORD.
           05 VENDOR-NUMBER 	PIC 9(5).
           05 VENDOR-NAME 	PIC X(30).
002400     05 VENDOR-ADDRESS-1 	PIC X(30).
002500     05 VENDOR-ADDRESS-2 	PIC X(30).
002600     05 VENDOR-CITY 	PIC X(20).
002700     05 VENDOR-STATE 	PIC X(2).
002800     05 VENDOR-ZIP 	PIC X(10).
002900     05 VENDOR-CONTACT 	PIC X(30).
003000     05 VENDOR-PHONE 	PIC X(15).