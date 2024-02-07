/* Relación tipo 1:1 */
-- PASO 1
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    age INTEGER
);

INSERT INTO users (name, last_name, email, age) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

-- PASO 2
CREATE TABLE roles (
    id_role SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

INSERT INTO roles (role_name) VALUES
('Bronze'),
('Silver'),
('Gold'),
('Platinum');

ALTER TABLE users MODIFY id_role INT NOT NULL;
ALTER TABLE users ADD FOREIGN KEY (id_role) REFERENCES roles(id_role);

-- PASO 3
ALTER TABLE users ADD COLUMN id_role INTEGER;

ALTER TABLE users MODIFY id_role INT NOT NULL;
ALTER TABLE roles MODIFY id_role INT NOT NULL;

ALTER TABLE users ADD FOREIGN KEY (id_role) REFERENCES roles(id_role);


-- PASO 4
SELECT users.user_id, users.name, users.last_name, users.email, users.age, roles.role_name
FROM users
JOIN roles ON users.id_role = roles.id_role;


/* Relación tipo 1:N */
-- PASO 1
CREATE TABLE categories (
id_category SERIAL PRIMARY KEY,
category_name VARCHAR(100) NOT NULL
);

INSERT INTO categories (category_name) VALUES
('Electronic'),
('Clothes and Accessories'),
('Books'), 
('Home and Kitchen'),
('Sports and Outdoors'),
('Health and Personal Care'),
('Tools and Home Improvement'),
('Toys and Games'),
('Automotive'),
('Music and Movies');


-- PASO 2
ALTER TABLE users ADD COLUMN id_category INT;


-- PASO 3
UPDATE users SET id_category = 1 WHERE user_id IN (1, 5, 9, 13, 17);


-- PASO 4
SELECT users.user_id, users.name, users.last_name, users.email, users.age, roles.role_name, categories.category_name
FROM users
JOIN roles ON users.id_role = roles.id_role
JOIN categories ON users.id_category = categories.id_category;


/* Relación tipo N:M */
-- PASO 1
CREATE TABLE users_categories (
    category_user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED,
    category_id INT UNSIGNED,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(id_category)
);


-- PASO 2
INSERT INTO users_categories ( user_id , category_id ) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);


-- PASO 3
SELECT users.user_id, users.name, users.last_name, users.email, users.age, roles.role_name, categories.category_name
FROM users
JOIN roles ON users.id_role = roles.id_role
JOIN users_categories ON users.user_id = users_categories.user_id
JOIN categories ON users_categories.category_id = categories.id_category;
