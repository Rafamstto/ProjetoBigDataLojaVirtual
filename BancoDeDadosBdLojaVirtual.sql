-- Criar banco de dados para análise de Big Data
CREATE DATABASE bigdata_analysis;
USE bigdata_analysis;

-- Criar tabela de usuários
CREATE TABLE users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATETIME NOT NULL,
    country VARCHAR(50),
    age INT
);

-- Criar tabela de interações (log de atividades dos usuários)
CREATE TABLE user_interactions (
    interaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    interaction_type VARCHAR(50) NOT NULL,
    interaction_timestamp DATETIME NOT NULL,
    metadata JSON,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Criar tabela de produtos
CREATE TABLE products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(15, 2) NOT NULL,
    stock INT NOT NULL
);

-- Criar tabela de transações
CREATE TABLE transactions (
    transaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    transaction_date DATETIME NOT NULL,
    total_amount DECIMAL(15, 2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Criar tabela de detalhes de transações
CREATE TABLE transaction_details (
    detail_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    transaction_id BIGINT,
    product_id BIGINT,
    quantity INT NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Criar tabela de dados de navegação
CREATE TABLE web_sessions (
    session_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    session_start DATETIME NOT NULL,
    session_end DATETIME,
    pages_viewed INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Inserir dados fictícios em usuários
INSERT INTO users (name, email, join_date, country, age) VALUES
('Alice Johnson', 'alice.johnson@example.com', '2020-05-01 08:00:00', 'USA', 30),
('Bob Smith', 'bob.smith@example.com', '2021-06-15 10:30:00', 'Canada', 25),
('Carlos Diaz', 'carlos.diaz@example.com', '2019-11-20 14:45:00', 'Mexico', 35);

-- Inserir dados fictícios em produtos
INSERT INTO products (name, category, price, stock) VALUES
('Laptop', 'Electronics', 1500.00, 100),
('Smartphone', 'Electronics', 800.00, 200),
('Headphones', 'Accessories', 100.00, 500);

-- Inserir dados fictícios em transações
INSERT INTO transactions (user_id, transaction_date, total_amount, payment_method) VALUES
(1, '2023-12-01 09:00:00', 1600.00, 'Credit Card'),
(2, '2023-12-02 15:30:00', 900.00, 'PayPal');

-- Inserir dados fictícios em detalhes de transações
INSERT INTO transaction_details (transaction_id, product_id, quantity, price) VALUES
(1, 1, 1, 1500.00),
(1, 3, 1, 100.00),
(2, 2, 1, 800.00);

-- Inserir dados fictícios em interações dos usuários
INSERT INTO user_interactions (user_id, interaction_type, interaction_timestamp, metadata) VALUES
(1, 'Page View', '2023-12-01 08:50:00', '{"page": "home"}'),
(1, 'Add to Cart', '2023-12-01 08:55:00', '{"product_id": 1}'),
(2, 'Search', '2023-12-02 15:00:00', '{"query": "smartphone"}');

-- Inserir dados fictícios em sessões de navegação
INSERT INTO web_sessions (user_id, session_start, session_end, pages_viewed) VALUES
(1, '2023-12-01 08:45:00', '2023-12-01 09:05:00', 5),
(2, '2023-12-02 14:50:00', '2023-12-02 15:40:00', 8);
