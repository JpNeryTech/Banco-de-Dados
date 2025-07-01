CREATE DATABASE IF NOT EXISTS luxuryMotorCars;
USE luxuryMotorCars;

CREATE TABLE carros(
idCarro INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
ano INT NOT NULL,
marca varchar(100) NOT NULL
);

INSERT INTO carros (nome, ano, marca)
VALUES
('Bmw M4 Competition', 2023, 'BMW'),
('Gtr R35 Nismo', 2022, 'Nissan');

SELECT * FROM carros;

CREATE TABLE cliente(
idCliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) NOT NULL,
endereco VARCHAR(255) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO cliente (nome, cpf, endereco, email)
VALUES
('Cleiton Rhasta Junior', '09856989158', 'Ceilândia Centro', 'Cleitonrhasta@gmail.com'),
('Neymar da Silva Santos', '45998756982', 'Ceilândia Norte', 'Neyfera@gmail.com');

INSERT INTO cliente (nome, cpf, endereco, email)
VALUES
('Veiga Carneiro Cruz', '45996212365', 'Ceilândia Sul', 'Veigacraque@gmail.com');

INSERT INTO cliente (nome, cpf, endereco, email)
VALUES
('Endrick', '85996231556', 'P norte', 'Endrick@gmail.com');


SELECT * FROM cliente;

CREATE TABLE pedido(
idPedido INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
id_Cliente INT NOT NULL,
dataPedido DATE NOT NULL,
statusPedido VARCHAR(20) NOT NULL DEFAULT 'Pendente',
valorPedido DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
dataEntrega DATE,
FOREIGN KEY (id_Cliente) REFERENCES cliente(idCliente)
);

ALTER TABLE pedido MODIFY valorPedido DECIMAL(10,2); -- Modificando tabela

INSERT INTO pedido (id_cliente, dataPedido, statusPedido, valorPedido, dataEntrega)
VALUES
(1, '2025-03-30', 'Confirmado', 1200000.00, '2025-05-20'),
(2, '2025-05-7', 'Confirmado', 1000000.00, '2025-07-18');

INSERT INTO pedido (id_cliente, dataPedido, statusPedido, valorPedido, dataEntrega)
VALUES
(3, '2025-01-17', 'Confirmado', 1999000.00, '2025-02-8');

SELECT * FROM pedido;

SHOW TABLES;

SELECT c.nome, p.dataPedido, p.valorPedido -- INNER JOY ele serve para retornar os registros que existem nas duas tabelas(somente clientes que fizeram pedidos)
FROM cliente c
INNER JOIN pedido p ON c.idcliente = p.id_cliente;

-- Me mostra tudo da tabela da esquerda, mesmo que não tenha correspondência na direita.(não tenha feito pedido)" 
SELECT c.nome, p.dataPedido, p.valorPedido -- LEFT JOIN retorna todos os clientes, ate os que não tem pedidos e os valores do pedido aparece como null
FROM cliente c
LEFT JOIN pedido p ON c.idCliente = p.id_Cliente;

-- GROUP BY cria grupos de linhas que tem valores iguais, nele existe varias funções 

SELECT c.nome, COUNT(p.idPedido) AS valorPedido --  COUNT: conta quantos pedidos cada um fez
from cliente c 
LEFT JOIN pedido p ON c.idCliente = p.id_Cliente -- para todos os clientes aparecerem mesmo os que não fizeram pedidos
GROUP BY c.nome; -- agrupa por nome do cliente

SELECT c.nome, SUM(p.valorPedido) AS total_Gasto -- SUM: vai somar tudo que o cliente gastou
FROM cliente c
INNER JOIN pedido p ON c.idCliente = p.id_Cliente -- vai juntar os dados da tabela pedido com cliente porem so aonde o idCliente for igual o id_cliente ou seja mesma pessoa
GROUP BY c.nome; -- Serve para agrupar pelo nome do cliente

SELECT c.nome, AVG(p.valorPedido) AS media_pedidos -- AVG: vai dar a media de  quanto o cliente gastou/ AS:ccriar um apelido para a nova tabela criada "media_pedidos"
FROM cliente c
INNER JOIN pedido p ON c.idCliente = p.id_Cliente
GROUP BY c.nome;

-- HAVING Filtrar depois do agrupamento

SELECT c.nome, SUM(p.valorPedido) AS total_Gasto
FROM cliente c -- tabela cliente como principal
JOIN pedido p ON c.idCliente = p.id_Cliente -- A tabela pedido = p vai conectar onde(ON)  o idCliente = p.id_Cliente(mesma pessoa)
GROUP BY c.nome -- Aqui é onde agrupa os resultados pelo nome do cliente
HAVING total_Gasto > 1500000; 

UPDATE pedido -- Atualize os dados da tabela ...
SET statusPedido = 'Entregue' -- SET = "DEFINIR"
WHERE idPedido = 2; -- Onde o idPedido = 2

SELECT * FROM cliente WHERE idCliente = 1;

UPDATE cliente 
SET endereco = 'Chaparral'
WHERE idCliente = 1;

DELETE FROM pedido -- Deletar da tabela pedido
WHERE idPedido = 6; -- Onde o idPedido for igual a 6