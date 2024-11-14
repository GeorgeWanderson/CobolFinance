       IDENTIFICATION DIVISION.
       PROGRAM-ID. ContaBancaria.

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
       01  WS-Prompt            PIC X(50) VALUE 'Digite o número da conta (5 dígitos): '.
       01  WS-InputChoice       PIC X.
       01  WS-ValorOperacao     PIC 9(7)V99 VALUE 0.
       01  WS-OperacaoChoice    PIC X VALUE ' '.
       01  WS-OperacaoMenu      PIC X(50) VALUE 'Escolha a operação: [D] Depósito, [S] Saque, [C] Consulta, [E] Encerrar: '.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN I-O ContaFile
           PERFORM MenuPrincipal
           CLOSE ContaFile
           STOP RUN.

       MenuPrincipal.
           DISPLAY 'Gerenciamento de Contas Bancárias'
           DISPLAY '------------------------------'
           DISPLAY WS-Prompt
           ACCEPT WS-ContaNumero

           PERFORM BuscarConta
           IF WS-ExitFlag = 'Y'
               DISPLAY 'Conta não encontrada. Deseja abrir uma nova conta? (S/N)'
               ACCEPT WS-InputChoice
               IF WS-InputChoice = 'S' OR WS-InputChoice = 's'
                   PERFORM AbrirConta
               ELSE
                   MOVE 'Y' TO WS-ExitFlag
               END-IF
           ELSE
               DISPLAY 'Conta encontrada!'
               DISPLAY 'Titular: ' WS-ContaTitular
               DISPLAY 'Saldo: R$ ' WS-ContaSaldo
               PERFORM OperacoesConta
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

       AbrirConta.
           DISPLAY 'Abrindo nova conta...'
           DISPLAY 'Digite o nome do titular:'
           ACCEPT WS-ContaTitular
           DISPLAY 'Digite o saldo inicial:'
           ACCEPT WS-ContaSaldo

           ADD 1 TO WS-ContaNumero
           MOVE WS-ContaNumero TO ContaNumero
           MOVE WS-ContaTitular TO ContaTitular
           MOVE WS-ContaSaldo TO ContaSaldo

           WRITE ContaRecord
           DISPLAY 'Conta aberta com sucesso!'

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
                   DISPLAY 'Depósito realizado com sucesso!'
               WHEN 'S' OR 's'
                   DISPLAY 'Digite o valor do saque:'
                   ACCEPT WS-ValorOperacao
                   IF WS-ValorOperacao <= WS-ContaSaldo
                       SUBTRACT WS-ValorOperacao FROM WS-ContaSaldo
                       MOVE WS-ContaSaldo TO ContaSaldo
                       REWRITE ContaRecord
                       DISPLAY 'Saque realizado com sucesso!'
                   ELSE
                       DISPLAY 'Saldo insuficiente!'
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
