       IDENTIFICATION DIVISION.
       PROGRAM-ID. TransacaoTransferencia.

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
       01  WS-ContaOrigemNumero   PIC 9(5).
       01  WS-ContaDestinoNumero  PIC 9(5).
       01  WS-ContaOrigemTitular  PIC A(50).
       01  WS-ContaDestinoTitular PIC A(50).
       01  WS-ContaOrigemSaldo    PIC 9(7)V99 VALUE 0.
       01  WS-ContaDestinoSaldo   PIC 9(7)V99 VALUE 0.
       01  WS-FileStatus          PIC XX.
       01  WS-MovFileStatus       PIC XX.
       01  WS-Mensagem            PIC X(50).
       01  WS-ExitFlag            PIC X VALUE 'N'.
       01  WS-MovData             PIC X(10).
       01  WS-MovHora             PIC X(8).
       01  WS-MovTipo             PIC X(1).
       01  WS-MovValor            PIC 9(7)V99 VALUE 0.
       01  WS-MovDescricao        PIC A(100).
       01  WS-TransferenciaValor  PIC 9(7)V99.
       01  WS-DataAtual           PIC X(10).

       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY 'Informe o número da conta de origem: '
           ACCEPT WS-ContaOrigemNumero

           DISPLAY 'Informe o número da conta de destino: '
           ACCEPT WS-ContaDestinoNumero

           DISPLAY 'Informe o valor da transferência: '
           ACCEPT WS-TransferenciaValor

           MOVE 'Data da transferência (DD/MM/AAAA): ' TO WS-Mensagem
           DISPLAY WS-Mensagem
           ACCEPT WS-DataAtual

           OPEN INPUT ContaFile
           OPEN I-O MovimentacaoFile
           PERFORM BuscarContaOrigem
           PERFORM BuscarContaDestino
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta(s) não encontrada(s)!'
               MOVE 'Y' TO WS-ExitFlag
               DISPLAY 'Operação encerrada.'
           ELSE
               DISPLAY 'Conta de origem encontrada!'
               DISPLAY 'Titular: ' WS-ContaOrigemTitular
               DISPLAY 'Saldo atual: R$ ' WS-ContaOrigemSaldo
               DISPLAY 'Conta de destino encontrada!'
               DISPLAY 'Titular: ' WS-ContaDestinoTitular
               DISPLAY 'Saldo atual: R$ ' WS-ContaDestinoSaldo

               IF WS-TransferenciaValor > WS-ContaOrigemSaldo
                   DISPLAY 'Saldo insuficiente para transferência.'
               ELSE
                   PERFORM ProcessarTransferencia
               END-IF
           END-IF.

           CLOSE ContaFile
           CLOSE MovimentacaoFile
           STOP RUN.

       BuscarContaOrigem.
           REWIND ContaFile
           MOVE 'N' TO WS-ExitFlag

           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ContaFile INTO ContaRecord
                   AT END
                       MOVE 'Y' TO WS-ExitFlag
                       EXIT PERFORM
                   NOT AT END
                       IF ContaNumero = WS-ContaOrigemNumero
                           MOVE ContaTitular TO WS-ContaOrigemTitular
                           MOVE ContaSaldo TO WS-ContaOrigemSaldo
                           MOVE 'N' TO WS-ExitFlag
                       END-IF
               END-READ
           END-PERFORM.

       BuscarContaDestino.
           REWIND ContaFile
           MOVE 'N' TO WS-ExitFlag

           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ContaFile INTO ContaRecord
                   AT END
                       MOVE 'Y' TO WS-ExitFlag
                       EXIT PERFORM
                   NOT AT END
                       IF ContaNumero = WS-ContaDestinoNumero
                           MOVE ContaTitular TO WS-ContaDestinoTitular
                           MOVE ContaSaldo TO WS-ContaDestinoSaldo
                           MOVE 'N' TO WS-ExitFlag
                       END-IF
               END-READ
           END-PERFORM.

       ProcessarTransferencia.
           SUBTRACT WS-TransferenciaValor FROM WS-ContaOrigemSaldo
           ADD WS-TransferenciaValor TO WS-ContaDestinoSaldo

           MOVE 'T' TO WS-MovTipo
           MOVE WS-TransferenciaValor TO WS-MovValor
           MOVE 'Transferência realizada' TO WS-MovDescricao

           WRITE MovimentacaoRecord FROM MovimentacaoRecord
           DISPLAY 'Transferência realizada com sucesso!'
           DISPLAY 'Conta de origem: ' WS-ContaOrigemNumero
           DISPLAY 'Conta de destino: ' WS-ContaDestinoNumero
           DISPLAY 'Valor transferido: R$ ' WS-TransferenciaValor
           DISPLAY 'Novo saldo da conta de origem: R$ ' WS-ContaOrigemSaldo
           DISPLAY 'Novo saldo da conta de destino: R$ ' WS-ContaDestinoSaldo

           WRITE MovimentacaoRecord

           MOVE WS-ContaOrigemSaldo TO ContaSaldo
           REWRITE ContaRecord
           MOVE WS-ContaDestinoSaldo TO ContaSaldo
           REWRITE ContaRecord
           DISPLAY 'Transferência registrada nas movimentações.'
