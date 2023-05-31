-- Create the database
CREATE DATABASE school_stage_project;

-- Switch to the newly created database
\c school_stage_project;

-- Create the addresses table
CREATE TABLE addresses (
  id SERIAL PRIMARY KEY,
  state varchar(50) NOT NULL,
  town varchar(25) NOT NULL,
  commune int NOT NULL,
  neighbourhood varchar(25) NOT NULL,
  street int NOT NULL,
  number varchar(20) NOT NULL,
  complement varchar(200) NOT NULL,
  postal_code int
);

-- Create the adr_list table
CREATE TABLE adr_list (
  id SERIAL PRIMARY KEY,
  id_adress int NOT NULL,
  id_user bigint NOT NULL
);

-- Create the designs table
CREATE TABLE designs (
  id SERIAL PRIMARY KEY,
  name varchar(106) NOT NULL,
  img varchar(106) NOT NULL,
  ai varchar(106) NOT NULL
);

-- Insert data into the designs table
INSERT INTO designs (id, name, img, ai) VALUES
(25, 'Amor el mundo tiene sus maravillas pero tú eres la maravilla de mi mundo', 'img/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.png', 'ai/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.ai'),
(26, '20 pero a que costo', 'img/20-pero-a-que-costo.png', 'ai/20-pero-a-que-costo.ai'),
(29, 'drink wine feel fine', 'img/drink-wine-feel-fine.png', 'ai/drink-wine-feel-fine.ai'),
(30, 'Juli como no te voy a querer si dices puras pendejadas igual que yo', 'img/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.png', 'ai/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.ai');

-- Create the packing_colors table
CREATE TABLE packing_colors (
  id SERIAL PRIMARY KEY,
  color varchar(25) NOT NULL
);

-- Insert data into the packing_colors table
INSERT INTO packing_colors (id, color) VALUES
(1, 'rojo');

-- Create the pucharse_orders table
CREATE TABLE pucharse_orders (
  id SERIAL PRIMARY KEY,
  id_wine int NOT NULL,
  id_design int DEFAULT NULL,
  id_real_design int NOT NULL,
  msg varchar(255) DEFAULT NULL,
  id_packing_color int NOT NULL,
  id_secondary_packing_color int NOT NULL,
  delivery_date date NOT NULL,
  id_delivery_place varchar(255) NOT NULL,
  id_user bigint NOT NULL,
  id_vaucher varchar(100) NOT NULL,
  amount int NOT NULL,
  paid boolean NOT NULL
);

-- Insert data into the pucharse_orders table
INSERT INTO pucharse_orders (id, id_wine, id_design, id_real_design, msg, id_packing_color, id_secondary_packing_color, delivery_date, id_delivery_place, id_user, id_vaucher, amount, paid) VALUES
(47, 6, 26, 0, 'fgsdfsdf', 1, 0, '2023-05-31', 'Some Delivery Place', 123456789, 'ABC123', 100, true);

-- Create the users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  password varchar(255) NOT NULL,
  phone bigint NOT NULL,
  active boolean NOT NULL
);

-- Insert data into the users table
INSERT INTO users (id, first_name, last_name, email, password, phone, active) VALUES
(123456789, 'John', 'Doe', 'johndoe@example.com', 'password123', 1234567890, true);
