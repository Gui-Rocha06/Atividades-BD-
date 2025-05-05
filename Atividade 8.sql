create database escola;
use escola;
create table curso(
CodCurso char(3) primary key,
Nome varchar(20),
Mensalidade numeric(10, 2)
);

create table aluno(
RA char(9) primary key,
RG char(9) ,
Nome varchar(30),
CodCurso char(3),
foreign key(CodCurso) references curso(CodCurso)
);

create table disciplina(
CodDisc char(5) primary key,
Nome char(30),
CodCurso char(3),
foreign key(CodCurso) references aluno(CodCurso)
);

create table boletim(
RA char(9) not null,
CodDisc char(5) not null,
Nota decimal(5, 2),
primary key(RA, CodDisc),
foreign key(RA) references aluno(RA),
foreign key(CodDisc) references disciplina(CodDisc)
);
describe boletim;

insert into curso values
('AS', 'ANALISE DE SISTEMAS', 1000),
('CC', 'CIENCIA DA COMPUTACAO', 950),
('SI', 'SISTEMAS DE INFORMACAO', 800);

insert into aluno values
(123,'12345','BIANCA MARIA PEDROSA','AS'),
(212,'21234','TATIANE CITTON','AS'),
(221,'22145','ALEXANDRE PEDROSA ','CC'),
(231,'23144','ALEXANDRE MONTEIRO','CC'),
(321,'32111','MARCIA RIBEIRO ','CC'),
(661,'66123','JUSSARA MARANDOLA','SI'),
(765,'76512','WALTER RODRIGUES','SI');

insert into disciplina values
('BD','BANCO DE DADOS','CC'),
('BDA','BANCO DE DADOS AVANCADOS','CC'),
('BDOO','BANCO DE DADOS O OBJETOS','SI'),
('BDS','SISTEMAS DE BANCO DE DADOS','AS'),
('DBD','DESENVOLVIMENTO BANCO DE DADOS','SI'),
('IBD','INTRODUC AO A BANCO DE DADOS','AS');

describe disciplina;
insert into boletim values 
('123','BDS', 10),
('212','IBD', 7.5),
('231','BD', 9),
('231','BDA', 9.6),
('661','DBD',8),
('765','DBD',6);

-- Total de disciplinas
select * from disciplina;

-- Total de alunos
select count(*) from aluno;

-- Todas as disciplinas
select * from curso


