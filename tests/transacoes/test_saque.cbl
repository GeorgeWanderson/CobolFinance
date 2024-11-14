       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestSaque.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ContaSaque           PIC 9(10).
       01  ValorSaque           PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-SAQUE.
           DISPLAY 'Teste de Saque de Conta'.
           DISPLAY 'Informe o número da conta para saque: '.
           ACCEPT ContaSaque.

           DISPLAY 'Informe o valor para saque: '.
           ACCEPT ValorSaque.

           * Simulando saque bem-sucedido
           DISPLAY 'Saque realizado com sucesso. Valor: ' ValorSaque.

           STOP RUN.
