--PRIMEIRO BLOCO--

--EXCLUSÃO DO BANCO DE DADO, USUÁRIO E SCHEMA CASO EXISTEM--
DROP DATABASE IF EXISTS uvv
;
DROP USER IF EXISTS felipe
;
DROP SCHEMA IF EXISTS lojas
;

--CRIAÇÃO DO USUÁRIO E CONCENDENDO AS PERMISSÕES--
CREATE USER felipe WITH
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '1234'
;
--ENTRANDO COM O USUÁRIO felipe--
SET ROLE felipe
;

--CRIAÇÃO DO BANCO DE DADOS--
CREATE DATABASE uvv WITH
owner               =       'felipe'
template            =    'template0'
encoding            =         'UTF8'
lc_collate          =  'pt_BR.UTF-8'
lc_ctype            =  'pt_BR.UTF-8'
allow_connections   =          true
;

--CONECTANDO AO BANCO DE DADOS E ENTRANDO COM O USUÁRIO felipe--
\c uvv
SET ROLE felipe
;

COMMENT ON DATABASE uvv IS 'BANCO DE DADOS COM AS INFORMAÇÕES PRESENTES DO DIAGRAMA LOJAS UVV.'
;

--CRIAÇÃO DO SCHEMA--
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION felipe
;

--COMANDO PARA DEFINIR O SCHEMA lojas COMO PADRÃO--
ALTER USER felipe
;
SET SEARCH_PATH TO lojas, "$user", public
;

--FIM DO PRIMEIRO BLOCO--

--SEGUNDO BLOCO--

--CRIAÇÃO DA TABELA produtos-- 
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE produtos IS                            'Informações sobre os produtos das lojas';
COMMENT ON COLUMN produtos.produto_id IS                'Informação sobre os produtos das lojas';
COMMENT ON COLUMN produtos.nome IS                      'Informação sobre o nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS            'Informação sobre o preço do produto';
COMMENT ON COLUMN produtos.detalhes IS                  'Informação sobre os detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS                    'Imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS          'Informação sobre o mime type da imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS            'Informação sobre o arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS            'Informação sobre o charset da imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Informação sobre a última atualização da imagem';

--CRIAÇÃO DA TABELA lojas--
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE lojas IS                               'Informações sobre as lojas';
COMMENT ON COLUMN lojas.loja_id IS                      'Informação sobre o id das lojas';
COMMENT ON COLUMN lojas.nome IS                         'Informação sobre o nome das lojas';
COMMENT ON COLUMN lojas.endereco_web IS                 'Informação sobre os endereços das lojas';
COMMENT ON COLUMN lojas.endereco_fisico IS              'Informação sobre os endereços físico das lojas';
COMMENT ON COLUMN lojas.latitude IS                     'Informação sobre a latitude das lojas';
COMMENT ON COLUMN lojas.longitude IS                    'Informação sobre a longitude das lojas';
COMMENT ON COLUMN lojas.logo IS                         'Informação sobre a logo de cada loja';
COMMENT ON COLUMN lojas.logo_mime_type IS               'Informações sobre as logo mime type';
COMMENT ON COLUMN lojas.logo_arquivo IS                 'Informações sobre o arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset IS                 'Informações sobre o charset da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS      'Informações sobre a última atualização da logo';

--CRIAÇÃO DA TABELA estoques--
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE estoques IS                            'Informações sobre os estoques das lojas';
COMMENT ON COLUMN estoques.estoque_id IS                'Informação sobre o estoque';
COMMENT ON COLUMN estoques.loja_id IS                   'Informações sobre os estoques das lojas';
COMMENT ON COLUMN estoques.produto_id IS                'Informações sobre os produtos no estoque';
COMMENT ON COLUMN estoques.quantidade IS                'Informação sobre a quantidade de um produto no estoque';

