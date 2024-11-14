       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestValidacao.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  CPFCliente           PIC X(11).

       PROCEDURE DIVISION.

       TESTAR-VALIDACAO.
           DISPLAY 'Teste de Validação de CPF'.
           DISPLAY 'Informe o CPF (somente números): '.
           ACCEPT CPFCliente.

           * Simulando a validação de CPF
           IF CPFCliente = '12345678901'
               DISPLAY 'CPF válido: ' CPFCliente
           ELSE
               DISPLAY 'Erro: CPF inválido.'
           END-IF.

           STOP RUN.
