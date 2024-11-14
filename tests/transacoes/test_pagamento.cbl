       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestPagamento.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ContaPagamento       PIC 9(10).
       01  ValorPagamento       PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-PAGAMENTO.
           DISPLAY 'Teste de Pagamento de Transação'.
           DISPLAY 'Informe o número da conta para pagamento: '.
           ACCEPT ContaPagamento.

           DISPLAY 'Informe o valor do pagamento: '.
           ACCEPT ValorPagamento.

           * Simulando pagamento bem-sucedido
           DISPLAY 'Pagamento realizado com sucesso. Valor: ' ValorPagamento.

           STOP RUN.
