       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestCadastro.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           * Arquivo de teste para cadastro de cliente

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  NomeCliente         PIC X(50).
       01  CPFCliente          PIC X(11).
       01  Sucesso             PIC X(1) VALUE 'N'.

       PROCEDURE DIVISION.

       TESTAR-CADASTRO.
           DISPLAY 'Teste de Cadastro de Cliente'.
           DISPLAY 'Informe o nome do cliente: '.
           ACCEPT NomeCliente.

           DISPLAY 'Informe o CPF do cliente (somente números): '.
           ACCEPT CPFCliente.

           * Supondo que o cadastro tenha sido bem-sucedido
           IF CPFCliente = '12345678901'
               MOVE 'S' TO Sucesso
               DISPLAY 'Cadastro realizado com sucesso.'
           ELSE
               DISPLAY 'Erro no cadastro do cliente.'
           END-IF.

           STOP RUN.
