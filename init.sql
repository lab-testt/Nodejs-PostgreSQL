-- init.sql
CREATE TABLE IF NOT EXISTS persons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

INSERT INTO persons (name, age) VALUES 
('John Doe', 30),
('Jane Smith', 25),
('Alice Johnson', 22);

