DROP DATABASE IF EXISTS `invoice_app`;
CREATE DATABASE `invoice_app`;

-- Table for Countries
CREATE TABLE `invoice_app`.`Countries` (
  `codeOfCountry` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`codeOfCountry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Address Types
CREATE TABLE `invoice_app`.`AddressType` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for ATU Types
CREATE TABLE `invoice_app`.`ATUType` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Administrative Territorial Units (ATU)
CREATE TABLE `invoice_app`.`ATU` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code_of_country` varchar(10) NOT NULL,
  `atu_type_id` int unsigned NOT NULL,
  `residence` varchar(255) DEFAULT NULL,
  `auto_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ATU_Country_idx` (`code_of_country`),
  KEY `fk_ATU_ATUType_idx` (`atu_type_id`),
  CONSTRAINT `fk_ATU_Country` FOREIGN KEY (`code_of_country`) REFERENCES `Countries` (`codeOfCountry`) ON DELETE CASCADE,
  CONSTRAINT `fk_ATU_ATUType` FOREIGN KEY (`atu_type_id`) REFERENCES `ATUType` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Cities
CREATE TABLE `invoice_app`.`Cities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `atu_id` int unsigned NOT NULL,
  `population` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Cities_ATU_idx` (`atu_id`),
  CONSTRAINT `fk_Cities_ATU` FOREIGN KEY (`atu_id`) REFERENCES `ATU` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Addresses
CREATE TABLE `invoice_app`.`Addresses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `city_id` int unsigned NOT NULL,
  `sector` varchar(100) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `block` varchar(10) DEFAULT NULL,
  `entrance` varchar(10) DEFAULT NULL,
  `floor` varchar(10) DEFAULT NULL,
  `apartment` varchar(10) DEFAULT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Addresses_City_idx` (`city_id`),
  KEY `fk_Addresses_AddressType_idx` (`type_id`),
  CONSTRAINT `fk_Addresses_City` FOREIGN KEY (`city_id`) REFERENCES `Cities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Addresses_AddressType` FOREIGN KEY (`type_id`) REFERENCES `AddressType` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Types of Contacts
CREATE TABLE `invoice_app`.`TypeOfContact` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Genders
CREATE TABLE `invoice_app`.`Gender` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Types of Person
CREATE TABLE `invoice_app`.`Types_of_Person` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person
CREATE TABLE `invoice_app`.`Person` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address_id` int unsigned DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Address_idx` (`address_id`),
  KEY `fk_Person_Gender_idx` (`gender_id`),
  KEY `fk_Person_Type_idx` (`type_id`),
  CONSTRAINT `fk_Person_Address` FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`id`),
  CONSTRAINT `fk_Person_Gender` FOREIGN KEY (`gender_id`) REFERENCES `Gender` (`id`),
  CONSTRAINT `fk_Person_Type` FOREIGN KEY (`type_id`) REFERENCES `Types_of_Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person Types
CREATE TABLE `invoice_app`.`Person_Type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Type_Person_idx` (`person_id`),
  KEY `fk_Person_Type_Types_of_Person_idx` (`type_id`),
  CONSTRAINT `fk_Person_Type_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Person_Type_Types_of_Person` FOREIGN KEY (`type_id`) REFERENCES `Types_of_Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Roles
CREATE TABLE `invoice_app`.`Roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Users
CREATE TABLE `invoice_app`.`Users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password_hash` char(128) NOT NULL,
  `person_id` int unsigned DEFAULT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `fk_Users_Person_idx` (`person_id`),
  KEY `fk_Users_Role_idx` (`role_id`),
  CONSTRAINT `fk_Users_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Users_Role` FOREIGN KEY (`role_id`) REFERENCES `Roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier
CREATE TABLE `invoice_app`.`Supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unique_code` varchar(45) NOT NULL,
  `address_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code_UNIQUE` (`unique_code`),
  KEY `fk_Supplier_Address_idx` (`address_id`),
  CONSTRAINT `fk_Supplier_Address` FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Contacts
