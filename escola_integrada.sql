CREATE DATABASE escola_integrada;
USE escola_integrada; 

CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL, 
    numero VARCHAR(10), 
    bairro VARCHAR(80),
    cidade VARCHAR(80),
    estado CHAR(2), 
    cep VARCHAR(10)
) ENGINE=InnoDB;

CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(255)
) ENGINE=InnoDB; 

CREATE TABLE sala (
    id_sala INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL,
    capacidade INT,
    bloco VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE ano_letivo (
    id_ano_letivo INT AUTO_INCREMENT PRIMARY KEY,
    ano VARCHAR(50) NOT NULL,
    data_inicio DATE,
    data_fim DATE
) ENGINE=InnoDB;

CREATE TABLE disciplina (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE responsavel (
    id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE biblioteca_livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY, 
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100), 
    editora VARCHAR(100),
    ano_publicacao YEAR,
    quantidade INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE escola (
    id_escola INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cnpj VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    id_endereco INT, 
    CONSTRAINT fk_escola_endereco 
        FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
) ENGINE=InnoDB;

CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL, 
    cpf VARCHAR(14) UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20),
    id_endereco INT, 
    CONSTRAINT fk_aluno_endereco 
        FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
) ENGINE=InnoDB;

CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL, 
    serie VARCHAR(50) NOT NULL,
    periodo VARCHAR(30) NOT NULL,
    id_sala INT,
    id_ano_letivo INT,
    CONSTRAINT fk_turma_sala 
        FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
    CONSTRAINT fk_turma_ano_letivo 
        FOREIGN KEY (id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo)
) ENGINE=InnoDB;

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE, 
    email VARCHAR(100),
    telefone VARCHAR(20), 
    id_cargo INT,
    CONSTRAINT fk_funcionario_cargo 
        FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
) ENGINE=InnoDB;

CREATE TABLE aluno_responsavel (
    id_aluno_responsavel INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_responsavel INT, 
    parentesco VARCHAR(50) NOT NULL,
    CONSTRAINT fk_aluno_responsavel_aluno 
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_aluno_responsavel_responsavel 
        FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel)
) ENGINE=InnoDB;

CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_turma INT,
    data_matricula DATE NOT NULL, 
    status VARCHAR(30), 
    CONSTRAINT fk_matricula_aluno 
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_matricula_turma 
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
) ENGINE=InnoDB;

CREATE TABLE turma_disciplina (
    id_turma_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT, 
    id_disciplina INT,
    CONSTRAINT fk_turma_disciplina_turma 
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    CONSTRAINT fk_turma_disciplina_disciplina 
        FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
) ENGINE=InnoDB;

CREATE TABLE professor_disciplina (
    id_professor_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT,
    id_disciplina INT,
    CONSTRAINT fk_professor_disciplina_professor
        FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    CONSTRAINT fk_professor_disciplina_disciplina 
        FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
) ENGINE=InnoDB;

CREATE TABLE horario_aula (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT,
    id_disciplina INT,
    id_professor INT,
    dia_semana VARCHAR(20) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL, 
    CONSTRAINT fk_horario_professor
        FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    CONSTRAINT fk_horario_disciplina
        FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    CONSTRAINT fk_horario_turma
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
) ENGINE=InnoDB;

CREATE TABLE avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT,
    id_disciplina INT,
    titulo VARCHAR(100),
    data_avaliacao DATE,
    valor DECIMAL(5,2) NOT NULL,
    CONSTRAINT fk_avaliacao_turma
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    CONSTRAINT fk_avaliacao_disciplina
        FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
) ENGINE=InnoDB;

CREATE TABLE nota (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_avaliacao INT,
    nota_obtida DECIMAL(5,2) NOT NULL,
    CONSTRAINT fk_nota_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_nota_avaliacao
        FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao)
) ENGINE=InnoDB;

CREATE TABLE frequencia (
    id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_turma INT,
    id_disciplina INT,
    data_aula DATE NOT NULL,
    presente BOOLEAN NOT NULL,
    CONSTRAINT fk_frequencia_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_frequencia_turma
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    CONSTRAINT fk_frequencia_disciplina
        FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
) ENGINE=InnoDB;

CREATE TABLE emprestimo_livro (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT,
    id_aluno INT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status VARCHAR(30),
    CONSTRAINT fk_emprestimo_livro_livro
        FOREIGN KEY (id_livro) REFERENCES biblioteca_livro(id_livro),
    CONSTRAINT fk_emprestimo_livro_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
) ENGINE=InnoDB;

CREATE TABLE mensalidade (
    id_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    mes VARCHAR(20) NOT NULL,
    ano YEAR NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    vencimento DATE NOT NULL,
    status VARCHAR(30), 
    CONSTRAINT fk_mensalidade_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
) ENGINE=InnoDB;

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_mensalidade INT,
    data_pagamento DATE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(50),
    CONSTRAINT fk_pagamento_mensalidade
        FOREIGN KEY (id_mensalidade) REFERENCES mensalidade(id_mensalidade)
) ENGINE=InnoDB;

CREATE TABLE comunicado (
    id_comunicado INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT,
    titulo VARCHAR(100) NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio DATE NOT NULL,
    CONSTRAINT fk_comunicado_turma
        FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
) ENGINE=InnoDB;

CREATE TABLE ocorrencia (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_funcionario INT,
    data_ocorrencia DATE NOT NULL,
    descricao TEXT NOT NULL,
    gravidade VARCHAR(30),
    CONSTRAINT fk_ocorrencia_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_ocorrencia_funcionario
        FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
) ENGINE=InnoDB;
