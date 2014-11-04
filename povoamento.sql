DROP TABLE Aloca;
DROP TABLE Promocao_Loja;
DROP TABLE Aluguel_Loja;
DROP TABLE Pagamento;
DROP TABLE Atracao;
DROP TABLE Evento;
DROP TABLE Area;
DROP TABLE Aluguel;
DROP TABLE Telefone;
DROP TABLE Telefone_Func;
DROP TABLE Categoria;
DROP TABLE Externo;
DROP TABLE Interno;
DROP TABLE Funcionario;
DROP TABLE Loja;

CREATE TABLE Categoria(
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
	CONSTRAINT Interno_pkey PRIMARY KEY (CPF),
	CONSTRAINT Interno_fkey FOREIGN KEY (CPF_Supervisor) REFERENCES Funcionario (CPF)
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

CREATE TABLE Promocao_Loja
(
	Loja_CNPJ varchar2(18),
	Promocao_Codigo integer,
	categoria varchar2(50),
	Porcentagem number(5, 2),
	Descricao_Promocao varchar2(200),
	Data_inicio date,
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


INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('86.814.375/0001-00', 'Roupas', 'contato@cea.com.br', 'Jovem', 'Á vista/Á prazo', SYSDATE, 'CeA');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('83.824.371/0001-00', 'Restaurante', 'contato@boteco.com.br', 'Adulto', 'Á vista/Á prazo', SYSDATE, 'Boteco - Bar e Restaurante');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('33.824.141/0002-00', 'Farmácia', 'contato@santamaria.com.br', 'Idoso', 'Á vista/Á prazo', SYSDATE, 'Farmácia Santa Maria');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('13.14.141/132-00', 'Restaurante', 'hablaconosco@donandaluz.com.br', 'Maratonista', 'Dinero', SYSDATE, 'Don Andaluz');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('13.11.111/112-00', 'Livraria', 'contato@saraiva.com.br', 'Todos', 'Á vista/Á prazo', SYSDATE, 'Livraria Saraiva');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('23.13.131/112-12', 'Ótica', 'contato@oticasdiniz.com.br', 'Todos', 'Á vista/Á prazo', SYSDATE, 'Óticas Diniz');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('23.11.121/132-11', 'Cinema', 'contato@uci.com.br', 'Jovem', 'Á vista/Á prazo', SYSDATE, 'Cinema UCI');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('93.15.128/112-11', 'Loja', 'contato@eletroshopping.com.br', 'Adulto', 'Á vista/Á prazo', SYSDATE, 'Eletroshopping');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('82.43.132/193-63', 'Mercado', 'contato@hiper.com.br', 'Todos', 'Á vista/Á prazo', SYSDATE, 'Hiper-Bombreço');

INSERT INTO Loja (CNPJ, Tipo, Email, Publico_alvo, Forma_de_pagamento, Data_de_abertura, Nome_da_loja) 
VALUES ('58.34.321/132-43', 'Loja', 'contato@rommanel.com.br', 'Adulto', 'Á vista', SYSDATE, 'Rommanel Jóias');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-1', 'Media', '1', 'Solteiro', 'Feminino', TO_DATE('09/07/1988', 'dd/mm/yyyy'), 'Tomer', 'Paz', '1', 'Paraiba', '1', 'Menino', 'Boa', 'Hellcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-2', 'Media', '2', 'Solteiro', 'Feminino', TO_DATE('20/10/1976', 'dd/mm/yyyy'), 'Samuel', 'Paz', '2', 'Pernambuco', '2', 'Coisa', 'Viagem', 'Relcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-3', 'Media', '3', 'Solteiro', 'Feminino', TO_DATE('06/12/1963', 'dd/mm/yyyy'), 'Samuel', 'Coisa', '3', 'Paraiba', '3', 'Menino', 'Viagem', 'Relcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-4', 'Media', '4', 'Casado', 'Masculino', TO_DATE('13/03/1987', 'dd/mm/yyyy'), 'Tomer', 'Lima', '4', 'Paraiba', '4', 'Menino', 'Boa', 'Hellcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-5', 'Media', '5', 'Casado', 'Masculino', TO_DATE('17/06/1992', 'dd/mm/yyyy'), 'Samuel', 'Coisa', '5', 'Paraiba', '5', 'Menino', 'Boa', 'Hellcife');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-6', 'Media', '6', 'Solteiro', 'Masculino', TO_DATE('01/05/1979', 'dd/mm/yyyy'), 'Samuel', 'Paz', '6', 'Pernambuco', '6', 'Danado', 'Boa', 'Relcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-7', 'Media', '7', 'Solteiro', 'Masculino', TO_DATE('08/06/1967', 'dd/mm/yyyy'), 'Samuel', 'Paz', '7', 'Pernambuco', '7', 'Menino', 'Boa', 'Hellcife');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-8', 'Media', '8', 'Solteiro', 'Masculino', TO_DATE('06/07/1959', 'dd/mm/yyyy'), 'Marlon', 'Lima', '8', 'Bahia', '8', 'Menino', 'Viagem', 'Hellcife');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-9', 'Media', '9', 'Solteiro', 'Masculino', TO_DATE('19/09/1985', 'dd/mm/yyyy'), 'Tomer', 'Lima', '9', 'Bahia', '9', 'Coisa', 'Viagem', 'Relcity');

