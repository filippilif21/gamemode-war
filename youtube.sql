-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2017 at 04:31 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `youtube`
--

-- --------------------------------------------------------

--
-- Table structure for table `turfs`
--

CREATE TABLE `turfs` (
  `ID` int(11) NOT NULL,
  `MinX` int(11) NOT NULL,
  `MinY` int(11) NOT NULL,
  `MaxX` int(11) NOT NULL,
  `MaxY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL DEFAULT 'name',
  `password` varchar(25) NOT NULL DEFAULT 'name',
  `Admin` tinyint(4) NOT NULL DEFAULT '0',
  `Helper` tinyint(4) NOT NULL DEFAULT '0',
  `Tester` tinyint(4) NOT NULL DEFAULT '0',
  `Level` int(11) NOT NULL DEFAULT '1',
  `ConnectTime` float NOT NULL DEFAULT '0',
  `Age` int(11) NOT NULL DEFAULT '10',
  `PremiumAccount` tinyint(4) NOT NULL DEFAULT '0',
  `Kills` int(11) NOT NULL DEFAULT '0',
  `Deaths` int(11) NOT NULL DEFAULT '0',
  `Money` int(11) NOT NULL DEFAULT '10000',
  `Group2` int(11) NOT NULL DEFAULT '0',
  `GroupRank` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `Admin`, `Helper`, `Tester`, `Level`, `ConnectTime`, `Age`, `PremiumAccount`, `Kills`, `Deaths`, `Money`, `Group2`, `GroupRank`) VALUES
(1, 'Filip[]', 'testtest', 0, 0, 0, 1, 0, 10, 0, 0, 0, 10000, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
