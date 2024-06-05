DROP DATABASE IF EXISTS `jaccountant_test`;
CREATE DATABASE `jaccountant_test`;


CREATE TABLE `jaccountant_test`.`furnizor` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `furnizor` mediumtext NOT NULL,
  `cod_unic` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idfurnizor_UNIQUE` (`id`),
  UNIQUE KEY `cod_unic_UNIQUE` (`cod_unic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `jaccountant_test`.`furnizor` (`furnizor`, `cod_unic`) VALUES ('Mega Image', '6719278');


DROP TABLE IF EXISTS `jaccountant_test`.`produs`;
CREATE TABLE `jaccountant_test`.`produs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `produs` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idprodus_UNIQUE` (`id`),
  UNIQUE KEY `produs_UNIQUE` (`produs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `jaccountant_test`.`produs` (`produs`) VALUES ('potato');

DROP TABLE IF EXISTS `jaccountant_test`.`unitat_de_masura`;
CREATE TABLE `jaccountant_test`.`unitat_de_masura` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `unitate_de_masura` varchar(45) NOT NULL,
  `unitate_de_masura_short` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idunitat_de_masura_UNIQUE` (`id`),
  UNIQUE KEY `unitat_de_masura_UNIQUE` (`unitate_de_masura`),
  UNIQUE KEY `unitate_de_masura_short_UNIQUE` (`unitate_de_masura_short`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `jaccountant_test`.`unitat_de_masura` (`unitate_de_masura`, `unitate_de_masura_short`) VALUES ('meter','m'),('centimeter','cm'),('meters squared','m²'),('bucata','buc'),('kilogram','kg');

DROP TABLE IF EXISTS `jaccountant_test`.`user`;
CREATE TABLE `jaccountant_test`.`user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `passwordHash` char(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iduser_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `jaccountant_test`.`user` (username, passwordHash) VALUES ('admin','c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec');

DROP TABLE IF EXISTS `jaccountant_test`.`vanzare`;
CREATE TABLE `jaccountant_test`.`vanzare` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `furnizor` int unsigned NOT NULL,
  `produs` int unsigned NOT NULL,
  `caen` varchar(4) DEFAULT '0000',
  `cantitate` decimal(10,0) unsigned NOT NULL,
  `unitate_de_masura` int unsigned NOT NULL,
  `cheltuieli` decimal(10,0) unsigned DEFAULT NULL,
  `venituri` decimal(10,0) unsigned DEFAULT NULL,
  `note` int unsigned DEFAULT NULL,
  `deductibil` decimal(10,0) unsigned DEFAULT NULL,
  `profit` decimal(10,0) unsigned DEFAULT NULL,
  `impozabil` decimal(10,0) unsigned DEFAULT NULL,
  `impozit` decimal(10,0) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idvanzare_UNIQUE` (`id`),
  KEY `furnizor_idx` (`furnizor`),
  KEY `produs_idx` (`produs`),
  KEY `unitat_de_masura_idx` (`unitate_de_masura`),
  CONSTRAINT `furnizor` FOREIGN KEY (`furnizor`) REFERENCES `furnizor` (`id`),
  CONSTRAINT `produs` FOREIGN KEY (`produs`) REFERENCES `produs` (`id`),
  CONSTRAINT `unitat_de_masura` FOREIGN KEY (`unitate_de_masura`) REFERENCES `unitat_de_masura` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;