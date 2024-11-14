       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestConta.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ContaNumero        PIC 9(10).
       01  SaldoConta         PIC 9(15)V99.
       01  Sucesso            PIC X(1) VALUE 'N'.

       PROCEDURE DIVISION.

       TESTAR-CONTA.
           DISPLAY 'Teste de Criação de Conta Bancária'.
           DISPLAY 'Informe o número da conta: '.
           ACCEPT ContaNumero.

           * Simulando criação de conta com saldo inicial de 1000
           MOVE 1000.00 TO SaldoConta

           DISPLAY 'Conta criada com sucesso. Saldo inicial: ' SaldoConta.

           STOP RUN.
