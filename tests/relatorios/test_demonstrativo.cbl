       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestDemonstrativo.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  Receita             PIC 9(15)V99.
       01  Despesa             PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-DEMONSTRATIVO.
           DISPLAY 'Teste de Geração de Demonstrativo Financeiro'.
           
           MOVE 150000.00 TO Receita.
           MOVE 50000.00 TO Despesa.

           DISPLAY 'Receita Total: ' Receita.
           DISPLAY 'Despesa Total: ' Despesa.
           DISPLAY 'Demonstrativo gerado com sucesso.'

           STOP RUN.
