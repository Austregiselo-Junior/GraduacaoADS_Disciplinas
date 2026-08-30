-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: gestao_eventos
-- ------------------------------------------------------
-- Server version	8.0.28

CREATE DATABASE gestao_eventos;
USE gestao_eventos;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bairro`
--

DROP TABLE IF EXISTS `bairro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bairro` (
  `idBairro` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`idBairro`),
  KEY `idx_bairro_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bairro`
--

LOCK TABLES `bairro` WRITE;
/*!40000 ALTER TABLE `bairro` DISABLE KEYS */;
INSERT INTO `bairro` VALUES (6,'Altiplano'),(3,'Bancários'),(7,'Bessa'),(8,'Brisamar'),(1,'Centro'),(9,'Cristo'),(25,'Cruz das Armas'),(10,'Estados'),(11,'Expedicionários'),(12,'Geisel'),(13,'Jaguaribe'),(14,'Jardim Oceania'),(15,'João Agripino'),(2,'Manaíra'),(5,'Mangabeira'),(16,'Miramar'),(17,'Pedro Gondim'),(18,'Planalto'),(19,'Portal do Sol'),(20,'Róger'),(4,'Tambaú'),(26,'Teste'),(21,'Torre'),(22,'Treze de Maio'),(23,'Valentina'),(24,'Varadouro');
/*!40000 ALTER TABLE `bairro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `data_evento` date NOT NULL,
  `qtd_vagas` int NOT NULL,
  `fk_idOrganizacao` int NOT NULL,
  `fk_idBairro` int NOT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_evento_organizacao` (`fk_idOrganizacao`),
  KEY `fk_evento_bairro` (`fk_idBairro`),
  KEY `idx_evento_data` (`data_evento`),
  CONSTRAINT `fk_evento_bairro` FOREIGN KEY (`fk_idBairro`) REFERENCES `bairro` (`idBairro`),
  CONSTRAINT `fk_evento_organizacao` FOREIGN KEY (`fk_idOrganizacao`) REFERENCES `organizacao` (`idOrganizacao`),
  CONSTRAINT `chk_evento_qtd_vagas` CHECK ((`qtd_vagas` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'Feira Cultural do Centro','2026-03-15',50,1,1),(2,'Ação Social Manaíra','2026-03-20',30,2,2),(3,'Oficina de Artes Mangabeira','2026-04-10',20,3,5),(4,'Encontro Jovem Bancários','2026-04-25',40,2,3),(5,'Festival Gastronômico do Altiplano','2026-05-01',60,4,6),(6,'Mutirão Solidário do Bessa','2026-05-05',45,5,7),(7,'Workshop de Tecnologia Brisamar','2026-05-10',35,6,8),(8,'Seminário Cultural do Cristo','2026-05-15',50,7,9),(9,'Feira de Empreendedorismo dos Estados','2026-05-20',55,8,10),(10,'Mostra Artística de Miramar','2026-05-25',69,9,16),(11,'Corrida Comunitária Torre','2026-06-01',80,10,21),(12,'Palestra Educacional Valentina','2026-06-05',40,11,23),(13,'Encontro Ambiental Jaguaribe','2026-06-10',35,12,13),(14,'Oficina de Música Geisel','2026-06-15',25,13,12),(15,'Festival Junino Mangabeira','2026-06-20',100,3,5),(16,'Ação Social Portal do Sol','2026-07-01',45,14,19),(17,'Capacitação Profissional Róger','2026-07-05',30,15,20),(18,'Feira Literária Centro Histórico','2026-07-10',60,1,1),(19,'Mutirão de Saúde Expedicionários','2026-07-15',50,8,11),(20,'Festival Esportivo João Agripino','2026-07-20',75,6,15);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscricao`
--

