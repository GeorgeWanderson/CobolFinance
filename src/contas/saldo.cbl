       IDENTIFICATION DIVISION.
       PROGRAM-ID. ConsultaSaldoConta.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ContaFile ASSIGN TO 'contas.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  ContaFile.
       01  ContaRecord.
           05  ContaNumero     PIC 9(5).
           05  ContaTitular    PIC A(50).
           05  ContaSaldo      PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01  WS-ContaNumero       PIC 9(5).
       01  WS-ContaTitular      PIC A(50).
       01  WS-ContaSaldo        PIC 9(7)V99 VALUE 0.
       01  WS-FileStatus        PIC XX.
       01  WS-ExitFlag          PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN I-O ContaFile
           PERFORM MenuPrincipal
           CLOSE ContaFile
           STOP RUN.

       MenuPrincipal.
           DISPLAY 'Consulta de Saldo'
           DISPLAY '------------------'
           DISPLAY 'Digite o número da conta (5 dígitos): '
           ACCEPT WS-ContaNumero

           PERFORM BuscarConta
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta não encontrada!'
               MOVE 'Y' TO WS-ExitFlag
               DISPLAY 'Operação encerrada.'
           ELSE
               DISPLAY 'Conta encontrada!'
               DISPLAY 'Titular: ' WS-ContaTitular
               DISPLAY 'Saldo: R$ ' WS-ContaSaldo
           END-IF.

       BuscarConta.
           REWIND ContaFile
           MOVE 'N' TO WS-ExitFlag

           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ContaFile INTO ContaRecord
                   AT END
                       MOVE 'Y' TO WS-ExitFlag
                       EXIT PERFORM
                   NOT AT END
                       IF ContaNumero = WS-ContaNumero
                           MOVE ContaTitular TO WS-ContaTitular
                           MOVE ContaSaldo TO WS-ContaSaldo
                           MOVE 'N' TO WS-ExitFlag
                       END-IF
               END-READ
           END-PERFORM.
