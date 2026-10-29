# Matão Auto Center — Assistente com IA

Projeto de automação de atendimento para um centro automotivo, desenvolvido com n8n, PostgreSQL e Ollama.

## Objetivo

Criar um assistente capaz de automatizar o atendimento inicial, consultar serviços, auxiliar no agendamento e sugerir horários disponíveis.

## Tecnologias

- **n8n:** automação dos fluxos de atendimento.
- **PostgreSQL:** armazenamento de empresas, serviços, clientes, recursos e agendamentos.
- **Ollama:** execução local de modelos de linguagem.
- **Docker Compose:** gerenciamento dos serviços.

## Estrutura do projeto

- `workflows/`: exportações dos fluxos do n8n.
- `database/schema.sql`: estrutura do banco de dados.
- `docker-compose.yml`: configuração dos containers.
- `.env.example`: exemplo de configuração, sem credenciais reais.

## Como executar

1. Instale o Docker Desktop.
2. Configure as variáveis de ambiente necessárias.
3. Inicie os serviços com `docker compose up -d`.
4. Acesse o n8n em `http://localhost:5678`.
5. Importe o workflow disponível na pasta `workflows/`.
6. Configure as credenciais e restaure ou recrie o banco de dados.

## Segurança

Não armazene senhas, tokens, dados pessoais de clientes ou backups do banco no repositório público.

## Status

Projeto em desenvolvimento.