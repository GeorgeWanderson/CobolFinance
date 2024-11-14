       IDENTIFICATION DIVISION.
       PROGRAM-ID. ConsultaCliente.

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
       01  WS-ClienteCPF       PIC X(11).
       01  WS-ClienteNome      PIC A(50).
       01  WS-ClienteEndereco  PIC A(100).
       01  WS-ClienteTelefone  PIC X(15).
       01  WS-FileStatus       PIC XX.
       01  WS-FoundFlag        PIC X VALUE 'N'.
       01  WS-Prompt           PIC X(50) VALUE 'Digite o CPF do cliente para consulta: '.
       01  WS-InputChoice      PIC X.
       01  WS-ExitFlag         PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT ClienteFile
           PERFORM ConsultaLoop
           CLOSE ClienteFile
           STOP RUN.

       ConsultaLoop.
           DISPLAY 'Consulta de Cliente'
           DISPLAY '---------------------'
           DISPLAY WS-Prompt
           ACCEPT WS-ClienteCPF

           PERFORM BuscarCliente

           IF WS-FoundFlag = 'Y'
               DISPLAY 'Nome do Cliente: ' WS-ClienteNome
               DISPLAY 'Endereço do Cliente: ' WS-ClienteEndereco
               DISPLAY 'Telefone do Cliente: ' WS-ClienteTelefone
           ELSE
               DISPLAY 'Cliente não encontrado!'
           END-IF

           DISPLAY 'Deseja realizar outra consulta? (S/N)'
           ACCEPT WS-InputChoice

           IF WS-InputChoice = 'N' OR WS-InputChoice = 'n'
               MOVE 'Y' TO WS-ExitFlag
           END-IF

           IF WS-ExitFlag = 'Y'
               EXIT PERFORM
           END-IF

           DISPLAY 'Realizar nova consulta?'
           PERFORM ConsultaLoop.

       BuscarCliente.
           REWIND ClienteFile
           MOVE 'N' TO WS-FoundFlag

           READ ClienteFile INTO ClienteRecord
               AT END
                   DISPLAY 'Arquivo de clientes vazio ou finalizado.'
                   EXIT PERFORM
               NOT AT END
                   IF ClienteCPF = WS-ClienteCPF
                       MOVE 'Y' TO WS-FoundFlag
                       MOVE ClienteNome TO WS-ClienteNome
                       MOVE ClienteEndereco TO WS-ClienteEndereco
                       MOVE ClienteTelefone TO WS-ClienteTelefone
                   END-IF
           END-READ.
