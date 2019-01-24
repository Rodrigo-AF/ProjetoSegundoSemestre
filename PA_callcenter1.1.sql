drop database callcenter;
  
create database callcenter;
  
use callcenter;
  
create table cargo(
id_cargo integer not null primary key,
nome_cargo ENUM('Administrador','Analista','Operador')
);
  
insert into cargo values(1,'Administrador');
insert into cargo values(2,'Analista');
insert into cargo values(3,'Operador');
  
create table login(
id_login integer not null auto_increment primary key,
login char(6) not null unique key,
senha char(6) not null
);
  
 create table produtividade(
 cod_colaborador_produtividade integer not null auto_increment primary key,
 produtividade int
 );
  
create table funcionario(
id_funcionario integer not null auto_increment primary key,
fk_cargo integer not null,
fk_login integer not null,
nome_completo varchar(50) not null,
cpf varchar(11) not null unique key,
produtividade int default 0,
constraint fk_cargo foreign key(fk_cargo) references cargo(id_cargo)ON DELETE CASCADE ON UPDATE CASCADE,
constraint fk_login foreign key(fk_login) references login(id_login)ON DELETE CASCADE ON UPDATE CASCADE
);
 
  
create table produto(     
 id_produto integer not null auto_increment primary key, 
 nome varchar(50) not null unique key, 
 descricao  varchar(150)  not  null,
 tipoProduto varchar (20) not null,
 fornecedor varchar (50) not null,
 qtd_reclamacoes int,
 fabricante varchar (50) not null
);
 
create table problema(
id_problema integer auto_increment,
fk_produto integer not null,
descricao varchar(50) not null,
solucao varchar(200),
constraint fk_produto foreign key(fk_produto) references produto(id_produto)ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PK_problema PRIMARY KEY (id_problema, fk_produto)
); 
  
create table cliente(
id_cliente integer not null auto_increment primary key,
cpf char(11) not null unique key,
nome varchar(50) not null,
endereco varchar(50) not null,
cep varchar(20) not null,
email varchar(50) not null,
tipocliente varchar(10) not null,
telefone varchar(20),
celular varchar(20)   
);
  
create table atendimento(      
 cod_protocolo integer not null auto_increment primary key,
 id_funcionario integer not null,  
 id_cliente integer not null,
 fk_produto integer not null,
 id_problema integer not null,
 dt_abertura varchar(10) not null,
 dt_fechamento varchar(10),
 astatus varchar(20) not null,
 prioridade varchar(20) not null,
 tempo varchar(20),
  
 constraint fk_funcionario foreign key(id_funcionario) references funcionario(id_funcionario)ON DELETE CASCADE ON UPDATE CASCADE,
 constraint fk_cliente foreign key(id_cliente) references cliente(id_cliente)ON DELETE CASCADE ON UPDATE CASCADE,
 constraint fk_produtos foreign key(fk_produto) references produto(id_produto)ON DELETE CASCADE ON UPDATE CASCADE,
 constraint fk_problema foreign key(id_problema) references problema(id_problema)ON DELETE CASCADE ON UPDATE CASCADE
 );
  
 INSERT INTO `callcenter`.`login` (`id_login`, `login`, `senha`) VALUES ('1', 'teste', 'teste');
 INSERT INTO `callcenter`.`login` (`id_login`, `login`, `senha`) VALUES ('2', 'testes', 'teste');
 INSERT INTO `callcenter`.`funcionario` (`id_funcionario`, `fk_cargo`, `fk_login`, `nome_completo`, `cpf`) VALUES ('1', '1', '1', 'leo', '159753');
 INSERT INTO `callcenter`.`funcionario` (`id_funcionario`, `fk_cargo`, `fk_login`, `nome_completo`, `cpf`) VALUES ('2', '2', '2', 'leo', '789');
  
INSERT INTO problema(fk_produto,descricao,solucao) VALUES(1,'SSSS','');

SELECT Qtd_reclamacoes, id_produto,nome from produto;
SELECT f.produtividade, f.nome_completo, c.nome_cargo, l.login from atendimento a inner join funcionario f on f.id_funcionario = a.id_funcionario inner join cargo c on f.fk_cargo = c.id_cargo inner join login l on l.id_login = f.fk_login where f.fk_cargo = 2;
SELECT f.produtividade, f.nome_completo, c.nome_cargo, l.login from atendimento a inner join funcionario f on f.id_funcionario = a.id_funcionario inner join cargo c on f.fk_cargo = c.id_cargo inner join login l on l.id_login = f.fk_login where f.fk_cargo = 3;
select id_cliente from atendimento;
select count(a.id_cliente),c.nome,c.tipocliente from atendimento a inner join cliente c on a.id_cliente = c.id_cliente where a.id_cliente = 1;
select * from problema;

select count(a.id_problema),c.descricao,c.solucao from atendimento a inner join problema c on a.id_problema = c.id_problema where a.id_problema = 2; 

