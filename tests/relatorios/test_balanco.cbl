       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestBalanco.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  TotalAtivo          PIC 9(15)V99.
       01  TotalPassivo        PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-BALANCO.
           DISPLAY 'Teste de Geração de Balanço'.
           
           MOVE 100000.00 TO TotalAtivo.
           MOVE 50000.00 TO TotalPassivo.

           DISPLAY 'Total Ativo: ' TotalAtivo.
           DISPLAY 'Total Passivo: ' TotalPassivo.
           DISPLAY 'Balanço gerado com sucesso.'

           STOP RUN.
