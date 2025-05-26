CREATE DATABASE nery_Tech;
use nery_Tech;

CREATE TABLE usuarios(
	idusuarios int auto_increment primary key,
    nome varchar(50) not null,
    email varchar(50) unique not null, -- UM USUÁRIO PODE TER SOMENTE UM EMAIL --
    data_cadastro date
);

CREATE TABLE categoria(
	idcategorias INT auto_increment primary key,
    nome varchar(100) not null
);

CREATE TABLE produto (
idprodutos int auto_increment primary key,
nome varchar(100) not null,
preco decimal (10,2) not null, -- 2 casas depois da virgola--
estoque int default 0,
id_categoria int,
FOREIGN KEY(id_categoria) REFERENCES categorias(idcategoria)

);