--CRIAÇÃO DA TABELA clientes--
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE clientes IS                            'Informação sobre os dados do cliente';
COMMENT ON COLUMN clientes.cliente_id IS                'Informação sobre o id do cliente';
COMMENT ON COLUMN clientes.email IS                     'Informação sobre o email do cliente';
COMMENT ON COLUMN clientes.nome IS                      'Informação sobre o nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS                 'Primeiro telefone para contato';
COMMENT ON COLUMN clientes.telefone2 IS                 'Segundo telefone para contato';
COMMENT ON COLUMN clientes.telefone3 IS                 'Terceiro telefone para contato';

--CRIAÇÃO DA TABELA pedidos--
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE pedidos IS                             'Informações sobres os pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS                  'Informações sobre os pedidos realizados na loja';
COMMENT ON COLUMN pedidos.data_hora IS                  'Informações sobre a data do pedido realizado';
COMMENT ON COLUMN pedidos.cliente_id IS                 'Informação sobre o id do cliente';
COMMENT ON COLUMN pedidos.status IS                     'Informação sobre o status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS                    'Informação sobre o id das lojas';

--CRIAÇÃO DA TABELA envios--
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE envios IS                              'informações sobre os envios realizados';
COMMENT ON COLUMN envios.envio_id IS                    'Informação sobre o id de envio';
COMMENT ON COLUMN envios.loja_id IS                     'Informação sobre o id das lojas';
COMMENT ON COLUMN envios.cliente_id IS                  'Informação sobre o id do cliente';
COMMENT ON COLUMN envios.endereco_entrega IS            'Informação sobre o endereço de entrega';
COMMENT ON COLUMN envios.status IS                      'Informação sobre o status do envio';

--CRIAÇÃO DA TABELA pedidos_itens--
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
--COMENTANDO A TABELA E AS COLUNAS PRESENTES--
COMMENT ON TABLE pedidos_itens IS                       'Informações sobre os itens pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS            'Informações sobre os pedidos realizados na loja';
COMMENT ON COLUMN pedidos_itens.produto_id IS           'Informação sobre os produtos das lojas';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS      'Informação sobre o número da linha do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS       'Informação sobre o preço unitário dos pedidos';
COMMENT ON COLUMN pedidos_itens.quantidade IS           'Informação sobre a quantidade de pedidos';
COMMENT ON COLUMN pedidos_itens.envio_id IS             'Informação sobre o id de envio';

--CRIAÇÃO DE UM RELACIONAMENTO IDENTIFICADO ENTRE A TABELA pedidos_itens e produtos--
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA estoques e produtos--
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA pedidos e lojas--
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA envios e lojas--
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA estoques e lojas--
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA envios e clientes--
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA pedidos e clientes--
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO IDENTIFICADO ENTRE A TABELA pedidos_itens e pedidos--
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DE UM RELACIONAMENTO NÃO IDENTIFICADO ENTRE A TABELA pedidos_itens e envios--
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--CRIAÇÃO DAS RESTRIÇÕES--

--CRIAÇÃO DAS RESTRIÇÕES DE CHECAGEM NA TABELA pedidos--
ALTER TABLE pedidos ADD CONSTRAINT cc_pedidos_status CHECK (status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

--CRIAÇÃO DAS RESTRIÇÕES DE CHECAGEM NA TABELA envios--
ALTER TABLE envios ADD CONSTRAINT cc_envios_status CHECK (status IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));

--CRIAÇÃO DAS RESTRIÇÕES DE CHECAGEM NA TABELA lojas--
ALTER TABLE lojas ADD CONSTRAINT cc_lojas_endereco_fisico_endereco_web CHECK ( (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL));

--CRIAÇÃO DAS RESTRIÇÕES DE CHECAGEM NA TABELA estoques--
ALTER TABLE estoques ADD CONSTRAINT cc_estoques_quantidade CHECK ( ( quantidade >= 0));

--CRIAÇÃO DAS RESTRIÇÕES DE CHECAGEM NA TABELA pedidos_itens--
ALTER TABLE pedidos_itens ADD CONSTRAINT cc_pedidos_itens_quantidade CHECK (( quantidade >= 0))


--FIM DO SEGUNDO BLOCO--
