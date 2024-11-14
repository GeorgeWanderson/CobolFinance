       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestUtilitarios.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ValorCalculado       PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-UTILITARIOS.
           DISPLAY 'Teste de Funções Utilitárias'.
           
           * Simulando o cálculo de algum valor
           MOVE 1000.00 TO ValorCalculado.

           DISPLAY 'Valor calculado: ' ValorCalculado.

           STOP RUN.
