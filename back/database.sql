-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: login
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `alojamiento`
--

DROP TABLE IF EXISTS `alojamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alojamiento` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `hospedaje` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `puntacion` int NOT NULL,
  `canthabitaciones` int NOT NULL,
  `cantbaños` int NOT NULL,
  `img` varchar(45) NOT NULL,
  `cocina?` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alojamiento`
--

LOCK TABLES `alojamiento` WRITE;
/*!40000 ALTER TABLE `alojamiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `alojamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_Id` int NOT NULL,
  `vuelos_Id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario` (`usuario_Id`),
  KEY `fk_vuelos` (`vuelos_Id`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_Id`) REFERENCES `usuario` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vuelos` FOREIGN KEY (`vuelos_Id`) REFERENCES `vuelos` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (9,8,14);
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Correo` varchar(45) NOT NULL,
  `Contraseña` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`),
  UNIQUE KEY `Correo_UNIQUE` (`Correo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'facundo','facuporta@gmail.com','aaaaaaaaaaa'),(2,'pepito','pepito@gmail.com','pepito123'),(4,'pablkito','pablito@gmail.com','1234'),(5,'ELBOLA','BOLA@gmail.com','bolabola'),(6,'PEPITOTE','PAAPITO@gmail.com','uuuuuuuuuu'),(7,'elpapu','elpapu@gmail.com','12345678'),(8,'123','123@gmail.com','123'),(9,'321','321@gmail.com','123'),(10,'facundo','facuporta2006@gmail.com','1234');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuelos`
--

DROP TABLE IF EXISTS `vuelos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuelos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `aeropuertosalidaida` varchar(45) NOT NULL,
  `aeropuertollegadaida` varchar(45) NOT NULL,
  `fechasalidaida` varchar(45) NOT NULL,
  `fechallegadaida` varchar(45) NOT NULL,
  `horasalidaida` varchar(45) NOT NULL,
  `horallegadaida` varchar(45) NOT NULL,
  `aeropuertosalidavuelta` varchar(45) NOT NULL,
  `aeropuertollegadavuelta` varchar(45) NOT NULL,
  `fechasalidavuelta` varchar(45) NOT NULL,
  `fechallegadavuelta` varchar(45) NOT NULL,
  `horasalidavuelta` varchar(45) NOT NULL,
  `horallegadavuelta` varchar(45) NOT NULL,
  `paquetevuelo` varchar(45) NOT NULL,
  `destinoida` varchar(45) NOT NULL,
  `destinovuelta` varchar(45) NOT NULL,
  `imagen` varchar(45) NOT NULL,
  `precio` varchar(45) NOT NULL,
  `rating` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuelos`
--

LOCK TABLES `vuelos` WRITE;
/*!40000 ALTER TABLE `vuelos` DISABLE KEYS */;
INSERT INTO `vuelos` VALUES (1,'Ezeiza (EZE)','São Paulo (GRU)','2025-07-15','2025-07-15','09:00','12:00','São Paulo (GRU)','Ezeiza (EZE)','2025-07-22','2025-07-22','14:30','17:30','económico','Brasil','Argentina','sao paulo.webp','210000.00','8/10'),(2,'Córdoba (COR)','Río de Janeiro (GIG)','2025-08-03','2025-08-03','07:45','11:15','Río de Janeiro (GIG)','Córdoba (COR)','2025-08-10','2025-08-10','16:00','19:30','comercial','Brasil','Argentina','rio de janeiro.webp','125000.00','9/10'),(3,'Aeroparque (AEP)','París (CDG)','2025-09-12','2025-09-13','18:20','12:15','París (CDG)','Aeroparque (AEP)','2025-09-25','2025-09-26','21:00','11:00','vip','Francia','Argentina','paris.webp','98000.00','8/10'),(4,'Mendoza (MDZ)','París (ORY)','2025-10-05','2025-10-06','23:45','17:10','París (ORY)','Mendoza (MDZ)','2025-10-19','2025-10-20','20:00','13:25','económico','Francia','Argentina','paris 2.webp','87000.00','8/10'),(5,'Salta (SLA)','Ciudad de México (MEX)','2025-11-01','2025-11-01','06:30','14:50','Ciudad de México (MEX)','Salta (SLA)','2025-11-14','2025-11-15','22:00','06:15','comercial','México','Argentina','ciudad de mexico.webp','79000.00','7/10'),(6,'Rosario (ROS)','Cancún (CUN)','2025-12-20','2025-12-20','05:15','13:30','Cancún (CUN)','Rosario (ROS)','2026-01-03','2026-01-03','17:00','01:10','vip','México','Argentina','cancun.webp','83000.00','8/10'),(7,'Ezeiza (EZE)','Fortaleza (FOR)','2025-07-28','2025-07-28','10:00','14:00','Fortaleza (FOR)','Ezeiza (EZE)','2025-08-04','2025-08-04','13:30','17:15','económico','Brasil','Argentina','fortaleza.webp','112000.00','9/10'),(8,'Córdoba (COR)','París (CDG)','2025-08-20','2025-08-21','19:00','13:00','París (CDG)','Córdoba (COR)','2025-09-03','2025-09-04','20:30','12:25','vip','Francia','Argentina','paris 3.webp','137000.00','8/10'),(9,'Mendoza (MDZ)','Marsella (MRS)','2025-09-07','2025-09-08','22:15','15:50','Marsella (MRS)','Mendoza (MDZ)','2025-09-21','2025-09-22','23:10','14:30','comercial','Francia','Argentina','marsella.webp','120500.00','8/10'),(10,'Salta (SLA)','Recife (REC)','2025-10-10','2025-10-10','08:45','12:30','Recife (REC)','Salta (SLA)','2025-10-17','2025-10-17','15:00','18:40','económico','Brasil','Argentina','recife.webp','158000.00','9/10'),(11,'Aeroparque (AEP)','Ciudad de México (MEX)','2025-11-05','2025-11-05','04:30','13:15','Ciudad de México (MEX)','Aeroparque (AEP)','2025-11-19','2025-11-19','20:45','06:10','comercial','México','Argentina','ciudad de mexixo 2.webp','220000.00','10/10'),(12,'Rosario (ROS)','Río de Janeiro (GIG)','2025-12-01','2025-12-01','13:00','16:30','Río de Janeiro (GIG)','Rosario (ROS)','2025-12-08','2025-12-08','11:15','14:40','vip','Brasil','Argentina','rio de janeiro 2.webp','245000.00','9/10'),(13,'Córdoba (COR)','Cancún (CUN)','2025-12-18','2025-12-18','07:10','14:45','Cancún (CUN)','Córdoba (COR)','2026-01-02','2026-01-02','16:30','00:50','económico','México','Argentina','cancun 2.jpeg','239000.00','8/10'),(14,'Salta (SLA)','Salvador (SSA)','2025-09-14','2025-09-14','06:00','10:05','Salvador (SSA)','Salta (SLA)','2025-09-21','2025-09-21','12:15','16:20','comercial','Brasil','Argentina','salvador.webp','250000.00','10/10'),(15,'Ezeiza (EZE)','Lyon (LYS)','2025-10-25','2025-10-26','21:30','17:00','Lyon (LYS)','Ezeiza (EZE)','2025-11-09','2025-11-10','19:45','14:20','vip','Francia','Argentina','lyon.webp','230000.00','9/10');
/*!40000 ALTER TABLE `vuelos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-06 19:12:42
