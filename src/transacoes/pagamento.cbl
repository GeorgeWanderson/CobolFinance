       IDENTIFICATION DIVISION.
       PROGRAM-ID. TransacaoPagamento.

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
       01  WS-PagamentoValor    PIC 9(7)V99.
       01  WS-DataAtual         PIC X(10).

       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY 'Informe o número da conta para pagamento: '
           ACCEPT WS-ContaNumero

           DISPLAY 'Informe o valor do pagamento: '
           ACCEPT WS-PagamentoValor

           MOVE 'Data do pagamento (DD/MM/AAAA): ' TO WS-Mensagem
           DISPLAY WS-Mensagem
           ACCEPT WS-DataAtual

           OPEN INPUT ContaFile
           OPEN I-O MovimentacaoFile
           PERFORM BuscarConta
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta não encontrada!'
               MOVE 'Y' TO WS-ExitFlag
               DISPLAY 'Operação encerrada.'
           ELSE
               DISPLAY 'Conta encontrada!'
               DISPLAY 'Titular: ' WS-ContaTitular
               DISPLAY 'Saldo atual: R$ ' WS-ContaSaldo

               IF WS-PagamentoValor > WS-ContaSaldo
                   DISPLAY 'Saldo insuficiente para pagamento.'
               ELSE
                   PERFORM ProcessarPagamento
               END-IF
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

       ProcessarPagamento.
           SUBTRACT WS-PagamentoValor FROM WS-ContaSaldo
           MOVE 'S' TO WS-MovTipo
           MOVE WS-PagamentoValor TO WS-MovValor
           MOVE 'Pagamento de conta' TO WS-MovDescricao

           WRITE MovimentacaoRecord FROM MovimentacaoRecord
           DISPLAY 'Pagamento realizado com sucesso!'
           DISPLAY 'Novo saldo: R$ ' WS-ContaSaldo
           DISPLAY 'Detalhes do pagamento:'
           DISPLAY 'Data: ' WS-DataAtual
           DISPLAY 'Valor pago: R$ ' WS-PagamentoValor
           DISPLAY 'Descrição: ' WS-MovDescricao
           WRITE MovimentacaoRecord
           MOVE WS-ContaSaldo TO ContaSaldo
           REWRITE ContaRecord
           DISPLAY 'Pagamento registrado na movimentação.'
