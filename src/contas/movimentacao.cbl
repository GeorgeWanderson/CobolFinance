       IDENTIFICATION DIVISION.
       PROGRAM-ID. MovimentacaoConta.

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
       01  WS-ValorOperacao     PIC 9(7)V99 VALUE 0.
       01  WS-OperacaoChoice    PIC X VALUE ' '.
       01  WS-OperacaoMenu      PIC X(50) VALUE 'Escolha a operação: [D] Depósito, [S] Saque, [T] Transferência, [C] Consulta, [E] Encerrar: '.
       01  WS-ContaDestino      PIC 9(5).
       01  WS-ContaDestinoSaldo PIC 9(7)V99 VALUE 0.
       01  WS-MovData           PIC X(10).
       01  WS-MovHora           PIC X(8).
       01  WS-MovDescricao      PIC A(100).
       01  WS-ExitFlag          PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN I-O ContaFile
           OPEN EXTEND MovimentacaoFile
           PERFORM MenuPrincipal
           CLOSE MovimentacaoFile
           CLOSE ContaFile
           STOP RUN.

       MenuPrincipal.
           DISPLAY 'Gerenciamento de Movimentações'
           DISPLAY '----------------------------'
           DISPLAY 'Digite o número da conta origem (5 dígitos): '
           ACCEPT WS-ContaNumero

           PERFORM BuscarContaOrigem
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta não encontrada!'
               MOVE 'Y' TO WS-ExitFlag
               DISPLAY 'Operação encerrada.'
           ELSE
               DISPLAY 'Conta encontrada!'
               DISPLAY 'Titular: ' WS-ContaTitular
               DISPLAY 'Saldo: R$ ' WS-ContaSaldo
               PERFORM OperacoesConta
           END-IF.

       BuscarContaOrigem.
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

       OperacoesConta.
           DISPLAY WS-OperacaoMenu
           ACCEPT WS-OperacaoChoice

           EVALUATE WS-OperacaoChoice
               WHEN 'D' OR 'd'
                   DISPLAY 'Digite o valor do depósito:'
                   ACCEPT WS-ValorOperacao
                   ADD WS-ValorOperacao TO WS-ContaSaldo
                   MOVE WS-ContaSaldo TO ContaSaldo
                   REWRITE ContaRecord
                   PERFORM RegistrarMovimentacao
                   DISPLAY 'Depósito realizado com sucesso!'
               WHEN 'S' OR 's'
                   DISPLAY 'Digite o valor do saque:'
                   ACCEPT WS-ValorOperacao
                   IF WS-ValorOperacao <= WS-ContaSaldo
                       SUBTRACT WS-ValorOperacao FROM WS-ContaSaldo
                       MOVE WS-ContaSaldo TO ContaSaldo
                       REWRITE ContaRecord
                       PERFORM RegistrarMovimentacao
                       DISPLAY 'Saque realizado com sucesso!'
                   ELSE
                       DISPLAY 'Saldo insuficiente!'
                   END-IF
               WHEN 'T' OR 't'
                   DISPLAY 'Digite o número da conta destino: '
                   ACCEPT WS-ContaDestino

                   PERFORM BuscarContaDestino
                   IF WS-ExitFlag = 'Y'
                       DISPLAY 'Conta destino não encontrada!'
                   ELSE
                       DISPLAY 'Digite o valor da transferência: '
                       ACCEPT WS-ValorOperacao
                       IF WS-ValorOperacao <= WS-ContaSaldo
                           SUBTRACT WS-ValorOperacao FROM WS-ContaSaldo
                           MOVE WS-ContaSaldo TO ContaSaldo
                           REWRITE ContaRecord
                           ADD WS-ValorOperacao TO WS-ContaDestinoSaldo
                           MOVE WS-ContaDestinoSaldo TO ContaSaldo
                           REWRITE ContaFile
                           PERFORM RegistrarMovimentacao
                           DISPLAY 'Transferência realizada com sucesso!'
                       ELSE
                           DISPLAY 'Saldo insuficiente para a transferência!'
                       END-IF
                   END-IF
               WHEN 'C' OR 'c'
                   DISPLAY 'Saldo da conta: R$ ' WS-ContaSaldo
               WHEN 'E' OR 'e'
                   MOVE 'Y' TO WS-ExitFlag
                   DISPLAY 'Operação encerrada.'
               WHEN OTHER
                   DISPLAY 'Opção inválida!'
           END-EVALUATE

           IF WS-ExitFlag = 'N'
               PERFORM OperacoesConta
           END-IF.

       BuscarContaDestino.
           REWIND ContaFile
           MOVE 'N' TO WS-ExitFlag

           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ContaFile INTO ContaRecord
                   AT END
                       MOVE 'Y' TO WS-ExitFlag
                       EXIT PERFORM
                   NOT AT END
                       IF ContaNumero = WS-ContaDestino
                           MOVE ContaSaldo TO WS-ContaDestinoSaldo
                           MOVE 'N' TO WS-ExitFlag
                       END-IF
               END-READ
           END-PERFORM.

       RegistrarMovimentacao.
           MOVE FUNCTION CURRENT-DATE TO WS-MovData
           MOVE FUNCTION CURRENT-TIME TO WS-MovHora

           EVALUATE WS-OperacaoChoice
               WHEN 'D' OR 'd'
                   MOVE 'D' TO MovimentacaoTipo
                   MOVE WS-ValorOperacao TO MovimentacaoValor
                   MOVE 'Depósito realizado' TO MovimentacaoDescricao
               WHEN 'S' OR 's'
                   MOVE 'S' TO MovimentacaoTipo
                   MOVE WS-ValorOperacao TO MovimentacaoValor
                   MOVE 'Saque realizado' TO MovimentacaoDescricao
               WHEN 'T' OR 't'
                   MOVE 'T' TO MovimentacaoTipo
                   MOVE WS-ValorOperacao TO MovimentacaoValor
                   MOVE 'Transferência realizada' TO MovimentacaoDescricao
               WHEN OTHER
                   MOVE ' ' TO MovimentacaoTipo
           END-EVALUATE

           WRITE MovimentacaoRecord
           DISPLAY 'Movimentação registrada com sucesso.'.
