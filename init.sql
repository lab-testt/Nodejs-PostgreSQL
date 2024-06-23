-- Create a database if needed (optional)
-- CREATE DATABASE mydatabase;

-- Connect to the desired database
\c mydatabase;

-- Create the persons table
CREATE TABLE IF NOT EXISTS persons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT
);

-- Insert sample data into persons table
INSERT INTO persons (name, age) VALUES
    ('Alice', 30),
    ('Bob', 25),
    ('Charlie', 28);

-- Create additional tables or perform other initialization as needed
-- CREATE TABLE IF NOT EXISTS other_table (
--     ...
-- );

-- Grant necessary privileges if required
-- GRANT ALL PRIVILEGES ON TABLE persons TO myuser;

-- Optionally, create indexes, constraints, or perform other setup tasks
-- CREATE INDEX IF NOT EXISTS idx_persons_name ON persons (name);

-- Example: Select data from persons table
SELECT * FROM persons;
