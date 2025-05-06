create database gestao_vendas;
use gestao_vendas;
CREATE TABLE Cliente (
cliente_id INT PRIMARY KEY,
nome VARCHAR(100),
cpf CHAR(11),
email VARCHAR(100),
telefone VARCHAR(15)
);
CREATE TABLE Produto (
produto_id INT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);
CREATE TABLE Vendedor (
vendedor_id INT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100),
salario DECIMAL(10,2)
);
CREATE TABLE Venda (
venda_id INT PRIMARY KEY,
cliente_id INT,
vendedor_id INT,
data_venda DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES
Cliente(cliente_id),
FOREIGN KEY (vendedor_id) REFERENCES
Vendedor(vendedor_id)
);
CREATE TABLE ItemVenda (
item_id INT PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade INT,
preco_unitario DECIMAL(10,2),
FOREIGN KEY (venda_id) REFERENCES
Venda(venda_id),
FOREIGN KEY (produto_id) REFERENCES
Produto(produto_id)
);

insert into Cliente values
(1, 'João Silva', '12345678901', 'joao.silva@email.com', '41999990001'),
(2, 'Alice Miranda', '23456789012', 'alice.miranda@email.com', '21988887722'),
(3, 'Bianca Caroline', '34567890123', 'bianca.caroline@email.com', '19977776633'),
(4, 'Josefina Rocha', '45678901234', 'Josefina.rocha@email.com', '21966665544'),
(5, 'Matheus Xavier', '56789012345', 'matheus.xavier@email.com', '19955554433');

insert into Produto values
(1, 'Mouse Sem Fio', 59.90, 50),
(2, 'Teclado Mecânico', 179.90, 30),
(3, 'Monitor 24 Polegadas', 749.00, 20),
(4, 'Headset Gamer', 99.99, 25),
(5, 'Webcam Full HD', 78.50, 15),
(6, 'Cadeira Gamer', 854.00, 10),
(7, 'Notebook i5', 2899.00, 8);

insert into Vendedor values
(1, 'Helena Pondian', 'helena.pondian@loja.com', 3200.00),
(2, 'Vânia Rocha', 'vania.rocha@loja.com', 3100.00),
(3, 'Gabriel Alves', 'gabriel.alves@loja.com', 3300.00),
(4, 'Bruno Barreto', 'bruno.barreto@loja.com', 2950.00),
(5, 'Arlete Avelar', 'arlete.avelar@loja.com', 3800.00);

insert into Venda values
(1, 2, 5, '2024-06-06', 78.50 + 99.99),   
(2, 4, 3, '2024-12-25', 2899.00 + 78.50), 
(3, 1, 2, '2025-01-01', 854.00), 
(4, 5, 4, '2025-04-06', 179.90),         
(5, 3, 1, '2025-04-13', 749.00 + 59.90);  

insert into ItemVenda values
(1, 1, 5, 1, 78.50),      
(2, 1, 4, 1, 99.99),   
(3, 2, 7, 1, 2899.00),      
(4, 2, 5, 1, 78.50),       
(5, 3, 6, 1, 854.00),     
(6, 4, 2, 1, 179.90);     

-- 1) Procedure que lista todos os funcionários
delimiter $$
create procedure listaFunc()
begin
	select * from Vendedor;
end $$
delimiter ;

call listaFunc()

-- 2) Função que calcula salário anual
delimiter $$

create function calculoSalarioAnual(id INT)
returns decimal(10,2)
reads sql data
deterministic
begin
   declare calculo_anual decimal(10,2);
   set calculo_anual = (
   select (salario * 12) from vendedor 
   where vendedor_id = id);
   return calculo_anual;
   
end $$

delimiter ;
select calculoSalarioAnual(1) as Salario_Anual;  
select calculoSalarioAnual(2) as Salario_Anual; 

-- 3) Procedure que insere dados
delimiter $$
create procedure inserirCliente (
	in id INT,
	in nome VARCHAR(100),
	in cpf CHAR(11),
	in email VARCHAR(100),
	in tel VARCHAR(15)
    )
    begin
    insert into Cliente (cliente_id, nome, cpf, email, telefone)
    values (id, nome, cpf, email, tel);
end $$

delimiter ;

call inserirCliente(6, 'João Vitor', '26533079801', 'joao.vitor@gmail.com', '19946533123');

-- 4) View da lista de funcionário e salário
create view view_funcionario as 
select nome, salario
from Vendedor;