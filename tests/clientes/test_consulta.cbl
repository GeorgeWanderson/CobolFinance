       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestConsulta.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  NomeCliente         PIC X(50).
       01  CPFCliente          PIC X(11).
       01  ClienteConsultado   PIC X(50).

       PROCEDURE DIVISION.

       TESTAR-CONSULTA.
           DISPLAY 'Teste de Consulta de Cliente'.
           DISPLAY 'Informe o CPF do cliente a ser consultado (somente números): '.
           ACCEPT CPFCliente.

           * Simulando consulta bem-sucedida
           IF CPFCliente = '12345678901'
               MOVE 'João Silva' TO ClienteConsultado
               DISPLAY 'Cliente encontrado: ' ClienteConsultado
           ELSE
               DISPLAY 'Cliente não encontrado.'
           END-IF.

           STOP RUN.
