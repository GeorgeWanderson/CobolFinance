       IDENTIFICATION DIVISION.
       PROGRAM-ID. RelatorioDemonstrativo.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ContaFile ASSIGN TO 'contas.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.

           SELECT MovimentacaoFile ASSIGN TO 'movimentacao.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS MovFileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  ContaFile.
       01  ContaRecord.
           05  ContaNumero     PIC 9(5).
           05  ContaTitular    PIC A(50).
           05  ContaSaldo      PIC 9(7)V99.

       FD  MovimentacaoFile.
       01  MovimentacaoRecord.
           05  MovimentacaoData   PIC X(10).
           05  MovimentacaoHora   PIC X(8).
           05  MovimentacaoTipo   PIC X(1).
           05  MovimentacaoValor  PIC 9(7)V99.
           05  MovimentacaoDescricao PIC A(100).

       WORKING-STORAGE SECTION.
       01  WS-ContaNumero       PIC 9(5).
       01  WS-ContaTitular      PIC A(50).
       01  WS-ContaSaldo        PIC 9(7)V99 VALUE 0.
       01  WS-FileStatus        PIC XX.
       01  WS-MovFileStatus     PIC XX.
       01  WS-Mensagem          PIC X(50).
       01  WS-ExitFlag          PIC X VALUE 'N'.
       01  WS-MovData           PIC X(10).
       01  WS-MovHora           PIC X(8).
       01  WS-MovTipo           PIC X(1).
       01  WS-MovValor          PIC 9(7)V99 VALUE 0.
       01  WS-MovDescricao      PIC A(100).

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT ContaFile
           OPEN INPUT MovimentacaoFile
           MOVE 'Informe o número da conta para demonstrativo: ' TO WS-Mensagem
           DISPLAY WS-Mensagem
           ACCEPT WS-ContaNumero

           PERFORM BuscarConta
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta não encontrada!'
               MOVE 'Y' TO WS-ExitFlag
               DISPLAY 'Operação encerrada.'
           ELSE
               DISPLAY 'Conta encontrada!'
               DISPLAY 'Titular: ' WS-ContaTitular
               DISPLAY 'Saldo inicial: R$ ' WS-ContaSaldo
               MOVE 0 TO WS-MovValor

               DISPLAY 'Movimentações:'
               PERFORM GerarDemonstrativo
           END-IF.

           CLOSE ContaFile
           CLOSE MovimentacaoFile
           STOP RUN.

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

       GerarDemonstrativo.
           REWIND MovimentacaoFile
           MOVE 0 TO WS-MovValor

           PERFORM UNTIL WS-MovFileStatus = '10'  *> End of file
               READ MovimentacaoFile INTO MovimentacaoRecord
                   AT END
                       EXIT PERFORM
                   NOT AT END
                       IF MovimentacaoTipo = 'D' OR MovimentacaoTipo = 'S' OR MovimentacaoTipo = 'T'
                           MOVE MovimentacaoData TO WS-MovData
                           MOVE MovimentacaoHora TO WS-MovHora
                           MOVE MovimentacaoTipo TO WS-MovTipo
                           MOVE MovimentacaoValor TO WS-MovValor
                           MOVE MovimentacaoDescricao TO WS-MovDescricao

                           DISPLAY 'Data: ' WS-MovData ' | Hora: ' WS-MovHora
                           DISPLAY 'Tipo: ' WS-MovTipo ' | Valor: R$ ' WS-MovValor
                           DISPLAY 'Descrição: ' WS-MovDescricao
                       END-IF
               END-READ
           END-PERFORM.

