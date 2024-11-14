       IDENTIFICATION DIVISION.
       PROGRAM-ID. RelatorioBalanco.

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
       01  WS-TotalSaldo        PIC 9(9)V99 VALUE 0.
       01  WS-FileStatus        PIC XX.
       01  WS-Mensagem          PIC X(50).

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT ContaFile
           MOVE 'Iniciando relatório de balanço...' TO WS-Mensagem
           DISPLAY WS-Mensagem
           MOVE 0 TO WS-TotalSaldo

           PERFORM GerarRelatorio
           CLOSE ContaFile

           MOVE 'Relatório finalizado.' TO WS-Mensagem
           DISPLAY WS-Mensagem
           DISPLAY 'Saldo total do sistema: R$ ' WS-TotalSaldo
           STOP RUN.

       GerarRelatorio.
           REWIND ContaFile
           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ContaFile INTO ContaRecord
                   AT END
                       EXIT PERFORM
                   NOT AT END
                       ADD ContaSaldo TO WS-TotalSaldo
                       DISPLAY 'Conta: ' ContaNumero ' | Titular: ' ContaTitular ' | Saldo: R$ ' ContaSaldo
               END-READ
           END-PERFORM.
