CREATE DATABASE IF NOT EXISTS lojaDB;
USE lojaDB;

-- DROP DATABASE lojaDB;

CREATE TABLE clientes (
idcliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100)
);

INSERT INTO clientes(nome, email) VALUES
('Cleiton Rasta', 'cleitonbaiano@gmail.com'), -- id 1 --
('Luan Raio Laser', 'Luan@gmail.com' ), -- id 2 --
('Robson Cruzue', 'robsafera@gmail.com'); -- id 3 --

SELECT * FROM clientes;

CREATE TABLE pedidos(
idpedidos INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT,
data_pedido DATE,
valor_total DECIMAL(10,2),    -- tamanho dos tipos de dados --
FOREIGN KEY (id_cliente) REFERENCES clientes(idcliente)
);

INSERT INTO pedidos(id_cliente, data_pedido, valor_total) VALUES
(1, '2025-05-01', 2150.99),
(1,'2026-03-21', 10.99),
(3, '2022-03-30', 125.55);

SELECT * FROM pedidos;

-- INNER JOY -> RETORNAR REGISTROS QUE EXISTEM EM AMBAS TABELAS
-- SELECT -> DEFINIR QUAIS COLUNAS VÃO SER EXIBIDAS NO RESULTADO
-- C.nome -> ACESSAR A COLUNA NOME DA TABELA CLIENTE(APELIDO COM "c")
-- P.data_pedido e P.valor_total -> ACESSAR COLUNAS DA TABELA PEDIDO (APELIDO COM "p")
-- FROM -> CLIENTES C: DEFINE CLIENTES
-- ON -> COMANDO DE JUNÇÃO QUE COMPARA O ID DA TABELA X COM O ID DA TABELA Y --

SELECT c.nome, p.data_pedido, p.valor_total 
FROM clientes c
INNER JOIN pedidos p ON c.idcliente = p.id_cliente;

-- LEFT JOIN -> RETORNA TODOS OS CLIENTES, MESMO OS QUE NÃO TEM PEDIDOS OS VALORES DO PEDIDO APARECEM COMO NULL

SELECT c.nome, p.data_pedido, p.valor_total
FROM clientes c
LEFT JOIN pedidos p ON c.idclientes = p.id_cliente;

-- RIGHT/ FULL OUTHER JOIN ** PROXIMA AULA

-- SUM() -> SOMA OLS VALORES DE UMA COLUNA
-- GROUP BY -> AGRUPA OS REGISTROS PARA APLICAR FUNÇÕES

SELECT c.nome, SUM(p.valor_total) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.idcliente = p.id_cliente
GROUP BY c.nome;


