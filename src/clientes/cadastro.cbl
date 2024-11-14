       IDENTIFICATION DIVISION.
       PROGRAM-ID. CadastroCliente.

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
       01  WS-ClientID           PIC 9(5).
       01  WS-ClienteNome        PIC A(50).
       01  WS-ClienteCPF         PIC X(11).
       01  WS-ClienteEndereco    PIC A(100).
       01  WS-ClienteTelefone    PIC X(15).
       01  WS-FileStatus         PIC XX.
       01  WS-ExitFlag           PIC X VALUE 'N'.
       01  WS-Prompt             PIC X(50) VALUE 'Deseja continuar? (S/N): '.
       01  WS-InputChoice        PIC X.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN OUTPUT ClienteFile
           PERFORM CadastroLoop
           CLOSE ClienteFile
           STOP RUN.

       CadastroLoop.
           DISPLAY 'Cadastro de Cliente'
           DISPLAY '---------------------'
           DISPLAY 'Digite os dados do cliente:'
           ACCEPT WS-ClienteNome
           DISPLAY 'Nome do Cliente: ' WS-ClienteNome

           ACCEPT WS-ClienteCPF
           DISPLAY 'CPF do Cliente (somente números): ' WS-ClienteCPF

           ACCEPT WS-ClienteEndereco
           DISPLAY 'Endereço do Cliente: ' WS-ClienteEndereco

           ACCEPT WS-ClienteTelefone
           DISPLAY 'Telefone do Cliente: ' WS-ClienteTelefone

           ADD 1 TO WS-ClientID
           MOVE WS-ClientID TO ClienteID
           MOVE WS-ClienteNome TO ClienteNome
           MOVE WS-ClienteCPF TO ClienteCPF
           MOVE WS-ClienteEndereco TO ClienteEndereco
           MOVE WS-ClienteTelefone TO ClienteTelefone

           WRITE ClienteRecord
           DISPLAY 'Cliente cadastrado com sucesso!'

           DISPLAY WS-Prompt
           ACCEPT WS-InputChoice

           IF WS-InputChoice = 'N' OR WS-InputChoice = 'n'
               MOVE 'Y' TO WS-ExitFlag
           END-IF

           IF WS-ExitFlag = 'Y'
               EXIT PERFORM
           END-IF

           DISPLAY 'Cadastrar outro cliente?'
           PERFORM CadastroLoop.

       END PROGRAM CadastroCliente.
