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

-- 1) Lista os clientes cadastrasdos
select * from Cliente;

-- 2) Nomes dos produtos existentes
select nome from Produto;

-- 3) Lista dos produtos com preço superior a R$100
select preco from Produto where preco>100;

-- 4) Clientes cadastrados no sistema
select nome from Cliente;

-- 5) Exibe os clientes e os produtos cadastrados
select nome from Cliente union select nome from Produto;

-- 6) Exibe quantos clientes existem na empresa
select count(*) as Clientes from Cliente; 

-- 7) Exibe quantos produtos estão cadastrados no sistema
select count(*) as Produtos from Produto;

-- 8) Exibe quantos pedidos foram feitos em 2024
select count(data_venda) as Vendas_2024 from Venda where year(data_venda) = 2024;

-- 9) Valor total de vendas realizadas
select sum(total) from Venda;

-- 10) Valor total de vendas realizadas pelo funcionário de ID 5
select sum(total) as Vendas_func_ID_5 from Venda where vendedor_id = 5;

-- 11) Exibe quantos pedidos foram feitos pelo 'João Silva'
select count(cliente_id) from Venda where cliente_id = (select cliente_id from Cliente where nome = 'João Silva');

-- 12) Soma dos pedidos 'Vendas'
select sum(total) from Venda;

-- 13) Vendedores que ganham mais de R$3000
select count(*) from Vendedor where salario>3000;

-- 14) Produtos que custam mais de R$100
select count(*) from ItemVenda where preco_unitario>100;

-- 15) Soma dos valores do pedido feito pelo cliente 2
select sum(total) from Venda where cliente_id=2;