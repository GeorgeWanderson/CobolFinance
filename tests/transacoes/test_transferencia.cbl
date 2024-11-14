       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestTransferencia.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ContaOrigem          PIC 9(10).
       01  ContaDestino         PIC 9(10).
       01  ValorTransferencia   PIC 9(15)V99.

       PROCEDURE DIVISION.

       TESTAR-TRANSFERENCIA.
           DISPLAY 'Teste de Transferência entre Contas'.
           DISPLAY 'Informe o número da conta de origem: '.
           ACCEPT ContaOrigem.

           DISPLAY 'Informe o número da conta de destino: '.
           ACCEPT ContaDestino.

           DISPLAY 'Informe o valor para transferência: '.
           ACCEPT ValorTransferencia.

           * Simulando transferência bem-sucedida
           DISPLAY 'Transferência realizada com sucesso. Valor: ' ValorTransferencia.

           STOP RUN.
