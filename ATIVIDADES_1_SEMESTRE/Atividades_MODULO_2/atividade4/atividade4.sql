CREATE DATABASE IF NOT EXISTS jotaFarm;
USE jotaFarm;

CREATE TABLE produtos(
idProduto INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
preco DECIMAL(10,2) NOT NULL,
marca VARCHAR(100) NOT NULL,
validade DATE NOT NULL
);

INSERT INTO produtos (nome, preco, marca, validade) VALUES
('Dipirona', 9.99, 'prati', '2027-1-22'),
('Paracetamol', 8.59, 'EMS', '2026-10-1'),
('Ibuprofeno', 7.99, 'CIMED', '2027-1-22'),
('Amoxilina', 27.99, 'prati', '2025-12-30');

SELECT * FROM produtos;

CREATE TABLE clientes(
idCliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(200) NOT NULL,
cpf VARCHAR(11) NOT NULL,
endereco VARCHAR(255) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO clientes (nome, cpf, endereco, email) VALUES
('Cleiton Rasta', '26589456158', 'Chaparral', 'cleitonrasta@gmail.com'),
('Froid', '12565478556', 'Asa Sul', 'froid@gmail.com'),
('Neymar Junior', '56245712344', 'Samambaia Sul', 'Neycraque@gmail.com'),
('Raphael Veiga', '77856245622', 'Park WAY', 'veigapalmeiras@gmail.com');

SELECT * FROM clientes;

CREATE TABLE pedidos(
idPedido INT AUTO_INCREMENT PRIMARY KEY,
id_Cliente INT NOT NULL,
dataPedido DATE NOT NULL,
valorPedido DECIMAL(10,2) NOT NULL DEFAULT 0.00,
FOREIGN KEY (id_Cliente) REFERENCES clientes (idCliente)
);

INSERT INTO pedidos(id_Cliente, dataPedido, valorPedido) VALUES
(1, '2025-05-25', 27.97),
(2, '2025-06-05', 117.91),
(3, '2025-01-10', 418.82),
(4, '2025-02-27', 104.70);

SELECT * FROM pedidos;

UPDATE produtos
SET preco = 12.99
WHERE idProduto = 3;

UPDATE produtos
SET validade = '2026-05-03'
WHERE idProduto = 4;

SELECT * FROM produtos;

SHOW TABLES;

SELECT c.nome, p.dataPedido, p.valorPedido
FROM clientes c
INNER JOIN pedidos p ON  c.idCliente = p.id_Cliente;

SELECT c.nome, p.dataPedido, p.valorPedido
FROM clientes c
LEFT JOIN pedidos p ON c.idCliente = p.id_cliente;

-- Funções de Agregação
SELECT COUNT(*) AS total_produtos FROM produtos;

SELECT SUM(valorPedido) AS total_vendido
FROM pedidos;

SELECT MAX(valorPedido) FROM pedidos;

SELECT MIN(valorPedido) FROM pedidos;

-- Funções Escalares

SELECT nome, LENGTH(nome) AS tamanho_nome
FROM produtos;

SELECT nome, LENGTH(nome) AS tamanho_nome
FROM clientes;

SELECT preco, ROUND(preco) AS tamanho_arredondado
FROM produtos;

-- Aqui criei uma trigger para arrumar o estoque, quando um produto é vendido ele é subtraido no estoque

ALTER TABLE produtos
ADD estoque INT NOT NULL DEFAULT 0;

UPDATE produtos 
SET estoque = 100 
WHERE idProduto = 1;

UPDATE produtos
SET estoque = 100
WHERE idProduto = 2;

UPDATE produtos
SET estoque = 100
WHERE idProduto = 3;

UPDATE produtos
SET estoque = 100
WHERE idProduto = 4;

SELECT * FROM produtos;

ALTER TABLE pedidos
ADD quantidade INT NOT NULL DEFAULT 1;

ALTER TABLE pedidos
ADD id_Produto INT NOT NULL; 

DELIMITER $$

CREATE TRIGGER atualizar_estoque
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
  UPDATE produtos
  SET estoque = estoque - NEW.quantidade
  WHERE idProduto = NEW.id_Produto;
END $$

DELIMITER ;

INSERT INTO pedidos(id_Cliente, id_Produto, dataPedido, valorPedido, quantidade) VALUES
(2, 1, '2025-06-14', 38.97, 3),
(4, 2, '2025-03-12', 39.95, 5),
(1, 3, '2025-01-01', 7.99, 1);







