# Projeto Fictício Financeiro em COBOL

Este é um projeto fictício de exemplo de um **sistema financeiro** desenvolvido em COBOL, com funcionalidades para gerenciamento de **clientes**, **contas bancárias**, **transações financeiras** (pagamentos, saques e transferências) e geração de **relatórios financeiros**.

O projeto é composto por diversos módulos e utiliza a linguagem COBOL para a implementação de suas funções principais. O objetivo desse sistema é ilustrar como sistemas financeiros podem ser modelados e implementados utilizando COBOL, com foco em operações básicas de um banco ou instituição financeira.

## Estrutura do Projeto

O sistema está organizado em várias pastas, cada uma responsável por um conjunto específico de funcionalidades. A estrutura de pastas do projeto é a seguinte:

```
/cobol-finance
    /bin
        /clientes
            - cadastro.exe
            - consulta.exe
        /contas
            - conta.exe
            - lancamento.exe
        /relatorios
            - balanco.exe
            - demonstrativo.exe
        /transacoes
            - pagamento.exe
            - saque.exe
            - transferencia.exe
        /utils
            - validacao.exe
            - utilitarios.exe
    /config
        - banco.cfg
        - log.cfg
        - sistema.cfg
    /clientes
        - cadastro.cbl
        - consulta.cbl
        - relatorio.cbl
    /contas
        - conta.cbl
        - lancamento.cbl
        - movimentacao.cbl
        - saldo.cbl
    /relatorios
        - balanco.cbl
        - demonstrativo.cbl
        - extrato.cbl
    /transacoes
        - pagamento.cbl
        - saque.cbl
        - transferencia.cbl
    /utils
        - log.cbl
        - utilitarios.cbl
        - validacao.cbl
    /tests
        /clientes
            - test_cadastro.cbl
            - test_consulta.cbl
        /contas
            - test_conta.cbl
            - test_lancamento.cbl
        /relatorios
            - test_balanco.cbl
            - test_demonstrativo.cbl
        /transacoes
            - test_pagamento.cbl
            - test_saque.cbl
            - test_transferencia.cbl
        /utils
            - test_validacao.cbl
            - test_utilitarios.cbl
    /docs
        - arquitetura.md
        - manual_usuario.md
        - especificacoes.md
```

## Módulos do Sistema

### 1. **Clientes**
- **Cadastro de Clientes**: Permite adicionar novos clientes ao sistema.
- **Consulta de Clientes**: Realiza consultas sobre clientes cadastrados.
- **Relatório de Clientes**: Gera relatórios com dados dos clientes.

### 2. **Contas**
- **Criação de Contas Bancárias**: Permite criar novas contas bancárias.
- **Lançamentos**: Registra depósitos ou retiradas em contas.
- **Movimentações**: Visualiza as movimentações realizadas nas contas.
- **Saldo**: Exibe o saldo de uma conta.

### 3. **Transações**
- **Pagamento**: Realiza pagamentos de contas.
- **Saque**: Realiza saques de valores nas contas bancárias.
- **Transferência**: Efetua transferências entre contas.

### 4. **Relatórios**
- **Balanço**: Gera relatórios financeiros sobre o ativo e passivo da empresa.
- **Demonstrativo**: Apresenta os demonstrativos financeiros de receitas e despesas.
- **Extrato**: Gera extratos bancários para clientes.

### 5. **Utilitários**
- **Validação**: Realiza validações de dados como CPF e dados financeiros.
- **Funções Utilitárias**: Funções auxiliares para o sistema, como cálculo de valores.

## Como Rodar o Sistema

### Requisitos
- **GnuCOBOL** ou outro compilador COBOL instalado.
- Sistema operacional com suporte para execução de arquivos COBOL (Linux, Windows, etc.).

### Compilação
Para compilar os programas COBOL e gerar os executáveis, use o comando de compilação do GnuCOBOL ou compilador COBOL de sua escolha. Exemplo de compilação com GnuCOBOL:

```bash
cobc -x -o /bin/clientes/cadastro.exe /clientes/cadastro.cbl
cobc -x -o /bin/contas/conta.exe /contas/conta.cbl
```

Repita o processo de compilação para todos os módulos do sistema.

### Execução
Após a compilação, os executáveis podem ser executados diretamente. Exemplo de execução:

```bash
./bin/clientes/cadastro.exe
./bin/contas/conta.exe
./bin/transacoes/pagamento.exe
```

### Testes
Os arquivos de teste estão localizados na pasta `/tests` e podem ser executados para verificar se cada módulo está funcionando corretamente. Os testes são escritos em COBOL e testam as funcionalidades principais do sistema.

Para compilar e executar os testes, utilize os mesmos comandos de compilação descritos acima, mas para os arquivos na pasta **tests**.

### Arquivos de Configuração
O sistema usa alguns arquivos de configuração localizados na pasta `/config`. Estes arquivos são responsáveis por armazenar configurações como dados de conexão ao banco de dados, configurações de log e parâmetros do sistema.

## Documentação

A documentação do sistema pode ser encontrada na pasta `/docs` e inclui:

- **Arquitetura.md**: Descrição da arquitetura do sistema e dos módulos.
- **Manual_Usuario.md**: Guia de uso para os usuários do sistema.
- **Especificacoes.md**: Detalhamento das especificações do sistema, incluindo requisitos e funcionalidades.

## Observações
- Este é um **projeto fictício de exemplo** para fins educacionais. Não é um sistema real em produção.
- O código COBOL e os arquivos de teste têm como objetivo ilustrar como um sistema financeiro básico pode ser implementado utilizando COBOL.

## Conclusão

Este projeto mostra como um sistema bancário simples pode ser implementado utilizando COBOL. Ele abrange funcionalidades essenciais para gerenciamento de clientes, contas bancárias e transações financeiras, com testes e documentação inclusos.