CREATE TABLE `invoice_app`.`Supplier_Contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `contact_type_id` int unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Supplier_Contacts_Supplier_idx` (`supplier_id`),
  KEY `fk_Supplier_Contacts_TypeOfContact_idx` (`contact_type_id`),
  CONSTRAINT `fk_Supplier_Contacts_Supplier` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`id`),
  CONSTRAINT `fk_Supplier_Contacts_TypeOfContact` FOREIGN KEY (`contact_type_id`) REFERENCES `TypeOfContact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person Contacts
CREATE TABLE `invoice_app`.`Person_Contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `contact_type_id` int unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Contacts_Person_idx` (`person_id`),
  KEY `fk_Person_Contacts_TypeOfContact_idx` (`contact_type_id`),
  CONSTRAINT `fk_Person_Contacts_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Person_Contacts_TypeOfContact` FOREIGN KEY (`contact_type_id`) REFERENCES `TypeOfContact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Categories
CREATE TABLE `invoice_app`.`Category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Products
CREATE TABLE `invoice_app`.`Products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Products_Category_idx` (`category_id`),
  CONSTRAINT `fk_Products_Category` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Unit of Measure
CREATE TABLE `invoice_app`.`Unit_of_measure` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Invoices
CREATE TABLE `invoice_app`.`SupplierInvoice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `invoice_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SupplierInvoice_Supplier_idx` (`supplier_id`),
  CONSTRAINT `fk_SupplierInvoice_Supplier` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Customer Invoices
CREATE TABLE `invoice_app`.`CustomerInvoice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `invoice_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CustomerInvoice_Person_idx` (`person_id`),
  CONSTRAINT `fk_CustomerInvoice_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Product Inventory
CREATE TABLE `invoice_app`.`ProductInventory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ProductInventory_Product_idx` (`product_id`),
  CONSTRAINT `fk_ProductInventory_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Customer Transactions
CREATE TABLE `invoice_app`.`Customer_Transaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_date` datetime NOT NULL,
  `product_id` int unsigned NOT NULL,
  `caen` varchar(20) NOT NULL,
  `quantity` decimal NOT NULL,
  `unit_of_measure_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `deductible` decimal DEFAULT NULL,
  `taxable` decimal DEFAULT NULL,
  `invoice_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Customer_Transaction_Product_idx` (`product_id`),
  KEY `fk_Customer_Transaction_Unit_of_measure_idx` (`unit_of_measure_id`),
  KEY `fk_Customer_Transaction_CustomerInvoice_idx` (`invoice_id`),
  CONSTRAINT `fk_Customer_Transaction_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`),
  CONSTRAINT `fk_Customer_Transaction_Unit_of_measure` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `Unit_of_measure` (`id`),
  CONSTRAINT `fk_Customer_Transaction_CustomerInvoice` FOREIGN KEY (`invoice_id`) REFERENCES `CustomerInvoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Transactions
CREATE TABLE `invoice_app`.`Supplier_Transaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_date` datetime NOT NULL,
  `product_id` int unsigned NOT NULL,
  `caen` varchar(20) NOT NULL,
  `quantity` int NOT NULL,
  `unit_of_measure_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `deductible` tinyint DEFAULT NULL,
  `taxable` tinyint DEFAULT NULL,
  `invoice_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Supplier_Transaction_Product_idx` (`product_id`),
  KEY `fk_Supplier_Transaction_Unit_of_measure_idx` (`unit_of_measure_id`),
  KEY `fk_Supplier_Transaction_SupplierInvoice_idx` (`invoice_id`),
  CONSTRAINT `fk_Supplier_Transaction_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`),
  CONSTRAINT `fk_Supplier_Transaction_Unit_of_measure` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `Unit_of_measure` (`id`),
  CONSTRAINT `fk_Supplier_Transaction_SupplierInvoice` FOREIGN KEY (`invoice_id`) REFERENCES `SupplierInvoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP DATABASE IF EXISTS `invoice_app`;
CREATE DATABASE `invoice_app`;

-- Table for Countries
CREATE TABLE `invoice_app`.`Countries` (
  `codeOfCountry` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`codeOfCountry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Address Types
