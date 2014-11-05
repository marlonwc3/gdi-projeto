
DROP TABLE Aloca CASCADE CONSTRAINTS PURGE;
DROP TABLE Promocao_Loja CASCADE CONSTRAINTS PURGE;
DROP TABLE Aluguel_Loja CASCADE CONSTRAINTS PURGE;
DROP TABLE Pagamento CASCADE CONSTRAINTS PURGE; 
DROP TABLE Atracao CASCADE CONSTRAINTS PURGE;
DROP TABLE Evento CASCADE CONSTRAINTS PURGE;
DROP TABLE Area CASCADE CONSTRAINTS PURGE;
DROP TABLE Aluguel CASCADE CONSTRAINTS PURGE;
DROP TABLE Telefone CASCADE CONSTRAINTS PURGE;
DROP TABLE Telefone_Func CASCADE CONSTRAINTS PURGE;
DROP TABLE Categoria CASCADE CONSTRAINTS PURGE;
DROP TABLE Externo CASCADE CONSTRAINTS PURGE;
DROP TABLE Interno CASCADE CONSTRAINTS PURGE;
DROP TABLE Funcionario CASCADE CONSTRAINTS PURGE;
DROP TABLE Loja CASCADE CONSTRAINTS PURGE;


CREATE TABLE Categoria
(
	categoria varchar2(50),
	Categoria_Descricao varchar2(200),
	CONSTRAINT Categoria_pkey1 PRIMARY KEY (categoria)
);

CREATE TABLE Loja 
(
	CNPJ varchar2(18),
	Tipo varchar2(50),
	Email varchar2(50),
	Publico_alvo varchar2(50),
	Forma_de_pagamento varchar2(50),
	Data_de_abertura date,
	Nome_da_loja varchar2(50),
	CONSTRAINT Loja_pkey PRIMARY KEY (CNPJ)
);

CREATE TABLE Pagamento
(
	Codigo integer,
	Data_de_pagamento date,
	Tipo_de_pagamento varchar(50),
	Valor number(7,2),
	CONSTRAINT Pagamento_pkey PRIMARY KEY (Codigo)
);

CREATE TABLE Area
(
	Codigo integer,
	Tipo varchar2(50),
	Descricao varchar2(200),
	Altura number(7,2),
	Comprimento number(7,2),
	Largura number(7,2),
	CONSTRAINT Area_pkey PRIMARY KEY (Codigo)
);

CREATE TABLE Evento
(
	Codigo integer,
	Descricao varchar2(200),
	Data_de_inicio date,
	Data_de_fim date,
	Privacidade varchar2(50),
	CONSTRAINT Evento_pkey PRIMARY KEY (Codigo)
);

CREATE TABLE Aluguel
(
	Codigo integer,
	Data_de_vencimento date,
	Valor number(7,2),
	Descricao varchar2(200),
	CONSTRAINT Aluguel_pkey PRIMARY KEY (Codigo)
);

CREATE TABLE Funcionario
(
	CPF varchar2(14),
	Nivel_de_escolaridade varchar2(50),
	RG varchar2(9),
	Estado_civil varchar2(50),
	Sexo varchar2(50),
	Data_de_nascimento date,
	Primeiro_nome varchar2(50),
	Sobrenome varchar2(50),
	CEP varchar2(10),
	Estado varchar2(50),
	Numero varchar2(14),
	Logradouro varchar2(50),
	Bairro varchar2(50),
	Cidade varchar2(50),
	CONSTRAINT Funcionario_pkey PRIMARY KEY (CPF)
);

CREATE TABLE Interno
(
	CPF varchar2(14),
	CPF_Supervisor varchar2(14),
	Data_de_contratacao date,
	Funcao varchar2(50),
	Salario integer,
	CONSTRAINT Interno_pkey PRIMARY KEY (CPF),
	CONSTRAINT Interno_fkey FOREIGN KEY (CPF_Supervisor) REFERENCES Funcionario (CPF),
	CONSTRAINT Interno_fkey2 FOREIGN KEY (CPF) REFERENCES Funcionario (CPF)
);

