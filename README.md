# 🏫 Sistema de Banco de Dados - Escola Integrada

Este repositório contém o código SQL para a criação e modelagem de uma base de dados relacional desenvolvida como projeto escolar, voltada para a gestão integrada de uma instituição de ensino.

---

## 📋 Sobre o Projeto
O sistema **Escola Integrada** foi modelado para centralizar e gerir os principais setores de uma escola, englobando controlo académico, financeiro, administrativo e de recursos (como a biblioteca).

---

## 🗄️ Estrutura do Banco de Dados (Tabelas)
A base de dados é composta por várias tabelas interligadas por chaves estrangeiras (`FOREIGN KEYS`):
- **Gestão de Pessoas & Cadastros:** `aluno`, `professor`, `funcionario`, `responsavel`, `cargo`, `escola`, `endereco`.
- **Estrutura Académica:** `turma`, `sala`, `ano_letivo`, `disciplina`, `matricula`, `turma_disciplina`, `professor_disciplina`, `horario_aula`.
- **Avaliações & Desempenho:** `avaliacao`, `nota`, `frequencia`.
- **Serviços & Comunicação:** `biblioteca_livro`, `emprestimo_livro`, `comunicado`, `ocorrencia`.
- **Gestão Financeira:** `mensalidade`, `pagamento`.

---

## 🛠️ Tecnologias Utilizadas
- **MySQL / MariaDB**
- **SQL (Structured Query Language)**

---

## 🚀 Como Executar o Script
1. Certifica-te de que tens um SGBD instalado (como MySQL Workbench, XAMPP ou DBeaver).
2. Cria e executa o script completo no teu ambiente de banco de dados:

```sql
SOURCE caminho/para/escola_integrada.sql;
