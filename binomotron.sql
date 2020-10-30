-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 30, 2020 at 01:30 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `binomotron`
--
CREATE DATABASE IF NOT EXISTS `binomotron` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `binomotron`;

-- --------------------------------------------------------

--
-- Table structure for table `apprenants`
--

CREATE TABLE `apprenants` (
  `id_apprenant` int(2) NOT NULL,
  `prenom_apprenant` varchar(32) NOT NULL,
  `nom_apprenant` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `apprenants`
--

INSERT INTO `apprenants` (`id_apprenant`, `prenom_apprenant`, `nom_apprenant`) VALUES
(1, 'Luigi', 'BOKALLI'),
(2, 'Amaury', 'BONNEAU'),
(3, 'Thomas', 'CHAIGNEAU'),
(4, 'Erwan', 'CLOATRE'),
(5, 'Julien', 'FURIGA'),
(6, 'Céline', 'GUILLEN'),
(7, 'Pereg', 'HERGOUALC\'H'),
(8, 'Jamal', 'IBANNI'),
(9, 'Christelle', 'KARFAOUI'),
(10, 'Baptiste', 'LE BERRE'),
(11, 'Baptiste', 'LE GOFF'),
(12, 'Jérémy', 'LE JONCOUR'),
(13, 'Patricia', 'LE MOAL'),
(14, 'Ludivine', 'MAINTIER'),
(15, 'Christian', 'MBARGA MVOGO'),
(16, 'Eva', 'MOULARD'),
(17, 'Aude', 'PERTRON'),
(18, 'Ronan', 'RIOUAL'),
(19, 'Paul', 'SABIA'),
(20, 'Guillaume', 'VERPOEST');

-- --------------------------------------------------------

--
-- Table structure for table `apprenant_groupe_projet`
--

CREATE TABLE `apprenant_groupe_projet` (
  `id_projet` int(11) NOT NULL,
  `id_apprenant` int(11) NOT NULL,
  `id_groupe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `groupes`
--

CREATE TABLE `groupes` (
  `id_groupe` int(11) NOT NULL,
  `libelle_groupe` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groupes`
--

INSERT INTO `groupes` (`id_groupe`, `libelle_groupe`) VALUES
(1, 'Groupe 1'),
(2, 'Groupe 2'),
(3, 'Groupe 3'),
(4, 'Groupe 4'),
(5, 'Groupe 5'),
(6, 'Groupe 6'),
(7, 'Groupe 7'),
(8, 'Groupe 8'),
(9, 'Groupe 9'),
(10, 'Groupe 10');

-- --------------------------------------------------------

--
-- Table structure for table `projets`
--

CREATE TABLE `projets` (
  `id_projet` int(11) NOT NULL,
  `nom_projet` varchar(50) NOT NULL,
  `date_projet` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apprenants`
--
ALTER TABLE `apprenants`
  ADD PRIMARY KEY (`id_apprenant`);

--
-- Indexes for table `apprenant_groupe_projet`
--
ALTER TABLE `apprenant_groupe_projet`
  ADD KEY `id_projet` (`id_projet`),
  ADD KEY `id_people` (`id_apprenant`),
  ADD KEY `id_groupe` (`id_groupe`);

--
-- Indexes for table `groupes`
--
ALTER TABLE `groupes`
  ADD PRIMARY KEY (`id_groupe`);

--
-- Indexes for table `projets`
--
ALTER TABLE `projets`
  ADD PRIMARY KEY (`id_projet`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apprenants`
--
ALTER TABLE `apprenants`
  MODIFY `id_apprenant` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `groupes`
--
ALTER TABLE `groupes`
  MODIFY `id_groupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projets`
--
ALTER TABLE `projets`
  MODIFY `id_projet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `apprenant_groupe_projet`
--
ALTER TABLE `apprenant_groupe_projet`
  ADD CONSTRAINT `apprenant_groupe_projet_ibfk_1` FOREIGN KEY (`id_projet`) REFERENCES `projets` (`id_projet`),
  ADD CONSTRAINT `apprenant_groupe_projet_ibfk_2` FOREIGN KEY (`id_apprenant`) REFERENCES `apprenants` (`id_apprenant`),
  ADD CONSTRAINT `apprenant_groupe_projet_ibfk_3` FOREIGN KEY (`id_groupe`) REFERENCES `groupes` (`id_groupe`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