DROP TABLE IF EXISTS `inscricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscricao` (
  `idInscricao` int NOT NULL AUTO_INCREMENT,
  `data_hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_idMorador` int NOT NULL,
  `fk_idEvento` int NOT NULL,
  PRIMARY KEY (`idInscricao`),
  UNIQUE KEY `uq_inscricao_evento_morador` (`fk_idMorador`,`fk_idEvento`),
  KEY `idx_inscricao_evento` (`fk_idEvento`),
  CONSTRAINT `fk_inscricao_evento` FOREIGN KEY (`fk_idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `fk_inscricao_morador` FOREIGN KEY (`fk_idMorador`) REFERENCES `morador` (`idMorador`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscricao`
--

LOCK TABLES `inscricao` WRITE;
/*!40000 ALTER TABLE `inscricao` DISABLE KEYS */;
INSERT INTO `inscricao` VALUES (1,'2026-02-24 19:36:03',1,1),(2,'2026-02-24 19:36:03',2,1),(3,'2026-02-24 19:36:03',3,2),(4,'2026-02-24 19:36:03',4,2),(5,'2026-02-24 19:36:03',5,3),(6,'2026-02-24 19:36:03',6,4),(7,'2026-02-24 19:36:03',7,4),(8,'2026-02-24 19:36:03',8,5),(9,'2026-02-24 19:36:03',9,5),(10,'2026-02-24 19:36:03',10,6),(11,'2026-02-24 19:36:03',11,6),(12,'2026-02-24 19:36:03',12,7),(13,'2026-02-24 19:36:03',13,8),(14,'2026-02-24 19:36:03',14,9),(15,'2026-02-24 19:36:03',15,10),(16,'2026-02-24 19:36:03',16,5),(17,'2026-02-24 19:36:03',17,6),(18,'2026-02-24 19:36:03',18,7),(19,'2026-02-24 19:36:03',19,8),(20,'2026-02-24 19:36:03',20,9),(21,'2026-04-30 00:00:00',2,10),(23,'2026-04-30 00:00:00',3,10);
/*!40000 ALTER TABLE `inscricao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `morador`
--

DROP TABLE IF EXISTS `morador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `morador` (
  `idMorador` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `fk_idBairro` int NOT NULL,
  PRIMARY KEY (`idMorador`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `fk_morador_bairro` (`fk_idBairro`),
  KEY `idx_morador_nome` (`nome`),
  CONSTRAINT `fk_morador_bairro` FOREIGN KEY (`fk_idBairro`) REFERENCES `bairro` (`idBairro`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `morador`
--

LOCK TABLES `morador` WRITE;
/*!40000 ALTER TABLE `morador` DISABLE KEYS */;
INSERT INTO `morador` VALUES (1,'Ana Beatriz Souza','111.111.111-11',1),(2,'Carlos Henrique Lima','222.222.222-22',2),(3,'Juliana Martins','333.333.333-33',3),(4,'Pedro Almeida','444.444.444-44',4),(5,'Mariana Costa','555.555.555-55',5),(6,'Lucas Fernandes','666.666.666-66',2),(7,'Fernanda Oliveira','777.777.777-77',3),(8,'Rafael Andrade','900.000.000-01',6),(9,'Beatriz Nascimento','900.000.000-02',7),(10,'Thiago Ribeiro','900.000.000-03',8),(11,'Larissa Gomes','900.000.000-04',9),(12,'Gabriel Melo','900.000.000-05',10),(13,'Camila Duarte','900.000.000-06',11),(14,'Vinícius Araújo','900.000.000-07',12),(15,'Amanda Rocha','900.000.000-08',13),(16,'Bruno Cavalcanti','900.000.000-09',14),(17,'Isabela Freitas','900.000.000-10',15),(18,'Leonardo Barros','900.000.000-11',16),(19,'Patrícia Sales','900.000.000-12',17),(20,'Eduardo Martins','900.000.000-13',18),(21,'Natália Soares','900.000.000-14',19),(22,'Felipe Moura','900.000.000-15',20),(23,'Daniela Pires','900.000.000-16',21),(24,'Rodrigo Farias','900.000.000-17',22),(25,'Tatiane Lima','900.000.000-18',23),(26,'Gustavo Vieira','900.000.000-19',24),(27,'Vanessa Batista','900.000.000-20',25);
/*!40000 ALTER TABLE `morador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizacao`
--

DROP TABLE IF EXISTS `organizacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizacao` (
  `idOrganizacao` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrganizacao`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizacao`
--

LOCK TABLES `organizacao` WRITE;
/*!40000 ALTER TABLE `organizacao` DISABLE KEYS */;
INSERT INTO `organizacao` VALUES (1,'Associação Cultural Centro','83999990001'),(2,'ONG Juventude Ativa','83999990002'),(3,'Projeto Social Mangabeira','83999990003'),(4,'Instituto Vida Nova','83988880001'),(5,'Associação Comunitária Bessa','83988880002'),(6,'Projeto Jovem Futuro','83988880003'),(7,'Fundação Cultural Torre','83988880004'),(8,'Movimento Social Cristo','83988880005'),(9,'ONG Esperança Viva','83988880006'),(10,'Centro Educacional Miramar','83988880007'),(11,'Projeto Social Valentina','83988880008'),(12,'Grupo Cultural Róger','83988880009'),(13,'Instituto Desenvolvimento JP','83988880010'),(14,'Ação Solidária Bancários','83988880011'),(15,'Instituto Inclusão Social','83988880012'),(16,'Movimento Arte & Cultura','83988880013'),(17,'Associação Vida Melhor','83988880014'),(18,'Projeto Bairro Ativo','83988880015');
/*!40000 ALTER TABLE `organizacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_eventos`
--

DROP TABLE IF EXISTS `vw_eventos`;
/*!50001 DROP VIEW IF EXISTS `vw_eventos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_eventos` AS SELECT 
 1 AS `Evento`,
 1 AS `Data do Evento`,
 1 AS `Organização`,
 1 AS `Bairro`,
 1 AS `Qtd Inscritos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inscritos_evento`
--

DROP TABLE IF EXISTS `vw_inscritos_evento`;
/*!50001 DROP VIEW IF EXISTS `vw_inscritos_evento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inscritos_evento` AS SELECT 
 1 AS `Evento`,
 1 AS `Qtd_Inscritos`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_eventos`
--

/*!50001 DROP VIEW IF EXISTS `vw_eventos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_eventos` AS select `e`.`titulo` AS `Evento`,date_format(`e`.`data_evento`,'%d/%m/%Y') AS `Data do Evento`,`o`.`nome` AS `Organização`,`b`.`nome` AS `Bairro`,count(`i`.`idInscricao`) AS `Qtd Inscritos` from (((`evento` `e` join `organizacao` `o` on((`o`.`idOrganizacao` = `e`.`fk_idOrganizacao`))) join `bairro` `b` on((`b`.`idBairro` = `e`.`fk_idBairro`))) join `inscricao` `i` on((`i`.`fk_idEvento` = `e`.`idEvento`))) group by `e`.`titulo`,`o`.`nome`,`b`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inscritos_evento`
--

/*!50001 DROP VIEW IF EXISTS `vw_inscritos_evento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inscritos_evento` AS select `e`.`titulo` AS `Evento`,count(`i`.`idInscricao`) AS `Qtd_Inscritos` from (`evento` `e` left join `inscricao` `i` on((`i`.`fk_idEvento` = `e`.`idEvento`))) group by `e`.`titulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-28 21:11:19
