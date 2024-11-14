       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestLancamento.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ContaNumero        PIC 9(10).
       01  ValorLancamento    PIC 9(15)V99.
       01  SaldoConta         PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-LANCAMENTO.
           DISPLAY 'Teste de Lançamento de Transação'.
           DISPLAY 'Informe o número da conta: '.
           ACCEPT ContaNumero.

           DISPLAY 'Informe o valor do lançamento (positivo para crédito, negativo para débito): '.
           ACCEPT ValorLancamento.

           * Atualizando saldo com o lançamento
           ADD ValorLancamento TO SaldoConta.

           DISPLAY 'Saldo após o lançamento: ' SaldoConta.

           STOP RUN.
