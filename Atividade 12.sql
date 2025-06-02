create table estoque (
id int primary key auto_increment,
produto varchar(100),
quantidade int,
id_fornecedor int,
foreign key (id_fornecedor) references fornecedores(id)
);

create table pedidos (
id int primary key auto_increment,
produto varchar(100),
quantidade int,
id_cliente int,
status_pedido varchar(50) default 'Pendente',
data_pedido timestamp default current_timestamp,
foreign key(id_cliente) references clientes(id)
);

create table fornecedores (
id int primary key auto_increment,
nome varchar(100),
contato varchar(100)
);

create table clientes (
id int primary key auto_increment,
nome varchar(100),
email varchar(100)
);

create table historico_pedidos (
id int primary key auto_increment,
produto varchar(100),
quantidade int,
id_cliente int,
status varchar(50),
data_pedido timestamp,
foreign key(id_cliente) references clientes(id)
);

-- Trigger para atualizar o estoque ao fazer um pedido
delimiter $$
create trigger atualizar_estoque_apos_pedido
after insert on pedidos
for each row
begin
  update estoque
  set quantidade = quantidade - new.quantidade
  where produto = new.produto;

  insert into historico_pedidos (produto, quantidade, id_cliente, status_pedido, data_pedido)
  values (new.produto, new.quantidade, new.id_cliente, new.status_pedido, new.data_pedido);
end $$

delimiter ;

-- Trigger para status
delimiter $$
create trigger registrar_alteracao_status
after update on pedidos
for each row
begin
  insert into historico_pedidos (produto, quantidade, id_cliente, status_pedido, data_pedido)
  values (new.produto, new.quantidade, new.id_cliente, new.status_pedido, new.data_pedido);
end $$

delimiter ;

-- View de status
create view view_pedidos_status as
select 
  p.id as pedido_id,
  c.nome as cliente,
  p.produto,
  p.quantidade,
  p.status_pedido,
  p.data_pedido
from pedidos p
join clientes c on p.id_cliente = c.id;

