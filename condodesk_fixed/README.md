# CondoDesk — Sistema de Gerenciamento de Chamados

## Stack
- Java 21 + Spring Boot 3.4.4
- JSP (Java Server Pages)
- PostgreSQL 16+
- Flyway (migrations)
- Spring Security

## Credenciais iniciais (seed)
| Usuário | Email | Senha | Perfil |
|---|---|---|---|
| Admin | admin@condodesk.com | admin123 | ADMINISTRADOR |

> Altere a senha após o primeiro acesso.

## Rodar localmente com Docker (recomendado)

```bash
docker compose up
```
Acesse: http://localhost:8080

## Rodar localmente sem Docker

Pré-requisitos: Java 21, Maven, PostgreSQL rodando em localhost:5432

```bash
# Criar banco
createdb condominio_db
createuser condominio_user
# Executar
mvn spring-boot:run
```

## Variáveis de ambiente (produção/Railway)

| Variável | Descrição |
|---|---|
| DATABASE_URL | URL completa do PostgreSQL (ex: postgresql://user:pass@host:5432/db) |
| PORT | Porta HTTP (Railway injeta automaticamente) |
| SPRING_PROFILES_ACTIVE | Definir como `docker` |

## Estrutura do banco

As migrations estão em `src/main/resources/db/migration/`:
- `V1__create_schema.sql` — cria todas as tabelas
- `V2__seed_data.sql` — dados iniciais (admin, status, tipos)

## Diagrama relacional

```
bloco (1) ──< unidade (N)
unidade (N) >──< usuario (M)  [via usuario_unidade]
chamado >── unidade
chamado >── tipo_chamado
chamado >── status_chamado
chamado (1) ──< comentario (N)
chamado (1) ──< anexo (N)
chamado (1) ──< historico_status (N)
usuario >── role
```
