       IDENTIFICATION DIVISION.
       PROGRAM-ID. RelatorioClientes.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ClienteFile ASSIGN TO 'clientes.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  ClienteFile.
       01  ClienteRecord.
           05  ClienteID       PIC 9(5).
           05  ClienteNome     PIC A(50).
           05  ClienteCPF      PIC X(11).
           05  ClienteEndereco PIC A(100).
           05  ClienteTelefone PIC X(15).

       WORKING-STORAGE SECTION.
       01  WS-FileStatus       PIC XX.
       01  WS-ExitFlag         PIC X VALUE 'N'.
       01  WS-ReportHeader     PIC X(100) VALUE 'Relatório de Clientes'.
       01  WS-ClientCount      PIC 9(5) VALUE 0.
       01  WS-ClientMsg        PIC X(50) VALUE 'Total de Clientes: '.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT ClienteFile
           OPEN OUTPUT ReportFile
           DISPLAY WS-ReportHeader
           DISPLAY '----------------------'
           DISPLAY 'ID   Nome                   CPF         Endereço                   Telefone'

           PERFORM ListarClientes
           CLOSE ClienteFile
           CLOSE ReportFile
           DISPLAY 'Relatório gerado com sucesso!'
           STOP RUN.

       ListarClientes.
           MOVE 0 TO WS-ClientCount
           REWIND ClienteFile

           PERFORM UNTIL WS-FileStatus = '10'  *> End of file
               READ ClienteFile INTO ClienteRecord
                   AT END
                       DISPLAY WS-ClientMsg WS-ClientCount
                       MOVE 'Y' TO WS-ExitFlag
                       EXIT PERFORM
                   NOT AT END
                       ADD 1 TO WS-ClientCount
                       DISPLAY ClienteID ' ' ClienteNome ' ' ClienteCPF ' ' ClienteEndereco ' ' ClienteTelefone
                       WRITE ClienteRecord
               END-READ
           END-PERFORM.

       END PROGRAM RelatorioClientes.
