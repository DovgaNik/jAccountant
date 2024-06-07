DROP DATABASE IF EXISTS `invoice_app`;
CREATE DATABASE `invoice_app`;

CREATE TABLE `invoice_app`.`supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unique_code` varchar(45) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `unique_code_UNIQUE` (`unique_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`supplier` (`name`, `unique_code`, `address`, `phone`, `email`) VALUES 
('Altex', '1234567', 'Bucharest, Romania', '0211234567', 'contact@altex.ro'),
('Emag', '2345678', 'Bucharest, Romania', '0212345678', 'support@emag.ro'),
('Flanco', '3456789', 'Bucharest, Romania', '0213456789', 'info@flanco.ro');

CREATE TABLE `invoice_app`.`category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `category_name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`category` (`name`) VALUES 
('Electronics'),
('Home Appliances'),
('Furniture');

CREATE TABLE `invoice_app`.`product` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `product_name_UNIQUE` (`name`),
  KEY `category_id_idx` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`product` (`name`, `description`, `price`, `category_id`) VALUES 
('Alienware Laptop', 'High performance Alienware laptop with Intel i9, 32GB RAM, 1TB SSD', 3500.00, 1),
('iPhone 15', 'Latest iPhone 15 with 256GB storage, 5G, and A16 Bionic chip', 2500.00, 1),
('iPad Pro', 'Flagship iPad Pro with M1 chip, 128GB storage, and 11-inch display', 1500.00, 1);

CREATE TABLE `invoice_app`.`unit_of_measure` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `short` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `unit_name_UNIQUE` (`name`),
  UNIQUE KEY `unit_short_UNIQUE` (`short`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`unit_of_measure` (`name`, `short`) VALUES 
('Piece', 'pcs'),
('Kilogram', 'kg'),
('Liter', 'L');

CREATE TABLE `invoice_app`.`user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password_hash` char(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`user` (`username`, `password_hash`) VALUES 
('admin', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec'),
('user1', '7c6a180b36896a0a8c02787eeafb0e4c997b8a87c14d25d0f0c462c7b0a3c71a1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef');

CREATE TABLE `invoice_app`.`customer` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`customer` (`name`, `address`, `phone`, `email`) VALUES 
('John Doe', 'Cluj-Napoca, Romania', '0720123456', 'john.doe@example.com'),
('Jane Smith', 'Timisoara, Romania', '0730123456', 'jane.smith@example.com'),
('Alice Johnson', 'Constanta, Romania', '0740123456', 'alice.johnson@example.com');

CREATE TABLE `invoice_app`.`invoice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned NOT NULL,
  `date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `customer_id_idx` (`customer_id`),
  CONSTRAINT `fk_invoice_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`invoice` (`customer_id`, `date`, `total_amount`) VALUES 
(1, '2024-04-01', 5000.00),
(2, '2024-04-02', 7500.00),
(3, '2024-04-03', 3000.00);

CREATE TABLE `invoice_app`.`sale` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `supplier_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `caen` varchar(4) DEFAULT '0000',
  `quantity` decimal(10,0) NOT NULL,
  `unit_of_measure_id` int unsigned NOT NULL,
  `expenses` decimal(10,0) DEFAULT NULL,
  `revenue` decimal(10,0) DEFAULT NULL,
  `notes` int unsigned DEFAULT NULL,
  `deductible` decimal(10,0) unsigned DEFAULT NULL,
  `profit` decimal(10,0) unsigned DEFAULT NULL,
  `taxable` decimal(10,0) unsigned DEFAULT NULL,
  `tax` decimal(10,0) unsigned DEFAULT NULL,
  `invoice_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `supplier_id_idx` (`supplier_id`),
  KEY `product_id_idx` (`product_id`),
  KEY `unit_of_measure_id_idx` (`unit_of_measure_id`),
  KEY `invoice_id_idx` (`invoice_id`),
  CONSTRAINT `fk_sale_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `fk_sale_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_sale_unit_of_measure` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `fk_sale_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoice_app`.`sale` (
  `date`, `supplier_id`, `product_id`, `quantity`, `unit_of_measure_id`, `expenses`, `revenue`, `notes`, `deductible`, `profit`, `taxable`, `tax`, `invoice_id`
) VALUES 
('2024-01-01', 1, 1, 10, 1, 3000, 5000, NULL, 500, 2000, 4500, 500, 1),
('2024-02-01', 2, 2, 5, 1, 1500, 2500, NULL, 300, 1000, 2200, 300, 2),
('2024-03-01', 3, 3, 20, 1, 2000, 3000, NULL, 400, 1000, 2700, 400, 3);
