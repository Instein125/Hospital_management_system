-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 30, 2022 at 08:48 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE `contract` (
  `Company_name` varchar(50) NOT NULL,
  `Phar_ID` varchar(5) NOT NULL,
  `supervisor_ID` varchar(5) NOT NULL,
  `start_date` varchar(50) DEFAULT NULL,
  `end_date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contract`
--

INSERT INTO `contract` (`Company_name`, `Phar_ID`, `supervisor_ID`, `start_date`, `end_date`) VALUES
('sagarmatha', 'ph004', 'SP005', '2022-07-29', '2024-06-30'),
('sagarmatha', 'ph019', 'SP006', '2022-07-29', '2023-06-30');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Doc_SSN` varchar(5) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Speciality` varchar(30) NOT NULL,
  `Experience` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Doc_SSN`, `Name`, `Speciality`, `Experience`) VALUES
('DC001', 'new1', 'new1', 12),
('DC003', 'new3', 'new3', 17),
('DC004', 'new4', 'new4', 12),
('DC005', 'new4', 'new4', 5);

-- --------------------------------------------------------

--
-- Table structure for table `drug`
--

CREATE TABLE `drug` (
  `Trade_name` varchar(20) NOT NULL,
  `Formula` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `drug`
--

INSERT INTO `drug` (`Trade_name`, `Formula`) VALUES
('new1', 'new1'),
('new2', 'new2'),
('new3', 'new3'),
('new4', 'new4'),
('new5', 'new5');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `SSN` varchar(5) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Address` varchar(30) NOT NULL,
  `Age` int(11) NOT NULL,
  `Doc_SSN` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`SSN`, `Name`, `Address`, `Age`, `Doc_SSN`) VALUES
('PT003', 'new3', 'new3', 56, 'DC004'),
('PT004', 'new4', 'new4', 20, 'DC003'),
('PT007', 'new7', 'new7', 7, 'DC001'),
('PT008', 'new8', 'new8', 17, 'DC001'),
('PT009', 'new9', 'new9', 12, 'DC001'),
('PT010', 'new10', 'new10', 10, 'DC001');

-- --------------------------------------------------------

--
-- Table structure for table `pharmaceutical_company`
--

CREATE TABLE `pharmaceutical_company` (
  `Company_name` varchar(50) NOT NULL,
  `Ph_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmaceutical_company`
--

INSERT INTO `pharmaceutical_company` (`Company_name`, `Ph_number`) VALUES
('recent', 123),
('sagarmatha', 123),
('test2', 855);

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `Phar_ID` varchar(5) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Address` varchar(30) NOT NULL,
  `Ph_number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`Phar_ID`, `Name`, `Address`, `Ph_number`) VALUES
('PH004', 'test23', 'test23', 123564),
('PH009', 'updated', 'updated', 12345),
('PH015', 'updated2', 'updated2', 546),
('PH018', 'test2', 'test2', 123),
('PH019', 'new19', 'new19', 19);

-- --------------------------------------------------------

--
-- Table structure for table `prescribe`
--

CREATE TABLE `prescribe` (
  `SSN` varchar(5) NOT NULL,
  `Doc_SSN` varchar(5) NOT NULL,
  `Trade_name` varchar(20) DEFAULT NULL,
  `Prescribe_date` varchar(50) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prescribe`
--

INSERT INTO `prescribe` (`SSN`, `Doc_SSN`, `Trade_name`, `Prescribe_date`, `Quantity`) VALUES
('PT003', 'DC004', 'new5', '2022-07-28', 10),
('PT004', 'DC003', NULL, NULL, 0),
('PT007', 'DC001', 'new5', '2022-07-28', 10),
('PT008', 'DC001', 'new2', '2022-07-28', 50),
('PT009', 'DC001', 'new4', '2022-07-28', 12),
('PT010', 'DC001', 'new1', '2022-07-28', 50);

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

CREATE TABLE `sell` (
  `Trade_name` varchar(20) NOT NULL,
  `Phar_ID` varchar(5) NOT NULL,
  `Price` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sell`
--

INSERT INTO `sell` (`Trade_name`, `Phar_ID`, `Price`, `Quantity`) VALUES
('new1', 'PH004', 100, 10),
('new1', 'PH004', 100, 10),
('new1', 'PH004', 800, 10),
('new5', 'PH018', 500, 450),
('new3', 'PH009', 500, 50),
('new3', 'PH009', 500, 10),
('new3', 'PH004', 100, 10),
('new1', 'PH004', 100, 100),
('new4', 'PH004', 600, 15);

-- --------------------------------------------------------

--
-- Table structure for table `supervisor`
--

CREATE TABLE `supervisor` (
  `supervisor_ID` varchar(5) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Address` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supervisor`
--

INSERT INTO `supervisor` (`supervisor_ID`, `Name`, `Address`) VALUES
('SP004', 'new', 'new'),
('SP005', 'new4', 'new4'),
('SP006', 'newdata', 'newdata');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD KEY `contract_ibfk_1` (`Company_name`),
  ADD KEY `contract_ibfk_2` (`Phar_ID`),
  ADD KEY `contract_ibfk_3` (`supervisor_ID`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Doc_SSN`);

--
-- Indexes for table `drug`
--
ALTER TABLE `drug`
  ADD PRIMARY KEY (`Trade_name`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`SSN`),
  ADD KEY `patient_ibfk_1` (`Doc_SSN`);

--
-- Indexes for table `pharmaceutical_company`
--
ALTER TABLE `pharmaceutical_company`
  ADD PRIMARY KEY (`Company_name`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`Phar_ID`);

--
-- Indexes for table `prescribe`
--
ALTER TABLE `prescribe`
  ADD KEY `prescribe_ibfk_1` (`SSN`),
  ADD KEY `prescribe_ibfk_2` (`Doc_SSN`),
  ADD KEY `prescribe_ibfk_3` (`Trade_name`);

--
-- Indexes for table `sell`
--
ALTER TABLE `sell`
  ADD KEY `sell_ibfk_1` (`Trade_name`),
  ADD KEY `sell_ibfk_2` (`Phar_ID`);

--
-- Indexes for table `supervisor`
--
ALTER TABLE `supervisor`
  ADD PRIMARY KEY (`supervisor_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`Company_name`) REFERENCES `pharmaceutical_company` (`Company_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contract_ibfk_2` FOREIGN KEY (`Phar_ID`) REFERENCES `pharmacy` (`Phar_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contract_ibfk_3` FOREIGN KEY (`supervisor_ID`) REFERENCES `supervisor` (`supervisor_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`Doc_SSN`) REFERENCES `doctor` (`Doc_SSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prescribe`
--
ALTER TABLE `prescribe`
  ADD CONSTRAINT `prescribe_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `patient` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescribe_ibfk_2` FOREIGN KEY (`Doc_SSN`) REFERENCES `doctor` (`Doc_SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescribe_ibfk_3` FOREIGN KEY (`Trade_name`) REFERENCES `drug` (`Trade_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sell`
--
ALTER TABLE `sell`
  ADD CONSTRAINT `sell_ibfk_1` FOREIGN KEY (`Trade_name`) REFERENCES `drug` (`Trade_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sell_ibfk_2` FOREIGN KEY (`Phar_ID`) REFERENCES `pharmacy` (`Phar_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
