CREATE DATABASE atlasToldos;

use atlasToldos;

CREATE TABLE clientes (
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone  VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE produto (
	idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(150) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantEstoque INT NOT NULL DEFAULT 0 CHECK (quantEstoque >= 0) -- Ultilizei o check para não ter numeros negativos --
);

CREATE TABLE pedido (
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT NOT NULL,
    dataPedido DATE NOT NULL,
    statusPedido VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    valorPedido DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    dataEntrega DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(idCliente)
);

CREATE TABLE itensPedido (
	idItemPedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL, 
    id_produto INT NOT NULL,
    quant INT NOT NULL CHECK (quant > 0), -- Mesma coisa não tem como fazer pedido negativo por isso o CHECK --
    totalReais DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (id_produto) REFERENCES produto(idProduto)
);

CREATE TABLE funcionario (
	idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
	dataContratacao DATE NOT NULL
);

CREATE TABLE producao (
	idProducao INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_funcionario INT NOT NULL,
    dataInicio DATE,
    dataConclusao DATE,
    statusProducao Varchar(20) NOT NULL DEFAULT 'Pendente',
    FOREIGN KEY (id_pedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE entregas (
	idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_funcionario INT NOT NULL,
    dataEntrega DATE,
    statusEntrega VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    FOREIGN KEY (id_pedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE estoque (	
	idmaterial INT AUTO_INCREMENT PRIMARY KEY,
    nomeMaterial VARCHAR(150) NOT NULL,
    quantidadeEstoque INT  NOT NULL DEFAULT 0 CHECK (quantidadeEstoque >= 0),
    unidadeMedida VARCHAR(10) NOT NULL,
    dataAtualizacao DATE NOT NULL
);