INSERT INTO Funcionario (CPF, Nivel_de_escolaridade, RG, Estado_civil, Sexo, Data_de_nascimento, Primeiro_nome, Sobrenome, CEP, Estado, Numero, Logradouro, Bairro, Cidade)
VALUES ('000.000.000-0', 'Media', '10', 'Casado', 'Masculino', TO_DATE('27/10/1984', 'dd/mm/yyyy'), 'Tomer', 'Lima', '10', 'Paraiba', '10', 'Danado', 'Rosa', 'Hellcife');



INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-1', '000.000.000-0', SYSDATE, 'Gerente');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-2', '000.000.000-0', SYSDATE, 'Atendente');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-3', '000.000.000-0', SYSDATE, 'Segurança');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-4', '000.000.000-0', SYSDATE, 'Segurança');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-5', '000.000.000-2', SYSDATE, 'Gerente');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-6', '000.000.000-3', SYSDATE, 'Segurança');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-7', '000.000.000-4', SYSDATE, 'Atendente');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-8', '000.000.000-5', SYSDATE, 'Atendente');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-9', '000.000.000-6', SYSDATE, 'Higienizador');

INSERT INTO Interno (CPF, CPF_Supervisor, Data_de_contratacao, Funcao) 
	VALUES ('000.000.000-10', '000.000.000-7', SYSDATE, 'Gerente');
	
INSERT INTO Externo (Loja_CNPJ,Funcionario_CPF,Grau_de_responsabilidade,Tipo_de_acesso) VALUES('86.814.375/0001-00', '000.000.000-1','Baixo','Total');
INSERT INTO Externo (Loja_CNPJ,Funcionario_CPF,Grau_de_responsabilidade,Tipo_de_acesso) VALUES('86.814.375/0001-00', '000.000.000-2','Alto','Total');
INSERT INTO Externo (Loja_CNPJ,Funcionario_CPF,Grau_de_responsabilidade,Tipo_de_acesso) VALUES('23.13.131/112-12', '000.000.000-3','Alto','ParcialB1');
INSERT INTO Externo (Loja_CNPJ,Funcionario_CPF,Grau_de_responsabilidade,Tipo_de_acesso) VALUES('23.13.131/112-12', '000.000.000-4','Baixo','ParcialB2');
INSERT INTO Externo (Loja_CNPJ,Funcionario_CPF,Grau_de_responsabilidade,Tipo_de_acesso) VALUES('86.814.375/0001-00', '000.000.000-5','Baixo','ParcialB3');

insert into Telefone (CNPJ, Numero) 
	values ('86.814.375/0001-00', '3943-4022');

insert into Telefone (CNPJ, Numero) 
	values ('83.824.371/0001-00', '3243-2022');

insert into Telefone (CNPJ, Numero) 
	values ('33.824.141/0002-00', '3193-1022');

insert into Telefone (CNPJ, Numero) 
	values ('13.14.141/132-00', '3503-5022');

insert into Telefone (CNPJ, Numero) 
	values ('13.11.111/112-00', '3483-6029');

insert into Telefone (CNPJ, Numero) 
	values ('23.13.131/112-12', '3373-1022');

insert into Telefone (CNPJ, Numero) 
	values ('23.11.121/132-11', '3353-0027');

insert into Telefone (CNPJ, Numero) 
	values ('93.15.128/112-11', '3143-5025');

insert into Telefone (CNPJ, Numero) 
	values ('82.43.132/193-63', '3243-4032');

