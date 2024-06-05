create database Teste;

create table tbCliente(codigo int not null auto_increment, 
                       nome varchar(200) not null, 
                       cidade varchar(50) not null, 
                       uf char(2) not null,
                       constraint pk_cliente primary key(codigo));

CREATE INDEX idx_tbCliente_nome ON tbCliente (nome);                      
                       
create table tbProduto(codigo int not null auto_increment,
                       descricao varchar(300) not null,
                       preco_venda float,
                       constraint pk_produto primary key(codigo));
                      
CREATE INDEX idx_tbProduto_descricao ON tbProduto (descricao);   
                       r
create table tbPedido(numero_pedido int not null auto_increment,
                      data_emissao date not null,
                      codigo_cliente int not null,
                      valor_total float,
                      constraint pk_pedido primary key(numero_pedido),
                      constraint fk_pedido_cliente foreign key(codigo_cliente) references tbCliente(codigo));
                     
CREATE INDEX idx_tbPedido_codigo_cliente ON tbPedido (codigo_cliente);  
CREATE INDEX idx_tbPedido_codigo_data_emissao ON tbPedido (data_emissao); 
                      
create table tbPedidoProduto(codigoitem int not null,
                             numero_pedido int not null,
                             codigo_produto int not null,
                             quantidade float not null,
                             valor_unitario float not null,
                             valor_total float not null,
                             constraint pk_pedidoproduto primary key(codigoitem),
                             constraint fk_pedidoproduto_pedido foreign key(numero_pedido) references tbPedido(numero_pedido),
                             constraint fk_pedidoproduto_produto foreign key(codigo_produto) references tbProduto(codigo));

CREATE INDEX idx_tbPedidoProduto_numero_pedido ON tbPedidoProduto (numero_pedido); 
CREATE INDEX idx_tbPedidoProduto_codigo_produto ON tbPedidoProduto (codigo_produto); 

INSERT INTO tbCliente (nome,cidade,uf) VALUES
	 (N'Marcos',N'Cuiabá',N'MT'),
	 (N'Erica',N'Cuiabá',N'MT'),
	 (N'Maria',N'Cuiabá',N'MT'),
	 (N'Mariana',N'Cuiabá',N'MT'),
	 (N'Paulo',N'Tangará',N'MT'),
	 (N'Sandro',N'Sinop',N'MT'),
	 (N'Terra',N'Sorriso',N'MT'),
	 (N'Cleber',N'São Paulo',N'SP'),
	 (N'Artur',N'Olimpia',N'SP'),
	 (N'Rogério',N'Cuiabá',N'MT');
INSERT INTO tbCliente (nome,cidade,uf) VALUES
	 (N'Nascimento',N'Cuiabá',N'MT'),
	 (N'João',N'Jaciara',N'MT'),
	 (N'Gustavo',N'Cuiabá',N'MT'),
	 (N'Ger',N'Cuiabá',N'MT'),
	 (N'Teria',N'Cuiabá',N'MT'),
	 (N'Polo',N'Cuiabá',N'MT'),
	 (N'Flávio',N'Cuiabá',N'MT'),
	 (N'Eduardo',N'Cuiabá',N'MT'),
	 (N'Bugr',N'Cuiabá',N'MT'),
	 (N'Marcio',N'Cuiabá',N'MT');

	
INSERT INTO tbProduto (descricao,preco_venda) VALUES
	 (N'Lápis',1.0),
	 (N'Caderno',1.34),
	 (N'Notebook',2.0),
	 (N'Régua',3.0),
	 (N'Mochila',4.3),
	 (N'Mochila para Notebook',5.67),
	 (N'Tenis',5.0),
	 (N'Borracha',6.0),
	 (N'Lapiseira',200.0),
	 (N'Lapis de Cor',345.0);
INSERT INTO tbProduto (descricao,preco_venda) VALUES
	 (N'Papel A4',1000.0),
	 (N'Papel Cartão',1056.0),
	 (N'Papel Selofane',135.0),
	 (N'Caneta',23.0),
	 (N'Cartolina',34.0),
	 (N'Ventilador',56.0),
	 (N'Cooler',66.0),
	 (N'Pen drive',77.0),
	 (N'Isopor',88.01),
	 (N'Esquadro',9.0);
	
                             
                            