CREATE TABLE `invoice_app`.`AddressType` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for ATU Types
CREATE TABLE `invoice_app`.`ATUType` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Administrative Territorial Units (ATU)
CREATE TABLE `invoice_app`.`ATU` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code_of_country` varchar(10) NOT NULL,
  `atu_type_id` int unsigned NOT NULL,
  `residence` varchar(255) DEFAULT NULL,
  `auto_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ATU_Country_idx` (`code_of_country`),
  KEY `fk_ATU_ATUType_idx` (`atu_type_id`),
  CONSTRAINT `fk_ATU_Country` FOREIGN KEY (`code_of_country`) REFERENCES `Countries` (`codeOfCountry`) ON DELETE CASCADE,
  CONSTRAINT `fk_ATU_ATUType` FOREIGN KEY (`atu_type_id`) REFERENCES `ATUType` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Cities
CREATE TABLE `invoice_app`.`Cities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `atu_id` int unsigned NOT NULL,
  `population` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Cities_ATU_idx` (`atu_id`),
  CONSTRAINT `fk_Cities_ATU` FOREIGN KEY (`atu_id`) REFERENCES `ATU` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Addresses
CREATE TABLE `invoice_app`.`Addresses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `city_id` int unsigned NOT NULL,
  `sector` varchar(100) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `block` varchar(10) DEFAULT NULL,
  `entrance` varchar(10) DEFAULT NULL,
  `floor` varchar(10) DEFAULT NULL,
  `apartment` varchar(10) DEFAULT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Addresses_City_idx` (`city_id`),
  KEY `fk_Addresses_AddressType_idx` (`type_id`),
  CONSTRAINT `fk_Addresses_City` FOREIGN KEY (`city_id`) REFERENCES `Cities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Addresses_AddressType` FOREIGN KEY (`type_id`) REFERENCES `AddressType` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Types of Contacts
CREATE TABLE `invoice_app`.`TypeOfContact` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Genders
CREATE TABLE `invoice_app`.`Gender` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Types of Person
CREATE TABLE `invoice_app`.`Types_of_Person` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person
CREATE TABLE `invoice_app`.`Person` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address_id` int unsigned DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Address_idx` (`address_id`),
  KEY `fk_Person_Gender_idx` (`gender_id`),
  KEY `fk_Person_Type_idx` (`type_id`),
  CONSTRAINT `fk_Person_Address` FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`id`),
  CONSTRAINT `fk_Person_Gender` FOREIGN KEY (`gender_id`) REFERENCES `Gender` (`id`),
  CONSTRAINT `fk_Person_Type` FOREIGN KEY (`type_id`) REFERENCES `Types_of_Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person Types
CREATE TABLE `invoice_app`.`Person_Type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Type_Person_idx` (`person_id`),
  KEY `fk_Person_Type_Types_of_Person_idx` (`type_id`),
  CONSTRAINT `fk_Person_Type_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Person_Type_Types_of_Person` FOREIGN KEY (`type_id`) REFERENCES `Types_of_Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Roles
CREATE TABLE `invoice_app`.`Roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Users
CREATE TABLE `invoice_app`.`Users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password_hash` char(128) NOT NULL,
  `person_id` int unsigned DEFAULT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `fk_Users_Person_idx` (`person_id`),
  KEY `fk_Users_Role_idx` (`role_id`),
  CONSTRAINT `fk_Users_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Users_Role` FOREIGN KEY (`role_id`) REFERENCES `Roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier
CREATE TABLE `invoice_app`.`Supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unique_code` varchar(45) NOT NULL,
  `address_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code_UNIQUE` (`unique_code`),
  KEY `fk_Supplier_Address_idx` (`address_id`),
  CONSTRAINT `fk_Supplier_Address` FOREIGN KEY (`address_id`) REFERENCES `Addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Contacts
CREATE TABLE `invoice_app`.`Supplier_Contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `contact_type_id` int unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Supplier_Contacts_Supplier_idx` (`supplier_id`),
  KEY `fk_Supplier_Contacts_TypeOfContact_idx` (`contact_type_id`),
  CONSTRAINT `fk_Supplier_Contacts_Supplier` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`id`),
  CONSTRAINT `fk_Supplier_Contacts_TypeOfContact` FOREIGN KEY (`contact_type_id`) REFERENCES `TypeOfContact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Person Contacts
CREATE TABLE `invoice_app`.`Person_Contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `contact_type_id` int unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Person_Contacts_Person_idx` (`person_id`),
  KEY `fk_Person_Contacts_TypeOfContact_idx` (`contact_type_id`),
  CONSTRAINT `fk_Person_Contacts_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`),
  CONSTRAINT `fk_Person_Contacts_TypeOfContact` FOREIGN KEY (`contact_type_id`) REFERENCES `TypeOfContact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Categories
CREATE TABLE `invoice_app`.`Category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Products
CREATE TABLE `invoice_app`.`Products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Products_Category_idx` (`category_id`),
  CONSTRAINT `fk_Products_Category` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Unit of Measure
CREATE TABLE `invoice_app`.`Unit_of_measure` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Invoices
CREATE TABLE `invoice_app`.`SupplierInvoice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int unsigned NOT NULL,
  `invoice_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SupplierInvoice_Supplier_idx` (`supplier_id`),
  CONSTRAINT `fk_SupplierInvoice_Supplier` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Customer Invoices