insert into Telefone (CNPJ, Numero) 
	values ('58.34.321/132-43', '3343-5021');
	
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-1','00000001');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-2','00000002');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-3','00000003');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-4','00000004');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-5','00000005');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-6','00000006');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-7','00000007');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-8','00000008');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-9','00000009');
INSERT INTO Telefone_Func (CPF_FUNC, NUMERO) VALUES ('000.000.000-0','00000000');

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (1, 'Externa', ' Etiam justo. Etiam pretium iaculis justo..', 74.18, 20.9, 40.61);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (2, 'Mista', ' ut volutpat sapien arcu sed augue..', 25.83, 26.86, 19.64);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (3, 'Mista', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.', 70.47, 4.43, 45.65);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (4, 'Externa', ' Etiam faucibus cursus urna. Ut tellus.  Nullam varius.', 81.34, 86.67, 97.09);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (5, 'Interna', '  turpis enim blandit mi, in porttitor pede justo eu massa.', 60.69, 32.25, 87.99);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (6, 'Mista', '  Integer ac leo. Pellentesque ultrices mattis odio.', 77.11, 64.44, 60.45);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (7, 'Externa', ' nibh ligula nec sem.', 68.75, 51.31, 38.62);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (8, 'Interna', 'erra dapibus. Nulla suscipit ligula in lacus.', 93.67, 2.44, 6.19);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (9, 'Interna', 'llis molestie lorem.', 67.42, 37.3, 85.53);

INSERT INTO Area (Codigo, Tipo, Descricao , Altura , Comprimento , Largura ) 
VALUES (10, 'Mista', 'Praesent blandit. Nam nulla.', 93.18, 91.7, 8.43);


INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(1, 'Festa', TO_DATE('05/11/2014', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Publico');

INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(2, 'Rodizio', TO_DATE('17/11/2014', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Privado');

INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(3, 'Festanca', TO_DATE('23/12/2014', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Privado');

INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(4, 'Reggae', TO_DATE('24/12/2014', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Public');

INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(5, 'Show', TO_DATE('14/11/2014', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Publico');

INSERT INTO Evento (Codigo,Descricao,Data_de_inicio,Data_de_fim,Privacidade)
VALUES(6, 'Festa', TO_DATE('05/01/2015', 'dd/mm/yyyy'),TO_DATE('05/11/2014', 'dd/mm/yyyy'),'Privado');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (4, 'Banda Polentinha do Arrocha', 'Axé', 'Música', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consectetur blandit arcu eget laoreet. Etiam auctor massa ac urna condimentum semper. ');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (1, 'Palhaço Chocolate', 'Brincadeiras', 'Humor', 'Vestibulum ut leo nec ex efficitur posuere. Vivamus sapien felis, ornare eu enim et, commodo maximus orci.');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (2, 'Victor e Leo', 'É festa de rodeio', 'Música', 'Vestibulum ut leo nec ex efficitur posuere. Vivamus sapien felis, ornare eu enim et, commodo maximus orci.');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (3, 'Marlon Marley', 'Como tocar cuíca', 'Workshop', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non lacus nibh. Morbi euismod sodales ligula auctor pretium.');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (6, 'DJ Samuel', 'Party EletroPetro', 'Música', 'Phasellus lacinia nibh et elit sollicitudin vehicula. Proin et nunc lobortis mauris tempus tincidunt. Sed dictum congue nunc, ac lobortis lacus sodales id.');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (1, 'Danilo Gentily', 'Eleições', 'Stand-Up', 'Fusce urna nibh, ultricies semper tellus eu, dignissim volutpat odio. Aenean aliquet, felis interdum semper consectetur, turpis tellus feugiat erat.');

INSERT INTO Atracao (Codigo_evento, Nome, Tema, Tipo, Descricao)
VALUES (1, 'Shevchenko e Elloco', 'Brega de cada dia', 'Música', 'Ultricies semper tellus eu, dignissim volutpat odio.');

INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-1', 1, 1);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-2', 2, 1);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-3', 3, 2);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-4', 4, 3);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-5', 5, 3);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-6', 6, 4);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-7', 7, 5);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-8', 8, 5);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-9', 9, 6);
INSERT INTO Aloca (Funcionario_CPF, Area_Codigo, Evento_Codigo) VALUES ('000.000.000-10', 10, 6);

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Calçados', 'in ante vestibulum ante ipsum primis in faucibus orci');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Vestidos', 'natoque penatibus et magnis dis parturient montes nascetur');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Eletrônicos', 'duis at velit eu est congue elementum');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Óculos de grau', 'urna pretium nisl ut volutpat sapien');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Televisões', 'hac habitasse platea dictumst morbi vestibulum');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Consolas', 'in hac habitasse platea dictumst etiam faucibus cursus urna ut');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Remédios', 'odio justo sollicitudin ut suscipit a feugiat');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Celulares', 'quisque porta volutpat erat quisque erat');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Cosméticos', 'metus vitae ipsum aliquam non mauris morbi non');

INSERT INTO Categoria (categoria, Categoria_Descricao) 
VALUES ('Esportivos', 'felis donec semper sapien a libero');

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('86.814.375/0001-00', 26540, 'Calçados', 12.40, 'in ante vestibulum ante ipsum primis in faucibus orci', SYSDATE);

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('83.824.371/0001-00', 21807, 'Vestidos', 29.57, 'natoque penatibus et magnis dis parturient montes nascetur', TO_DATE('09/07/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('33.824.141/0002-00', 21971, 'Eletrônicos', 33.65, 'duis at velit eu est congue elementum', TO_DATE('12/06/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('13.14.141/132-00', 89937, 'Óculos de grau', 21.48, 'urna pretium nisl ut volutpat sapien', SYSDATE);

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('13.11.111/112-00', 1234, 'Televisões', 47.72, 'hac habitasse platea dictumst morbi vestibulum', TO_DATE('01/04/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('23.13.131/112-12', 89316, 'Consolas', 62.39, 'in hac habitasse platea dictumst etiam faucibus cursus urna ut', SYSDATE);

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('23.11.121/132-11', 75305, 'Remédios', 15.68, 'odio justo sollicitudin ut suscipit a feugiat', TO_DATE('16/09/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('93.15.128/112-11', 39719, 'Celulares', 61.33, 'quisque porta volutpat erat quisque erat', TO_DATE('29/08/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('82.43.132/193-63', 89292, 'Cosméticos', 47.11, 'metus vitae ipsum aliquam non mauris morbi non', TO_DATE('13/09/2014', 'dd/mm/yyyy'));

INSERT INTO Promocao_Loja (Loja_CNPJ, Promocao_Codigo, categoria, Porcentagem, Descricao_Promocao, Data_inicio)
VALUES ('58.34.321/132-43', 43766, 'Esportivos', 29.57, 'felis donec semper sapien a libero', TO_DATE('05/09/2014', 'dd/mm/yyyy'));



INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (1, TO_DATE('05/11/2014', 'dd/mm/yyyy'), 1194.65, 'nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao)
VALUES (2, TO_DATE('06/12/2014', 'dd/mm/yyyy') , 608.6800000001, 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (3, TO_DATE('15/11/2014', 'dd/mm/yyyy'), 1812.11, 'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (4, TO_DATE('13/12/2014', 'dd/mm/yyyy'), 2444.23, 'mi nulla ac enim in tempor turpis nec euismod scelerisque');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (5, TO_DATE('01/01/2015', 'dd/mm/yyyy'), 900.91, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao)
VALUES (6, TO_DATE('05/01/2015', 'dd/mm/yyyy'), 538.33, 'amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (7, TO_DATE('17/12/2014', 'dd/mm/yyyy'), 962.74, 'quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (8, TO_DATE('20/11/2014', 'dd/mm/yyyy'), 9355.11, 'pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (9, TO_DATE('23/11/2014', 'dd/mm/yyyy'), 1512.81, 'posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in');

INSERT INTO Aluguel (Codigo, Data_de_vencimento, Valor, Descricao) 
VALUES (10, TO_DATE('24/10/2014', 'dd/mm/yyyy'), 1277.01, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque');


insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (10022334, SYSDATE , 'A vista', 1000.20);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (10034, SYSDATE, 'Boleto', 2953.70);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (1004, SYSDATE, 'Credito', 765.80);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (10, SYSDATE, 'Credito', 674.00);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (1002, SYSDATE, 'A vista', 235.50);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (4, SYSDATE, 'Boleto', 321.80);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (14, SYSDATE, 'Deposito', 500.90);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (124, SYSDATE, 'Credito', 150.10);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (10334, SYSDATE, 'A vista', 750.20);

insert into Pagamento (Codigo, Data_de_Pagamento, Tipo_de_pagamento, Valor)
values (9422334, SYSDATE, 'Deposito', 343.20);

INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (1, '86.814.375/0001-00', 10022334);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (2, '83.824.371/0001-00', 10034);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (3, '33.824.141/0002-00', 1004);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (4, '13.14.141/132-00', 10);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (5, '13.11.111/112-00', 1002);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (6, '23.13.131/112-12', 4);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (7, '23.11.121/132-11', 14);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (8, '93.15.128/112-11', 124);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (9, '82.43.132/193-63', 10334);
INSERT INTO Aluguel_Loja (Aluguel_Codigo, Loja_CNPJ, Pagamento_Codigo) VALUES (10, '58.34.321/132-43', 9422334);
