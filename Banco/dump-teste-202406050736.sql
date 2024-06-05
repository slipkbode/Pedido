-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: teste
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbcliente`
--

DROP TABLE IF EXISTS `tbcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcliente` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_tbCliente_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcliente`
--

LOCK TABLES `tbcliente` WRITE;
/*!40000 ALTER TABLE `tbcliente` DISABLE KEYS */;
INSERT INTO `tbcliente` VALUES (1,'Marcos','Cuiabá','MT'),(2,'Erica','Cuiabá','MT'),(3,'Maria','Cuiabá','MT'),(4,'Mariana','Cuiabá','MT'),(5,'Paulo','Tangará','MT'),(6,'Sandro','Sinop','MT'),(7,'Terra','Sorriso','MT'),(8,'Cleber','São Paulo','SP'),(9,'Artur','Olimpia','SP'),(10,'Rogério','Cuiabá','MT'),(11,'Nascimento','Cuiabá','MT'),(12,'João','Jaciara','MT'),(13,'Gustavo','Cuiabá','MT'),(14,'Ger','Cuiabá','MT'),(15,'Teria','Cuiabá','MT'),(16,'Polo','Cuiabá','MT'),(17,'Flávio','Cuiabá','MT'),(18,'Eduardo','Cuiabá','MT'),(19,'Bugr','Cuiabá','MT'),(20,'Marcio','Cuiabá','MT');
/*!40000 ALTER TABLE `tbcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpedido`
--

DROP TABLE IF EXISTS `tbpedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpedido` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` float DEFAULT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `idx_tbPedido_codigo_data_emissao` (`data_emissao`),
  KEY `idx_tbPedido_codigo_cliente` (`codigo_cliente`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`codigo_cliente`) REFERENCES `tbcliente` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedido`
--

LOCK TABLES `tbpedido` WRITE;
/*!40000 ALTER TABLE `tbpedido` DISABLE KEYS */;
INSERT INTO `tbpedido` VALUES (5,'2024-06-04',2,48.2),(6,'2024-06-04',3,1);
/*!40000 ALTER TABLE `tbpedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpedidoproduto`
--

DROP TABLE IF EXISTS `tbpedidoproduto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpedidoproduto` (
  `codigoitem` int NOT NULL,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` float NOT NULL,
  `valor_unitario` float NOT NULL,
  `valor_total` float NOT NULL,
  PRIMARY KEY (`numero_pedido`,`codigoitem`),
  KEY `idx_tbPedidoProduto_numero_pedido` (`numero_pedido`),
  KEY `idx_tbPedidoProduto_codigo_produto` (`codigo_produto`),
  CONSTRAINT `fk_pedidoproduto_pedido` FOREIGN KEY (`numero_pedido`) REFERENCES `tbpedido` (`numero_pedido`),
  CONSTRAINT `fk_pedidoproduto_produto` FOREIGN KEY (`codigo_produto`) REFERENCES `tbproduto` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpedidoproduto`
--

LOCK TABLES `tbpedidoproduto` WRITE;
/*!40000 ALTER TABLE `tbpedidoproduto` DISABLE KEYS */;
INSERT INTO `tbpedidoproduto` VALUES (1,5,1,1,1,1),(2,5,3,3,2,6),(3,5,4,4,3,12),(4,5,5,4,4.3,17.2),(5,5,4,4,3,12),(1,6,1,1,1,1);
/*!40000 ALTER TABLE `tbpedidoproduto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbproduto`
--

DROP TABLE IF EXISTS `tbproduto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbproduto` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(300) NOT NULL,
  `preco_venda` float DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_tbProduto_descricao` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbproduto`
--

LOCK TABLES `tbproduto` WRITE;
/*!40000 ALTER TABLE `tbproduto` DISABLE KEYS */;
INSERT INTO `tbproduto` VALUES (1,'Lápis',1),(2,'Caderno',1.34),(3,'Notebook',2),(4,'Régua',3),(5,'Mochila',4.3),(6,'Mochila para Notebook',5.67),(7,'Tenis',5),(8,'Borracha',6),(9,'Lapiseira',200),(10,'Lapis de Cor',345),(11,'Papel A4',1000),(12,'Papel Cartão',1056),(13,'Papel Selofane',135),(14,'Caneta',23),(15,'Cartolina',34),(16,'Ventilador',56),(17,'Cooler',66),(18,'Pen drive',77),(19,'Isopor',88.01),(20,'Esquadro',9);
/*!40000 ALTER TABLE `tbproduto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'teste'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-05  7:36:12