CREATE TABLE `invoice_app`.`CustomerInvoice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `invoice_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CustomerInvoice_Person_idx` (`person_id`),
  CONSTRAINT `fk_CustomerInvoice_Person` FOREIGN KEY (`person_id`) REFERENCES `Person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Product Inventory
CREATE TABLE `invoice_app`.`ProductInventory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ProductInventory_Product_idx` (`product_id`),
  CONSTRAINT `fk_ProductInventory_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Customer Transactions
CREATE TABLE `invoice_app`.`Customer_Transaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_date` datetime NOT NULL,
  `product_id` int unsigned NOT NULL,
  `caen` varchar(20) NOT NULL,
  `quantity` decimal NOT NULL,
  `unit_of_measure_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `deductible` decimal DEFAULT NULL,
  `taxable` decimal DEFAULT NULL,
  `invoice_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Customer_Transaction_Product_idx` (`product_id`),
  KEY `fk_Customer_Transaction_Unit_of_measure_idx` (`unit_of_measure_id`),
  KEY `fk_Customer_Transaction_CustomerInvoice_idx` (`invoice_id`),
  CONSTRAINT `fk_Customer_Transaction_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`),
  CONSTRAINT `fk_Customer_Transaction_Unit_of_measure` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `Unit_of_measure` (`id`),
  CONSTRAINT `fk_Customer_Transaction_CustomerInvoice` FOREIGN KEY (`invoice_id`) REFERENCES `CustomerInvoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table for Supplier Transactions
CREATE TABLE `invoice_app`.`Supplier_Transaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_date` datetime NOT NULL,
  `product_id` int unsigned NOT NULL,
  `caen` varchar(20) NOT NULL,
  `quantity` decimal NOT NULL,
  `unit_of_measure_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `deductible` decimal DEFAULT NULL,
  `taxable` decimal DEFAULT NULL,
  `invoice_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Supplier_Transaction_Product_idx` (`product_id`),
  KEY `fk_Supplier_Transaction_Unit_of_measure_idx` (`unit_of_measure_id`),
  KEY `fk_Supplier_Transaction_SupplierInvoice_idx` (`invoice_id`),
  CONSTRAINT `fk_Supplier_Transaction_Product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`),
  CONSTRAINT `fk_Supplier_Transaction_Unit_of_measure` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `Unit_of_measure` (`id`),
  CONSTRAINT `fk_Supplier_Transaction_SupplierInvoice` FOREIGN KEY (`invoice_id`) REFERENCES `SupplierInvoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Countries
INSERT INTO `invoice_app`.`Countries` (`codeOfCountry`, `name`) VALUES 
('RO', 'Romania'),
('US', 'United States'),
('DE', 'Germany');

-- Address Types
INSERT INTO `invoice_app`.`AddressType` (`type`) VALUES 
('Person'),
('Supplier');

-- Types of Contacts
INSERT INTO `invoice_app`.`TypeOfContact` (`type`) VALUES 
('Email'),
('Phone'),
('Fax');

-- ATU Types
INSERT INTO `invoice_app`.`ATUType` (`type`) VALUES 
('County'),
('City'),
('Town');

INSERT INTO invoice_app.atu (name, code_of_country, atu_type_id) VALUES ('Alba', 'RO', 1);
INSERT INTO invoice_app.cities (name, atu_id, population) VALUES ('Alba Iulia', 1, 65091);
INSERT INTO invoice_app.cities (name, atu_id, population) VALUES ('Cugir', 1, 28780);
INSERT INTO invoice_app.cities (name, atu_id, population) VALUES ('Aiud', 1, 24619);


-- Genders
INSERT INTO `invoice_app`.`Gender` (`gender`) VALUES 
('Male'),
('Female'),
('Other');

-- Types of Person
INSERT INTO `invoice_app`.`Types_of_Person` (`type`) VALUES 
('Employee'),
('Customer'),
('Supplier');

-- Addresses
INSERT INTO `invoice_app`.`Addresses` (`city_id`, `sector`, `street`, `number`, `block`, `entrance`, `floor`, `apartment`, `type_id`) VALUES 
(1, 'Central', 'Main Street', '10', 'A', '1', '2', '5', 1),
(2, 'Downtown', 'Broadway', '100', NULL, NULL, NULL, NULL, 1),
(3, 'City Center', 'Marienplatz', '20', 'C', '2', '1', '10', 2);

-- Suppliers
INSERT INTO `invoice_app`.`Supplier` (`name`, `unique_code`, `address_id`) VALUES 
('Altex', '1234567', 1),
('Emag', '7654321', 2),
('MediaMarkt', '1111111', 3);

-- Persons
INSERT INTO `invoice_app`.`Person` (`surname`, `name`, `address_id`, `dob`, `gender_id`, `type_id`) VALUES 
('Pop', 'Ion', 1, '1985-05-10', 1, 1),
('Smith', 'John', 2, '1990-02-20', 1, 2),
('Müller', 'Anna', 3, '1988-11-15', 2, 3);

-- Roles
INSERT INTO `invoice_app`.`Roles` (`type`) VALUES 
('Admin'),
('User');

-- Users
INSERT INTO `invoice_app`.`Users` (`username`, `password_hash`, `person_id`, `role_id`) VALUES 
('popion', 'hashed_password', 1, 1), 
('jsmith', 'hashed_password', 2, 2), 
('amuller', 'hashed_password', 3, 2);

-- Supplier Contacts
INSERT INTO `invoice_app`.`Supplier_Contacts` (`supplier_id`, `contact_type_id`, `value`) VALUES 
(1, 1, 'contact@altex.com'),
(2, 2, '555-1234'),
(3, 3, '123456789');

-- Person Contacts
INSERT INTO `invoice_app`.`Person_Contacts` (`person_id`, `contact_type_id`, `value`) VALUES 
(1, 1, 'popion@example.com'),
(2, 2, 'jsmith@example.com'),
(3, 1, 'amuller@example.com');

-- Categories
INSERT INTO `invoice_app`.`Category` (`name`) VALUES 
('Electronics'),
('Home Appliances'),
('Furniture');

-- Products
INSERT INTO `invoice_app`.`Products` (`name`, `description`, `category_id`) VALUES 
('Alienware Laptop', 'High performance Alienware laptop', 1),
('Samsung TV', 'Smart TV 55 inch', 2),
('Ikea Chair', 'Comfortable office chair', 3);

-- Units of Measure
INSERT INTO `invoice_app`.`Unit_of_measure` (`name`, `short`) VALUES 
('Piece', 'pcs'),
('Kilogram', 'kg'),
('Liter', 'L');

-- Supplier Invoices
INSERT INTO `invoice_app`.`SupplierInvoice` (`supplier_id`, `invoice_date`, `price`) VALUES 
(1, '2024-06-01', 5000.00),
(2, '2024-06-02', 7000.00),
(3, '2024-06-03', 9000.00);

-- Customer Invoices
INSERT INTO `invoice_app`.`CustomerInvoice` (`person_id`, `invoice_date`, `price`) VALUES 
(1, '2024-06-01', 200.00),
(2, '2024-06-02', 300.00),
(3, '2024-06-03', 400.00);

-- Product Inventory
INSERT INTO `invoice_app`.`ProductInventory` (`product_id`, `quantity`, `price`) VALUES 
(1, 10, 3000.00),
(2, 20, 1000.00),
(3, 30, 120.00);

-- Customer Transactions
INSERT INTO `invoice_app`.`Customer_Transaction` (`sale_date`, `product_id`, `caen`, `quantity`, `unit_of_measure_id`, `price`, `notes`, `deductible`, `taxable`, `invoice_id`) VALUES 
('2024-06-01', 1, '1234', 2, 1, 3500.00, 'First sale', true, true, 1),
('2024-06-02', 2, '5678', 3, 1, 1200.00, 'Second sale', true, true, 2),
('2024-06-03', 3, '9101', 4, 1, 150.00, 'Third sale', true, true, 3);

-- Supplier Transactions
INSERT INTO `invoice_app`.`Supplier_Transaction` (`sale_date`, `product_id`, `caen`, `quantity`, `unit_of_measure_id`, `price`, `notes`, `deductible`, `taxable`, `invoice_id`) VALUES 
('2024-06-01', 1, '1234', 2, 1, 3500.00, 'First sale', true, true, 1),
('2024-06-02', 2, '5678', 3, 1, 1200.00, 'Second sale', true, true, 2),
('2024-06-03', 3, '9101', 4, 1, 150.00, 'Third sale', true, true, 3);