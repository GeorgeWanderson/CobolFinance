       IDENTIFICATION DIVISION.
       PROGRAM-ID. Utilitarios.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           * Aqui você pode adicionar controles de arquivos se necessário

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  DataAtual                PIC X(10).
       01  HoraAtual                PIC X(8).
       01  NumeroConta              PIC 9(10).
       01  Valor                     PIC 9(15)V99.
       01  ValorFormatado           PIC X(20).

       01  MesesTabela               VALUE 'JANFEVMARABRMAIMJULAGOSETOUTNOVDEZ'.
       01  Mes                       PIC X(3).

       01  Valido                    PIC X VALUE 'S'.
       01  Erro                      PIC X VALUE 'N'.
       
       01  MensagemErro              PIC X(100).
       01  MensagemSucesso           PIC X(100).

       01  NumeroContaValido         PIC X VALUE 'N'.

       PROCEDURE DIVISION.

       * Função para obter a data atual no formato YYYY-MM-DD
       OBTER-DATA-ATUAL.
           ACCEPT DataAtual FROM DATE.
           DISPLAY 'Data Atual: ' DataAtual.
           STOP RUN.

       * Função para obter a hora atual no formato HH:MM:SS
       OBTER-HORA-ATUAL.
           ACCEPT HoraAtual FROM TIME.
           DISPLAY 'Hora Atual: ' HoraAtual.
           STOP RUN.

       * Função para formatar valores monetários com 2 casas decimais
       FORMATAR-VALOR.
           DISPLAY 'Digite o valor a ser formatado (exemplo: 1234567.89): '.
           ACCEPT Valor.
           
           MOVE FUNCTION NUMVAL(Valor) TO Valor.
           MOVE FUNCTION NUMVAL-C(Valor) TO ValorFormatado.

           DISPLAY 'Valor formatado: ' ValorFormatado.
           STOP RUN.

       * Função para verificar se o número da conta possui 10 dígitos
       VALIDAR-CONTA.
           DISPLAY 'Digite o número da conta (10 dígitos): '.
           ACCEPT NumeroConta.

           IF FUNCTION LENGTH(NumeroConta) = 10
               MOVE 'S' TO NumeroContaValido
           ELSE
               MOVE 'N' TO NumeroContaValido
               MOVE 'Erro: Número da conta inválido. Deve ter 10 dígitos.' TO MensagemErro
           END-IF.

           IF NumeroContaValido = 'S'
               DISPLAY 'Número da conta válido.'
           ELSE
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.

       * Função para validar o mês e retornar o nome do mês
       VALIDAR-MES.
           DISPLAY 'Digite o número do mês (1 a 12): '.
           ACCEPT Mes.

           IF Mes >= '01' AND Mes <= '12'
               MOVE FUNCTION NUMVAL(Mes) TO Mes
               DISPLAY 'Mês: ' FUNCTION NUMVAL(Mes) OF Mes.
           ELSE
               MOVE 'Erro: Mês inválido. Digite um número entre 01 e 12.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.
           STOP RUN.

       * Função para calcular a soma de dois valores monetários
       SOMAR-VALORES.
           DISPLAY 'Digite o primeiro valor (exemplo: 12345.67): '.
           ACCEPT Valor.
           MOVE FUNCTION NUMVAL(Valor) TO Valor.

           DISPLAY 'Digite o segundo valor (exemplo: 1000.50): '.
           ACCEPT Valor.
           MOVE FUNCTION NUMVAL(Valor) TO Valor.
           
           ADD Valor TO SomaResultado.
           DISPLAY 'Soma dos valores: ' SomaResultado.
           STOP RUN.

       * Função para calcular o saldo de uma conta bancária
       CALCULAR-SALDO.
           DISPLAY 'Digite o saldo inicial: '.
           ACCEPT Valor.
           MOVE FUNCTION NUMVAL(Valor) TO Valor.

           DISPLAY 'Digite o total de débitos: '.
           ACCEPT ValorDebito.
           MOVE FUNCTION NUMVAL(ValorDebito) TO ValorDebito.

           DISPLAY 'Digite o total de créditos: '.
           ACCEPT ValorCredito.
           MOVE FUNCTION NUMVAL(ValorCredito) TO ValorCredito.

           SUBTRACT ValorDebito FROM Valor.
           ADD ValorCredito TO Valor.

           DISPLAY 'Saldo atual: ' Valor.
           STOP RUN.

       * Função para verificar se um valor é válido (não negativo)
       VALIDAR-VALOR.
           DISPLAY 'Digite o valor: '.
           ACCEPT Valor.

           IF FUNCTION NUMVAL(Valor) >= 0
               DISPLAY 'Valor válido: ' Valor.
           ELSE
               MOVE 'Erro: Valor negativo não é permitido.' TO MensagemErro
               DISPLAY MensagemErro
           END-IF.

           STOP RUN.
       
       END PROGRAM Utilitarios.
