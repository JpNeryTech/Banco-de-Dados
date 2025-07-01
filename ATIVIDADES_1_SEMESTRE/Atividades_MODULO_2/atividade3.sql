CREATE DATABASE IF NOT EXISTS funcaoTrigger;
USE funcaoTrigger;

CREATE TABLE produtos (
idproduto INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2)
);

INSERT INTO produtos (nome, preco) 
VALUES
('Bad Bunny', 799.99),
('Air Max 95', 999.99),
('Air Max Tn', 899.99);

SELECT * FROM produtos;

-- Contar quantos produtos existem
 SELECT COUNT(*) AS total_produtos FROM produtos; -- AS significa alias(apelido)
 
 -- SOMAR PREÇOS
  SELECT SUM(preco) AS valor_total FROM produtos;
  
  -- Media dos produtos
  SELECT AVG(preco) AS media_preco FROM produtos;
  
  -- Ver o produto mais caro  
  SELECT * FROM produtos -- Selecionar todos da tabela produtos
  ORDER BY preco DESC -- DESC descending(decescente) ele vai colocar o valor maior primeiro
  LIMIT 1; -- Apenas 1
  
  -- Ver o produto mais barato
  SELECT * FROM produtos
  ORDER BY preco ASC -- ASC ascending(crescente) ele vai colocar o valor menor em primeiro
  LIMIT 1;
  
  -- OUTRA MANEIRA DE FAZER ISSO
  
  SELECT MAX(preco) FROM produtos; -- Selecionar o máximo da coluna preco e da tabela produtos
  SELECT MIN(preco) FROM produtos; -- Selecionar o minimo da coluna preco e da tabela produtos
  
  -- Produtos acima de 900
  SELECT * FROM produtos -- Selecionar todos da tabela produtos 
  WHERE preco > 900; -- Onde o preço for maior que...]
  
  -- SEGUNDA PARTE DA ATIVIDADE
  
  CREATE TABLE log_produto (
  mensagem VARCHAR(255),
  data_log DATETIME       -- DATA E HORA QUE ACONTECEU
  );
  
  -- CRIANDO A TRIGGER(GATILHO)
  
DELIMITER $$ -- Troca o delimitador padrão (;) por $$ para evitar conflitos dentro do bloco BEGIN ... END

CREATE TRIGGER novo_Produto
AFTER INSERT ON produtos -- Vai executar depois quer criar um novo produto
FOR EACH ROW -- Executa a trigger para cada nova linha inserida
BEGIN
  INSERT INTO log_produto (mensagem, data_log)
  VALUES (
    CONCAT( -- juntar strings
      'Produto "', 
      IFNULL(NEW.nome, 'desconhecido'), 
      '" foi adicionado com preço R$ ', 
      FORMAT(IFNULL(NEW.preco, 0.00), 2)
    ),
    NOW() -- data e hora atual
  );
END$$ -- Fim da trigger, usando $$ como delimitador

DELIMITER ;   -- Volta o delimitador ao normal (;)
  
INSERT INTO produtos (nome, preco) 
VALUES ('Air Jordan', 959.99);
  
  SELECT * FROM log_produto;
  



