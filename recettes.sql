-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour recette_emmanuel
CREATE DATABASE IF NOT EXISTS `recette_emmanuel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `recette_emmanuel`;

-- Listage de la structure de table recette_emmanuel. category
CREATE TABLE IF NOT EXISTS `category` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table recette_emmanuel.category : ~3 rows (environ)
INSERT INTO `category` (`id_category`, `category_name`) VALUES
	(1, 'starter'),
	(2, 'main course'),
	(3, 'desert');

-- Listage de la structure de table recette_emmanuel. ingredient
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table recette_emmanuel.ingredient : ~13 rows (environ)
INSERT INTO `ingredient` (`id_ingredient`, `ingredient_name`, `price`) VALUES
	(1, 'Tomate', 1.5),
	(2, 'Laitue', 1.2),
	(3, 'Pâtes', 2),
	(4, 'Crème fraîche', 2.5),
	(5, 'Oeuf', 0.3),
	(6, 'Parmesan', 3),
	(7, 'Poulet', 5),
	(8, 'Vinaigrette', 1),
	(9, 'Avocat', 2.2),
	(10, 'Riz', 1.8),
	(11, 'Chocolat', 4),
	(12, 'Sucre', 0.8),
	(13, 'Citron', 0.5);

-- Listage de la structure de table recette_emmanuel. recipe
CREATE TABLE IF NOT EXISTS `recipe` (
  `id_recipe` int NOT NULL AUTO_INCREMENT,
  `recipe_name` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `preparation_time` int NOT NULL DEFAULT '0',
  `instructions` text COLLATE utf8mb4_bin,
  `id_category` int DEFAULT NULL,
  PRIMARY KEY (`id_recipe`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `FK_recipe_categorie` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table recette_emmanuel.recipe : ~10 rows (environ)
INSERT INTO `recipe` (`id_recipe`, `recipe_name`, `preparation_time`, `instructions`, `id_category`) VALUES
	(1, 'Salade César', 15, 'Mélanger laitue, poulet grillé, vinaigrette et parmesan. Servir frais.', 1),
	(2, 'Salade de tomates', 10, 'Couper les tomates, ajouter de l\'huile d\'olive, du sel et du poivre.', 1),
	(3, 'Pâtes à la carbonara', 20, 'Faire cuire les pâtes, préparer une sauce avec œufs, crème et parmesan. Mélanger avec les pâtes.', 2),
	(4, 'Poulet rôti', 45, 'Faire cuire le poulet au four avec des herbes et de l\'huile d\'olive.', 2),
	(5, 'Risotto aux champignons', 30, 'Cuire le riz avec du bouillon et des champignons. Ajouter du parmesan.', 2),
	(6, 'Quiche lorraine', 40, 'Mélanger crème, œufs, lardons, puis cuire dans une pâte brisée.', 2),
	(7, 'Tarte au chocolat', 50, 'Préparer une pâte, ajouter la ganache au chocolat, cuire au four.', 3),
	(8, 'Soupe de légumes', 25, 'Faire bouillir les légumes dans de l\'eau, mixer pour obtenir une consistance lisse.', 2),
	(9, 'Crêpes au sucre', 20, 'Préparer la pâte à crêpes, cuire dans une poêle et saupoudrer de sucre.', 3),
	(10, 'Tiramisu', 30, 'Alterner couches de biscuits imbibés de café et de mascarpone.', 3);

-- Listage de la structure de table recette_emmanuel. recipe_ingredients
CREATE TABLE IF NOT EXISTS `recipe_ingredients` (
  `quantity` float NOT NULL,
  `unit` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `id_recipe` int DEFAULT NULL,
  `id_ingredient` int DEFAULT NULL,
  KEY `id_recipe` (`id_recipe`),
  KEY `id_ingredient` (`id_ingredient`),
  CONSTRAINT `FK_recipe_ingredients_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`),
  CONSTRAINT `FK_recipe_ingredients_recipe` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table recette_emmanuel.recipe_ingredients : ~25 rows (environ)
INSERT INTO `recipe_ingredients` (`quantity`, `unit`, `id_recipe`, `id_ingredient`) VALUES
	(100, 'grammes', 1, 2),
	(150, 'grammes', 1, 7),
	(2, 'cuillère', 1, 8),
	(30, 'grammes', 1, 6),
	(200, 'grammes', 2, 1),
	(1, 'cuillère', 2, 8),
	(200, 'grammes', 3, 3),
	(3, 'cuillère', 3, 4),
	(2, 'unité', 3, 5),
	(50, 'grammes', 3, 6),
	(500, 'grammes', 4, 7),
	(200, 'grammes', 5, 10),
	(100, 'grammes', 5, 1),
	(50, 'grammes', 5, 6),
	(4, 'cuillère', 6, 4),
	(3, 'unité', 6, 5),
	(100, 'grammes', 6, 7),
	(200, 'grammes', 7, 11),
	(50, 'grammes', 7, 12),
	(150, 'grammes', 8, 10),
	(100, 'grammes', 8, 1),
	(100, 'grammes', 9, 3),
	(20, 'grammes', 9, 12),
	(150, 'grammes', 10, 11),
	(100, 'grammes', 10, 12);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
