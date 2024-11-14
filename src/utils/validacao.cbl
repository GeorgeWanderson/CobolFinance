       IDENTIFICATION DIVISION.
       PROGRAM-ID. Validacao.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           * Controle de arquivos, se necessário

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  CPF                         PIC X(11).
       01  CNPJ                        PIC X(14).
       01  DataValida                  PIC X(10).
       01  DataInformada               PIC X(10).
       01  Meses                        VALUE 'JANFEVMARABRMAIMJULAGOSETOUTNOVDEZ'.
       01  DiaMes                      PIC 99.
       01  Mes                          PIC 99.
       01  Ano                          PIC 9999.

       01  ValorValido                 PIC X VALUE 'S'.
       01  Erro                        PIC X VALUE 'N'.
       01  MensagemErro                PIC X(100).
       01  MensagemSucesso             PIC X(100).

       PROCEDURE DIVISION.

       * Função para validar CPF
       VALIDAR-CPF.
           DISPLAY 'Digite o CPF (somente números): '.
           ACCEPT CPF.

           IF FUNCTION LENGTH(CPF) = 11 AND FUNCTION NUMVAL(CPF) > 0
               DISPLAY 'CPF válido: ' CPF
           ELSE
               MOVE 'Erro: CPF inválido. O CPF deve ter 11 dígitos numéricos.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para validar CNPJ
       VALIDAR-CNPJ.
           DISPLAY 'Digite o CNPJ (somente números): '.
           ACCEPT CNPJ.

           IF FUNCTION LENGTH(CNPJ) = 14 AND FUNCTION NUMVAL(CNPJ) > 0
               DISPLAY 'CNPJ válido: ' CNPJ
           ELSE
               MOVE 'Erro: CNPJ inválido. O CNPJ deve ter 14 dígitos numéricos.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para validar a data no formato DD/MM/YYYY
       VALIDAR-DATA.
           DISPLAY 'Digite a data no formato DD/MM/YYYY: '.
           ACCEPT DataInformada.

           MOVE FUNCTION NUMVAL(DataInformada(1:2)) TO DiaMes
           MOVE FUNCTION NUMVAL(DataInformada(4:5)) TO Mes
           MOVE FUNCTION NUMVAL(DataInformada(7:10)) TO Ano

           IF (DiaMes >= 1 AND DiaMes <= 31) AND (Mes >= 1 AND Mes <= 12) AND (Ano >= 1000 AND Ano <= 9999)
               DISPLAY 'Data válida: ' DataInformada
           ELSE
               MOVE 'Erro: Data inválida. Verifique o formato e os valores.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para validar um valor monetário positivo
       VALIDAR-VALOR.
           DISPLAY 'Digite o valor monetário (exemplo: 1234567.89): '.
           ACCEPT Valor.

           IF FUNCTION NUMVAL(Valor) >= 0
               DISPLAY 'Valor válido: ' Valor
           ELSE
               MOVE 'Erro: Valor negativo não é permitido.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para verificar se um valor é numérico
       VALIDAR-NUMERO.
           DISPLAY 'Digite um número: '.
           ACCEPT Valor.

           IF FUNCTION NUMVAL(Valor) > 0
               DISPLAY 'Número válido: ' Valor
           ELSE
               MOVE 'Erro: O valor deve ser numérico e maior que zero.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para validar uma entrada não vazia
       VALIDAR-ENTRADA-NON-VAZIA.
           DISPLAY 'Digite um valor (não pode ser vazio): '.
           ACCEPT Valor.

           IF FUNCTION LENGTH(Valor) > 0
               DISPLAY 'Valor válido: ' Valor
           ELSE
               MOVE 'Erro: A entrada não pode ser vazia.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       END PROGRAM Validacao.