CREATE TABLE Atracao
(
	Codigo_evento integer,
	Nome varchar2(50),
	Tema varchar2(50),
	Tipo varchar2(50),
	Descricao varchar2(200),
	CONSTRAINT Atracao_pkey PRIMARY KEY (Codigo_evento, Nome),
	CONSTRAINT Atracao_fkey FOREIGN KEY (Codigo_evento) REFERENCES Evento (Codigo)
);

CREATE TABLE Telefone
(
	CNPJ varchar2(18),
	Numero varchar2(14),
	CONSTRAINT Telefone_pkey PRIMARY KEY (CNPJ),
	CONSTRAINT Telefone_fkey FOREIGN KEY (CNPJ) REFERENCES Loja(CNPJ)
);

CREATE TABLE Telefone_Func
(
	CPF_FUNC varchar2(14),
	Numero varchar2(14),
	CONSTRAINT Telefone_Func_pkey PRIMARY KEY (CPF_FUNC),
	CONSTRAINT Telefone_Func_fkey FOREIGN KEY (CPF_FUNC) REFERENCES Funcionario(CPF)
);


CREATE TABLE Externo
(
	Loja_CNPJ varchar2(18),
	Funcionario_CPF varchar2(14),
	Grau_de_responsabilidade varchar2(50),
	Tipo_de_acesso varchar2(50),
	CONSTRAINT Externo_pkey PRIMARY KEY (Loja_CNPJ, Funcionario_CPF),
	CONSTRAINT Externo_fkey1 FOREIGN KEY (Loja_CNPJ) REFERENCES Loja(CNPJ),
	CONSTRAINT Externo_fkey2 FOREIGN KEY (Funcionario_CPF) REFERENCES Funcionario(CPF)
);

CREATE TABLE Promocao_Loja
(
	Loja_CNPJ varchar2(18),
	Promocao_Codigo integer,
	categoria varchar2(50),
	Porcentagem number(5, 2),
	Descricao_Promocao varchar2(200),
	Data_inicio date,
	Data_fim date,
	CONSTRAINT Promocao_Loja_pkey PRIMARY KEY (Loja_CNPJ, Promocao_Codigo, categoria),
	CONSTRAINT Promocao_Loja_fkey1 FOREIGN KEY (Loja_CNPJ) REFERENCES Loja(CNPJ),
	CONSTRAINT Promocao_Loja_fkey2 FOREIGN KEY (categoria) REFERENCES Categoria(categoria)
);

CREATE TABLE Aluguel_Loja
(
	Aluguel_Codigo integer,
	Loja_CNPJ varchar2(18),
	Pagamento_Codigo integer,
	CONSTRAINT AluguelLoja_pkey PRIMARY KEY (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo),
	CONSTRAINT AluguelLoja_fkey1 FOREIGN KEY (Aluguel_Codigo) REFERENCES Aluguel(Codigo),
	CONSTRAINT AluguelLoja_fkey2 FOREIGN KEY (Loja_CNPJ) REFERENCES Loja(CNPJ),
	CONSTRAINT AluguelLoja_fkey3 FOREIGN KEY (Pagamento_Codigo) REFERENCES Pagamento(Codigo)
);

CREATE TABLE Aloca
(
	Funcionario_CPF varchar2(14),
	Area_Codigo integer,
	Evento_Codigo integer,
	CONSTRAINT Aloca_pkey PRIMARY KEY (Funcionario_CPF, Area_Codigo, Evento_Codigo),
	CONSTRAINT Aloca_fkey1 FOREIGN KEY (Funcionario_CPF) REFERENCES Interno(CPF),
	CONSTRAINT Aloca_fkey2 FOREIGN KEY (Area_Codigo) REFERENCES Area(Codigo),
	CONSTRAINT Aloca_fkey3 FOREIGN KEY (Evento_Codigo) REFERENCES Evento(Codigo)
);
