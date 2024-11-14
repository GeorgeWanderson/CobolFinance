       IDENTIFICATION DIVISION.
       PROGRAM-ID. LogUtils.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LogFile ASSIGN TO 'logs/banco.log'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  LogFile.
       01  LogRecord.
           05  LogDate         PIC X(10).
           05  LogTime         PIC X(8).
           05  LogLevel        PIC X(10).
           05  LogMessage      PIC X(100).

       WORKING-STORAGE SECTION.
       01  FileStatus           PIC XX.
       01  CurrentDate          PIC X(10).
       01  CurrentTime          PIC X(8).
       01  LogLevelValue        PIC X(10).
       01  LogMessageValue      PIC X(100).
       01  DateFormat           VALUE 'YYYY-MM-DD'.
       01  TimeFormat           VALUE 'HH:MM:SS'.

       PROCEDURE DIVISION.

       * Rotina principal de registro de logs
       WRITE-LOG.
           ACCEPT CurrentDate FROM DATE.
           ACCEPT CurrentTime FROM TIME.

           DISPLAY 'Digite o nível de log (DEBUG, INFO, ERROR, FATAL): '.
           ACCEPT LogLevelValue.

           DISPLAY 'Digite a mensagem do log: '.
           ACCEPT LogMessageValue.

           MOVE CurrentDate TO LogDate.
           MOVE CurrentTime TO LogTime.
           MOVE LogLevelValue TO LogLevel.
           MOVE LogMessageValue TO LogMessage.

           OPEN OUTPUT LogFile.
           WRITE LogRecord.
           CLOSE LogFile.

           DISPLAY 'Log registrado com sucesso.'.

           STOP RUN.

       * Função para gravar erros no log
       WRITE-ERROR-LOG.
           MOVE 'ERROR' TO LogLevelValue.
           MOVE 'Erro no sistema: ' TO LogMessageValue.
           PERFORM WRITE-LOG.
           STOP RUN.

       * Função para gravar informações gerais no log
       WRITE-INFO-LOG.
           MOVE 'INFO' TO LogLevelValue.
           MOVE 'Informações do sistema: ' TO LogMessageValue.
           PERFORM WRITE-LOG.
           STOP RUN.

       * Função para gravar mensagens de depuração no log
       WRITE-DEBUG-LOG.
           MOVE 'DEBUG' TO LogLevelValue.
           MOVE 'Detalhes de depuração: ' TO LogMessageValue.
           PERFORM WRITE-LOG.
           STOP RUN.

       * Função para gravar mensagens fatais no log
       WRITE-FATAL-LOG.
           MOVE 'FATAL' TO LogLevelValue.
           MOVE 'Erro fatal: ' TO LogMessageValue.
           PERFORM WRITE-LOG.
           STOP RUN.

       END PROGRAM LogUtils.
