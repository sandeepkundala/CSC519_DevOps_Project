-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: iTrust2
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AppointmentRequests`
--

DROP TABLE IF EXISTS `AppointmentRequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AppointmentRequests` (
  `id` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `hcp_id` varchar(100) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlpa5tri2ufo8t7bt7nusa1pss` (`hcp_id`),
  KEY `FKo65c0ooyqou8d1x56y37u1nau` (`patient_id`),
  CONSTRAINT `FKlpa5tri2ufo8t7bt7nusa1pss` FOREIGN KEY (`hcp_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKo65c0ooyqou8d1x56y37u1nau` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppointmentRequests`
--

LOCK TABLES `AppointmentRequests` WRITE;
/*!40000 ALTER TABLE `AppointmentRequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `AppointmentRequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BasicHealthMetrics`
--

DROP TABLE IF EXISTS `BasicHealthMetrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BasicHealthMetrics` (
  `id` bigint(20) NOT NULL,
  `diastolic` int(11) DEFAULT NULL,
  `hdl` int(11) DEFAULT NULL,
  `headCircumference` float DEFAULT NULL,
  `height` float DEFAULT NULL,
  `houseSmokingStatus` int(11) DEFAULT NULL,
  `ldl` int(11) DEFAULT NULL,
  `patientSmokingStatus` int(11) DEFAULT NULL,
  `systolic` int(11) DEFAULT NULL,
  `tri` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `hcp_id` varchar(100) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd9uamofafbqloq2v2j2o4f0pg` (`hcp_id`),
  KEY `FKj6od5nqw6nvjgmpuilsfj3ad` (`patient_id`),
  CONSTRAINT `FKd9uamofafbqloq2v2j2o4f0pg` FOREIGN KEY (`hcp_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKj6od5nqw6nvjgmpuilsfj3ad` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BasicHealthMetrics`
--

LOCK TABLES `BasicHealthMetrics` WRITE;
/*!40000 ALTER TABLE `BasicHealthMetrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `BasicHealthMetrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BloodSugarDiaryEntries`
--

DROP TABLE IF EXISTS `BloodSugarDiaryEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BloodSugarDiaryEntries` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `fastingLevel` int(11) DEFAULT NULL,
  `firstLevel` int(11) DEFAULT NULL,
  `secondLevel` int(11) DEFAULT NULL,
  `thirdLevel` int(11) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKg2lof8kd38p2vv48wdm9capi6` (`patient_id`),
  CONSTRAINT `FKg2lof8kd38p2vv48wdm9capi6` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`self_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BloodSugarDiaryEntries`
--

LOCK TABLES `BloodSugarDiaryEntries` WRITE;
/*!40000 ALTER TABLE `BloodSugarDiaryEntries` DISABLE KEYS */;
/*!40000 ALTER TABLE `BloodSugarDiaryEntries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BloodSugarLimits`
--

DROP TABLE IF EXISTS `BloodSugarLimits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BloodSugarLimits` (
  `id` bigint(20) NOT NULL,
  `fastingLimit` int(11) NOT NULL,
  `mealLimit` int(11) NOT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrg3yjyrsjd5ceohxphsskxb2o` (`patient_id`),
  CONSTRAINT `FKrg3yjyrsjd5ceohxphsskxb2o` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`self_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BloodSugarLimits`
--

LOCK TABLES `BloodSugarLimits` WRITE;
/*!40000 ALTER TABLE `BloodSugarLimits` DISABLE KEYS */;
/*!40000 ALTER TABLE `BloodSugarLimits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diagnoses`
--

DROP TABLE IF EXISTS `Diagnoses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Diagnoses` (
  `id` bigint(20) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `code_id` bigint(20) DEFAULT NULL,
  `visit_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKthsk14tdxoeeadlpvkot8fdhb` (`code_id`),
  KEY `FKjm5cnpdmv6x9iajrypt72lguy` (`visit_id`),
  CONSTRAINT `FKjm5cnpdmv6x9iajrypt72lguy` FOREIGN KEY (`visit_id`) REFERENCES `GeneralCheckups` (`id`),
  CONSTRAINT `FKthsk14tdxoeeadlpvkot8fdhb` FOREIGN KEY (`code_id`) REFERENCES `ICDCodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diagnoses`
--

LOCK TABLES `Diagnoses` WRITE;
/*!40000 ALTER TABLE `Diagnoses` DISABLE KEYS */;
/*!40000 ALTER TABLE `Diagnoses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Drugs`
--

DROP TABLE IF EXISTS `Drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Drugs` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Drugs`
--

LOCK TABLES `Drugs` WRITE;
/*!40000 ALTER TABLE `Drugs` DISABLE KEYS */;
INSERT INTO `Drugs` VALUES (5,'1000-0001-10','atypical antipsychotic and antidepressant','Quetiane Fumarate');
/*!40000 ALTER TABLE `Drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FoodDiaryEntry`
--

DROP TABLE IF EXISTS `FoodDiaryEntry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FoodDiaryEntry` (
  `id` bigint(20) NOT NULL,
  `calories` int(11) DEFAULT NULL,
  `carbs` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `fat` int(11) DEFAULT NULL,
  `fiber` int(11) DEFAULT NULL,
  `food` varchar(255) DEFAULT NULL,
  `mealType` varchar(255) DEFAULT NULL,
  `patient` varchar(255) DEFAULT NULL,
  `protein` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `sodium` int(11) DEFAULT NULL,
  `sugars` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FoodDiaryEntry`
--

LOCK TABLES `FoodDiaryEntry` WRITE;
/*!40000 ALTER TABLE `FoodDiaryEntry` DISABLE KEYS */;
/*!40000 ALTER TABLE `FoodDiaryEntry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GeneralCheckups`
--

DROP TABLE IF EXISTS `GeneralCheckups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GeneralCheckups` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `appointment_id` bigint(20) DEFAULT NULL,
  `basichealthmetrics_id` bigint(20) DEFAULT NULL,
  `hcp_id` varchar(100) DEFAULT NULL,
  `hospital_id` varchar(100) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtgti6uflcm2q9uvfx4obmpwv4` (`appointment_id`),
  KEY `FKqtpf2nfiuf47019rc8gnaeb6v` (`basichealthmetrics_id`),
  KEY `FKplofss0lwup9mbnu0abrtalxx` (`hcp_id`),
  KEY `FK9tghbxo0xq6bba8p1rp7rbecg` (`hospital_id`),
  KEY `FK5fa5nrrfo22p8q5xiptgh83x5` (`patient_id`),
  CONSTRAINT `FK5fa5nrrfo22p8q5xiptgh83x5` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FK9tghbxo0xq6bba8p1rp7rbecg` FOREIGN KEY (`hospital_id`) REFERENCES `Hospitals` (`name`),
  CONSTRAINT `FKplofss0lwup9mbnu0abrtalxx` FOREIGN KEY (`hcp_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKqtpf2nfiuf47019rc8gnaeb6v` FOREIGN KEY (`basichealthmetrics_id`) REFERENCES `BasicHealthMetrics` (`id`),
  CONSTRAINT `FKtgti6uflcm2q9uvfx4obmpwv4` FOREIGN KEY (`appointment_id`) REFERENCES `AppointmentRequests` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GeneralCheckups`
--

LOCK TABLES `GeneralCheckups` WRITE;
/*!40000 ALTER TABLE `GeneralCheckups` DISABLE KEYS */;
/*!40000 ALTER TABLE `GeneralCheckups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GeneralOphthalmology`
--

DROP TABLE IF EXISTS `GeneralOphthalmology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GeneralOphthalmology` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `axisOD` int(11) DEFAULT NULL,
  `axisOS` int(11) DEFAULT NULL,
  `cylinderOD` double DEFAULT NULL,
  `cylinderOS` double DEFAULT NULL,
  `sphereOD` double DEFAULT NULL,
  `sphereOS` double DEFAULT NULL,
  `visualAcuityOD` int(11) DEFAULT NULL,
  `visualAcuityOS` int(11) DEFAULT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `appointment_id` bigint(20) DEFAULT NULL,
  `basichealthmetrics_id` bigint(20) DEFAULT NULL,
  `hcp_id` varchar(100) DEFAULT NULL,
  `hospital_id` varchar(100) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtcx79uvv1o4wrp9xqdk3hcap2` (`appointment_id`),
  KEY `FK6svu0my7r662s5sn2d7cgf1jq` (`basichealthmetrics_id`),
  KEY `FKfeh4gtxe0s4kr52i7u5i8tkum` (`hcp_id`),
  KEY `FKc5kn71vr8tbt5ty5cc7pfrbgf` (`hospital_id`),
  KEY `FKr2whnupl6f7k12gx78f5lhdx9` (`patient_id`),
  CONSTRAINT `FK6svu0my7r662s5sn2d7cgf1jq` FOREIGN KEY (`basichealthmetrics_id`) REFERENCES `BasicHealthMetrics` (`id`),
  CONSTRAINT `FKc5kn71vr8tbt5ty5cc7pfrbgf` FOREIGN KEY (`hospital_id`) REFERENCES `Hospitals` (`name`),
  CONSTRAINT `FKfeh4gtxe0s4kr52i7u5i8tkum` FOREIGN KEY (`hcp_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKr2whnupl6f7k12gx78f5lhdx9` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKtcx79uvv1o4wrp9xqdk3hcap2` FOREIGN KEY (`appointment_id`) REFERENCES `AppointmentRequests` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GeneralOphthalmology`
--

LOCK TABLES `GeneralOphthalmology` WRITE;
/*!40000 ALTER TABLE `GeneralOphthalmology` DISABLE KEYS */;
/*!40000 ALTER TABLE `GeneralOphthalmology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hospitals`
--

DROP TABLE IF EXISTS `Hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hospitals` (
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospitals`
--

LOCK TABLES `Hospitals` WRITE;
/*!40000 ALTER TABLE `Hospitals` DISABLE KEYS */;
INSERT INTO `Hospitals` VALUES ('General Hospital','123 Main St','NC','12345');
/*!40000 ALTER TABLE `Hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ICDCodes`
--

DROP TABLE IF EXISTS `ICDCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ICDCodes` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ICDCodes`
--

LOCK TABLES `ICDCodes` WRITE;
/*!40000 ALTER TABLE `ICDCodes` DISABLE KEYS */;
INSERT INTO `ICDCodes` VALUES (6,'E11.9','Type 2 Diabetes'),(7,'R73.03','Prediabetes');
/*!40000 ALTER TABLE `ICDCodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOINCCodes`
--

DROP TABLE IF EXISTS `LOINCCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOINCCodes` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `commonName` varchar(255) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `scale` varchar(255) DEFAULT NULL,
  `result_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKg096u65wbjmwxny136tptntlr` (`result_id`),
  CONSTRAINT `FKg096u65wbjmwxny136tptntlr` FOREIGN KEY (`result_id`) REFERENCES `LOINCResult` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOINCCodes`
--

LOCK TABLES `LOINCCodes` WRITE;
/*!40000 ALTER TABLE `LOINCCodes` DISABLE KEYS */;
INSERT INTO `LOINCCodes` VALUES (9,'20436-2','Glucose 2 Hr After Glucose, Blood','Glucose^2H post dose glucose','MCnc','QUANTITATIVE',8),(11,'4548-4','HbA1c, Blood','Hemoglobin A1c/Hemoglobin.total','MFr','QUANTITATIVE',10),(13,'1558-6','Glucose After Fast, Blood','Glucose^post CFst','MCnc','QUANTITATIVE',12);
/*!40000 ALTER TABLE `LOINCCodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOINCResult`
--

DROP TABLE IF EXISTS `LOINCResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOINCResult` (
  `DTYPE` varchar(31) NOT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOINCResult`
--

LOCK TABLES `LOINCResult` WRITE;
/*!40000 ALTER TABLE `LOINCResult` DISABLE KEYS */;
INSERT INTO `LOINCResult` VALUES ('QuantitativeLOINCResult',8),('QuantitativeLOINCResult',10),('QuantitativeLOINCResult',12);
/*!40000 ALTER TABLE `LOINCResult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LabProcedures`
--

DROP TABLE IF EXISTS `LabProcedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LabProcedures` (
  `id` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `labtech` varchar(100) DEFAULT NULL,
  `LOINC_code` bigint(20) DEFAULT NULL,
  `patient` varchar(100) DEFAULT NULL,
  `suggestedDiagnosis` bigint(20) DEFAULT NULL,
  `visit` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKn8ctd2oj7knwaxxfakrmwybj6` (`labtech`),
  KEY `FKq97sa9kb1vkse9jbn0s38drei` (`LOINC_code`),
  KEY `FKd9netwr78cspphyqtctsdy9cl` (`patient`),
  KEY `FKev74nk6ig1t5h0i4h4tg5ar9q` (`suggestedDiagnosis`),
  KEY `FKf1qdex4yna7yac0e29xylgqt7` (`visit`),
  CONSTRAINT `FKd9netwr78cspphyqtctsdy9cl` FOREIGN KEY (`patient`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKev74nk6ig1t5h0i4h4tg5ar9q` FOREIGN KEY (`suggestedDiagnosis`) REFERENCES `ICDCodes` (`id`),
  CONSTRAINT `FKf1qdex4yna7yac0e29xylgqt7` FOREIGN KEY (`visit`) REFERENCES `GeneralCheckups` (`id`),
  CONSTRAINT `FKn8ctd2oj7knwaxxfakrmwybj6` FOREIGN KEY (`labtech`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKq97sa9kb1vkse9jbn0s38drei` FOREIGN KEY (`LOINC_code`) REFERENCES `LOINCCodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LabProcedures`
--

LOCK TABLES `LabProcedures` WRITE;
/*!40000 ALTER TABLE `LabProcedures` DISABLE KEYS */;
/*!40000 ALTER TABLE `LabProcedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LogEntries`
--

DROP TABLE IF EXISTS `LogEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogEntries` (
  `id` bigint(20) NOT NULL,
  `logCode` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `primaryUser` varchar(255) DEFAULT NULL,
  `secondaryUser` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LogEntries`
--

LOCK TABLES `LogEntries` WRITE;
/*!40000 ALTER TABLE `LogEntries` DISABLE KEYS */;
INSERT INTO `LogEntries` VALUES (14,1,NULL,'admin',NULL,'2020-04-28 14:10:50'),(15,58,NULL,'admin',NULL,'2020-04-28 14:10:51'),(16,58,NULL,'admin',NULL,'2020-04-28 14:11:04');
/*!40000 ALTER TABLE `LogEntries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginAttempts`
--

DROP TABLE IF EXISTS `LoginAttempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoginAttempts` (
  `id` bigint(20) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6me6sh9op6gntvqnqqqiev95q` (`user_id`),
  CONSTRAINT `FK6me6sh9op6gntvqnqqqiev95q` FOREIGN KEY (`user_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginAttempts`
--

LOCK TABLES `LoginAttempts` WRITE;
/*!40000 ALTER TABLE `LoginAttempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginAttempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginBans`
--

DROP TABLE IF EXISTS `LoginBans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoginBans` (
  `id` bigint(20) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpmi5daj2jt8w5gq9maxjpro1f` (`user_id`),
  CONSTRAINT `FKpmi5daj2jt8w5gq9maxjpro1f` FOREIGN KEY (`user_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginBans`
--

LOCK TABLES `LoginBans` WRITE;
/*!40000 ALTER TABLE `LoginBans` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginBans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginLockouts`
--

DROP TABLE IF EXISTS `LoginLockouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoginLockouts` (
  `id` bigint(20) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhndsii960xs59bv7a7x5669ii` (`user_id`),
  CONSTRAINT `FKhndsii960xs59bv7a7x5669ii` FOREIGN KEY (`user_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginLockouts`
--

LOCK TABLES `LoginLockouts` WRITE;
/*!40000 ALTER TABLE `LoginLockouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginLockouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OphthalmologySurgery`
--

DROP TABLE IF EXISTS `OphthalmologySurgery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OphthalmologySurgery` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `axisOD` int(11) DEFAULT NULL,
  `axisOS` int(11) DEFAULT NULL,
  `cylinderOD` double DEFAULT NULL,
  `cylinderOS` double DEFAULT NULL,
  `sphereOD` double DEFAULT NULL,
  `sphereOS` double DEFAULT NULL,
  `visualAcuityOD` int(11) DEFAULT NULL,
  `visualAcuityOS` int(11) DEFAULT NULL,
  `surgeryType` int(11) DEFAULT NULL,
  `appointment_id` bigint(20) DEFAULT NULL,
  `basichealthmetrics_id` bigint(20) DEFAULT NULL,
  `hcp_id` varchar(100) DEFAULT NULL,
  `hospital_id` varchar(100) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2ab5y8krlqw4407jo9je2rodh` (`appointment_id`),
  KEY `FK64ijwgpf2cbt4t6vcwyj0vy77` (`basichealthmetrics_id`),
  KEY `FK43k7w4nn8hxf36s3xonve9l5v` (`hcp_id`),
  KEY `FKg3nwmi2eh9lxpys9gom75nsvx` (`hospital_id`),
  KEY `FK526jd5m6bguykj27g8jbl2idt` (`patient_id`),
  CONSTRAINT `FK2ab5y8krlqw4407jo9je2rodh` FOREIGN KEY (`appointment_id`) REFERENCES `AppointmentRequests` (`id`),
  CONSTRAINT `FK43k7w4nn8hxf36s3xonve9l5v` FOREIGN KEY (`hcp_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FK526jd5m6bguykj27g8jbl2idt` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FK64ijwgpf2cbt4t6vcwyj0vy77` FOREIGN KEY (`basichealthmetrics_id`) REFERENCES `BasicHealthMetrics` (`id`),
  CONSTRAINT `FKg3nwmi2eh9lxpys9gom75nsvx` FOREIGN KEY (`hospital_id`) REFERENCES `Hospitals` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OphthalmologySurgery`
--

LOCK TABLES `OphthalmologySurgery` WRITE;
/*!40000 ALTER TABLE `OphthalmologySurgery` DISABLE KEYS */;
/*!40000 ALTER TABLE `OphthalmologySurgery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERSONAL_REPRESENTATIVES`
--

DROP TABLE IF EXISTS `PERSONAL_REPRESENTATIVES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PERSONAL_REPRESENTATIVES` (
  `patient_id` varchar(100) NOT NULL,
  `representative_id` varchar(100) NOT NULL,
  PRIMARY KEY (`patient_id`,`representative_id`),
  KEY `FK4xcw5y8obck13wkbeja8cxy6d` (`representative_id`),
  CONSTRAINT `FK4xcw5y8obck13wkbeja8cxy6d` FOREIGN KEY (`representative_id`) REFERENCES `Patients` (`self_id`),
  CONSTRAINT `FKthu0xxghbfmojk34tnmg17qxd` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`self_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERSONAL_REPRESENTATIVES`
--

LOCK TABLES `PERSONAL_REPRESENTATIVES` WRITE;
/*!40000 ALTER TABLE `PERSONAL_REPRESENTATIVES` DISABLE KEYS */;
/*!40000 ALTER TABLE `PERSONAL_REPRESENTATIVES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PasswordResetTokens`
--

DROP TABLE IF EXISTS `PasswordResetTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PasswordResetTokens` (
  `id` bigint(20) NOT NULL,
  `creationTime` bigint(20) NOT NULL,
  `tempPassword` varchar(255) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdtqvlc6is6k5ibp1xc1nshrc8` (`user_id`),
  CONSTRAINT `FKdtqvlc6is6k5ibp1xc1nshrc8` FOREIGN KEY (`user_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PasswordResetTokens`
--

LOCK TABLES `PasswordResetTokens` WRITE;
/*!40000 ALTER TABLE `PasswordResetTokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `PasswordResetTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patients`
--

DROP TABLE IF EXISTS `Patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patients` (
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `bloodType` varchar(255) DEFAULT NULL,
  `causeOfDeath` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `dateOfBirth` datetime DEFAULT NULL,
  `dateOfDeath` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ethnicity` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `preferredName` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `self_id` varchar(100) NOT NULL,
  `father_id` varchar(100) DEFAULT NULL,
  `mother_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`self_id`),
  KEY `FK8s22h2pw102ce5ytcmqmhegp3` (`father_id`),
  KEY `FK3aemk5yjohgj9y6j4lq57g4o5` (`mother_id`),
  CONSTRAINT `FK3aemk5yjohgj9y6j4lq57g4o5` FOREIGN KEY (`mother_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FK8s22h2pw102ce5ytcmqmhegp3` FOREIGN KEY (`father_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKe0d1x2xac4nte49udxrwdiew5` FOREIGN KEY (`self_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patients`
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` VALUES (NULL,NULL,NULL,NULL,NULL,'2007-04-27 23:00:00',NULL,NULL,NULL,'AliceThirteen',NULL,NULL,'Smith',NULL,NULL,NULL,NULL,'AliceThirteen',NULL,NULL),(NULL,NULL,NULL,NULL,NULL,'1980-04-27 23:00:00',NULL,NULL,NULL,'Billy',NULL,NULL,'Bob',NULL,NULL,NULL,NULL,'BillyBob',NULL,NULL),(NULL,NULL,NULL,NULL,NULL,'2016-04-27 23:00:00',NULL,NULL,NULL,'BobTheFourYearOld',NULL,NULL,'Smith',NULL,NULL,NULL,NULL,'BobTheFourYearOld',NULL,NULL),(NULL,NULL,NULL,NULL,NULL,'1980-04-27 23:00:00',NULL,NULL,NULL,'Jill',NULL,NULL,'Bob',NULL,NULL,NULL,NULL,'JillBob',NULL,NULL),(NULL,NULL,NULL,NULL,NULL,'2019-04-27 23:00:00',NULL,NULL,NULL,'TimTheOneYearOld',NULL,NULL,'Smith',NULL,NULL,NULL,NULL,'TimTheOneYearOld',NULL,NULL);
/*!40000 ALTER TABLE `Patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personnel`
--

DROP TABLE IF EXISTS `Personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personnel` (
  `id` bigint(20) NOT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `self_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa9l63705rm5c4tf50y9h9x8rp` (`self_id`),
  CONSTRAINT `FKa9l63705rm5c4tf50y9h9x8rp` FOREIGN KEY (`self_id`) REFERENCES `Users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personnel`
--

LOCK TABLES `Personnel` WRITE;
/*!40000 ALTER TABLE `Personnel` DISABLE KEYS */;
INSERT INTO `Personnel` VALUES (1,'1234 Road St.',NULL,'town','csc326.201.1@gmail.com',_binary '\0','HCP','HCP','111-222-3333',NULL,'AK','12345','hcp'),(2,NULL,NULL,NULL,NULL,_binary '\0','Knight','Solaire',NULL,NULL,NULL,NULL,'knightSolaire'),(3,NULL,NULL,NULL,NULL,_binary '\0','Lab','Technician',NULL,NULL,NULL,NULL,'labtech'),(4,NULL,NULL,NULL,NULL,_binary '\0','Larry','Teacher',NULL,NULL,NULL,NULL,'larrytech');
/*!40000 ALTER TABLE `Personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prescriptions`
--

DROP TABLE IF EXISTS `Prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prescriptions` (
  `id` bigint(20) NOT NULL,
  `dosage` int(11) NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `renewals` int(11) NOT NULL,
  `startDate` datetime DEFAULT NULL,
  `drug_id` bigint(20) DEFAULT NULL,
  `patient_id` varchar(100) DEFAULT NULL,
  `prescriptions_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrr7q2rw34mv2h8p24dwo2sw39` (`drug_id`),
  KEY `FK11c0dywqeqm53244c088xriq0` (`patient_id`),
  KEY `FKkhctha3d1ti34dbaplmn8tsyk` (`prescriptions_id`),
  CONSTRAINT `FK11c0dywqeqm53244c088xriq0` FOREIGN KEY (`patient_id`) REFERENCES `Users` (`username`),
  CONSTRAINT `FKkhctha3d1ti34dbaplmn8tsyk` FOREIGN KEY (`prescriptions_id`) REFERENCES `GeneralCheckups` (`id`),
  CONSTRAINT `FKrr7q2rw34mv2h8p24dwo2sw39` FOREIGN KEY (`drug_id`) REFERENCES `Drugs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prescriptions`
--

LOCK TABLES `Prescriptions` WRITE;
/*!40000 ALTER TABLE `Prescriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QualitativeLOINCResult_resultEntries`
--

DROP TABLE IF EXISTS `QualitativeLOINCResult_resultEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QualitativeLOINCResult_resultEntries` (
  `QualitativeLOINCResult_id` bigint(20) NOT NULL,
  `icd_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  KEY `FKj5v90k5cus9qwi7s21n9q77ct` (`icd_id`),
  KEY `FKt20aq6o1nrhhtoimh35a912hj` (`QualitativeLOINCResult_id`),
  CONSTRAINT `FKj5v90k5cus9qwi7s21n9q77ct` FOREIGN KEY (`icd_id`) REFERENCES `ICDCodes` (`id`),
  CONSTRAINT `FKt20aq6o1nrhhtoimh35a912hj` FOREIGN KEY (`QualitativeLOINCResult_id`) REFERENCES `LOINCResult` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QualitativeLOINCResult_resultEntries`
--

LOCK TABLES `QualitativeLOINCResult_resultEntries` WRITE;
/*!40000 ALTER TABLE `QualitativeLOINCResult_resultEntries` DISABLE KEYS */;
/*!40000 ALTER TABLE `QualitativeLOINCResult_resultEntries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QuantitativeLOINCResult_resultRanges`
--

DROP TABLE IF EXISTS `QuantitativeLOINCResult_resultRanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuantitativeLOINCResult_resultRanges` (
  `QuantitativeLOINCResult_id` bigint(20) NOT NULL,
  `icd_id` bigint(20) DEFAULT NULL,
  `max` float DEFAULT NULL,
  `min` float DEFAULT NULL,
  KEY `FKegy2iicpobqfn9fkwqbwhtvok` (`icd_id`),
  KEY `FK8bxt649q99k8cxq5jjxigo3ip` (`QuantitativeLOINCResult_id`),
  CONSTRAINT `FK8bxt649q99k8cxq5jjxigo3ip` FOREIGN KEY (`QuantitativeLOINCResult_id`) REFERENCES `LOINCResult` (`id`),
  CONSTRAINT `FKegy2iicpobqfn9fkwqbwhtvok` FOREIGN KEY (`icd_id`) REFERENCES `ICDCodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuantitativeLOINCResult_resultRanges`
--

LOCK TABLES `QuantitativeLOINCResult_resultRanges` WRITE;
/*!40000 ALTER TABLE `QuantitativeLOINCResult_resultRanges` DISABLE KEYS */;
INSERT INTO `QuantitativeLOINCResult_resultRanges` VALUES (8,NULL,139,0),(8,7,199,140),(8,6,5000,200),(10,NULL,5.6,0),(10,7,6.4,5.7),(10,6,100,6.5),(12,NULL,99,0),(12,7,125,100),(12,6,5000,126);
/*!40000 ALTER TABLE `QuantitativeLOINCResult_resultRanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `username` varchar(255) NOT NULL,
  `enabled` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('admin',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_ADMIN'),('AliceThirteen',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('alminister',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_ADMIN'),('BillyBob',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('bobbyOD',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_OD'),('BobTheFourYearOld',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('er',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_ER'),('hcp',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('jbean',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('JillBob',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('knightSolaire',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_ER'),('labtech',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_LABTECH'),('larrytech',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_LABTECH'),('lockoutUser',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('lockoutUser2',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('nsanderson',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('patient',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT'),('pwtestuser1',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('pwtestuser2',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('pwtestuser3',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('pwtestuser4',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('pwtestuser5',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('robortOPH',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_OPH'),('svang',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_HCP'),('TimTheOneYearOld',1,'$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.','ROLE_PATIENT');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17),(17);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-28 15:12:24
