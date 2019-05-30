-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2019 at 07:41 PM
-- Server version: 10.1.33-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dummy`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMonthWiseData` (IN `ch_date` DATETIME, OUT `ch_year` VARCHAR(50))  BEGIN
	select year(ch_date) into ch_year;
    
 INSERT INTO temp_table SELECT 
company_master.company_name,
month(service_provided.date_added) As ch_month,
COUNT(service_provided.service_id) AS Total_service_Count,
SUM( service_master.service_cost ) AS Total_service_Cost 
FROM service_master INNER JOIN service_provided ON service_master.id = service_provided.service_id 
INNER JOIN  company_master ON service_provided.company_id = company_master.id where year(date_added) = ch_year
GROUP BY service_provided.company_id,ch_month order by ch_month desc;


select Company_Name,
	sum(case when ch_month = '1' then total_service_cost  else 0  end) 'january(Total service count)',
	sum(case when ch_month = '1' then total_service_count  else 0  end) 'january(Total service cost)',
	sum(case when ch_month = '2' then total_service_cost else 0 end) 'February(Total service count)',
	sum(case when ch_month = '2' then total_service_count  else 0  end) 'February(Total service cost)',
	sum(case when ch_month = '3' then total_service_cost else 0 end) 'March(Total service count)',
	sum(case when ch_month = '3' then total_service_count  else 0  end) 'March(Total service cost)',
	sum(case when ch_month = '4' then total_service_cost else 0 end) 'April(Total service count)',
	sum(case when ch_month = '4' then total_service_count else 0 end) 'April(Total service cost)',
	sum(case when ch_month = '5' then total_service_cost else 0 end) 'May(Total service count)',
	sum(case when ch_month = '5' then total_service_count else 0 end) 'May(Total service cost)',
	sum(case when ch_month = '6' then total_service_cost else 0 end) 'June(Total service count)',
	sum(case when ch_month = '6' then total_service_count else 0 end) 'June(Total service cost)',
	sum(case when ch_month = '7' then total_service_cost else 0 end) 'July(Total service count)',
	sum(case when ch_month = '7' then total_service_count else 0 end) 'July(Total service cost)',
	sum(case when ch_month = '8' then total_service_cost else 0 end) 'August(Total service count)',
	sum(case when ch_month = '8' then total_service_count else 0 end) 'August(Total service cost)',
	sum(case when ch_month = '9' then total_service_cost else 0 end) 'September(Total service count)',
	sum(case when ch_month = '9' then total_service_count else 0 end) 'September(Total service cost)',
	sum(case when ch_month = '10' then total_service_cost else 0 end) 'October(Total service count)',
	sum(case when ch_month = '10' then total_service_count else 0 end) 'October(Total service cost)',
	sum(case when ch_month = '11' then total_service_cost else 0 end) 'November(Total service count)',
	sum(case when ch_month = '11' then total_service_count else 0 end) 'November(Total service cost)',
	sum(case when ch_month = '12' then total_service_cost else 0 end) 'December(Total service count)',
	sum(case when ch_month = '12' then total_service_count else 0 end) 'December(Total service cost)'
from temp_table
group by company_name;

truncate table temp_table;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `company_master`
--

CREATE TABLE `company_master` (
  `id` int(11) NOT NULL,
  `company_name` varchar(200) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_master`
--

INSERT INTO `company_master` (`id`, `company_name`, `location_id`) VALUES
(1, 'abc', 2),
(2, 'xyz', 1),
(3, 'pqr', 3),
(4, 'lmn', 4),
(5, 'ijk', 6),
(6, 'bca', 5);

-- --------------------------------------------------------

--
-- Table structure for table `location_master`
--

CREATE TABLE `location_master` (
  `id` int(11) NOT NULL,
  `location_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location_master`
--

INSERT INTO `location_master` (`id`, `location_name`) VALUES
(1, 'Mumbai'),
(2, 'Delhi'),
(3, 'Kolkatta'),
(4, 'Chennai'),
(5, 'Chandigarh'),
(6, 'Lukhnow');

-- --------------------------------------------------------

--
-- Table structure for table `service_master`
--

CREATE TABLE `service_master` (
  `id` int(11) NOT NULL,
  `service_name` varchar(200) NOT NULL,
  `service_cost` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_master`
--

INSERT INTO `service_master` (`id`, `service_name`, `service_cost`) VALUES
(1, 'Audit', '1000'),
(2, 'chemical', '2000'),
(3, 'side effects', '5000'),
(4, 'Envoirmental Hygiene', '10000');

-- --------------------------------------------------------

--
-- Table structure for table `service_provided`
--

CREATE TABLE `service_provided` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_provided`
--

INSERT INTO `service_provided` (`id`, `company_id`, `service_id`, `date_added`) VALUES
(1, 5, 1, '2004-09-13 00:00:00'),
(2, 3, 3, '2018-10-11 00:00:00'),
(3, 5, 4, '2017-01-02 00:00:00'),
(4, 4, 1, '2005-11-17 00:00:00'),
(5, 5, 2, '2005-01-04 00:00:00'),
(6, 2, 2, '2003-05-07 00:00:00'),
(7, 4, 1, '2002-12-24 00:00:00'),
(8, 6, 2, '2001-06-17 00:00:00'),
(9, 6, 3, '2014-09-15 00:00:00'),
(10, 5, 1, '2011-02-16 00:00:00'),
(11, 4, 3, '2008-09-19 00:00:00'),
(12, 3, 2, '2002-07-18 00:00:00'),
(13, 2, 3, '2006-09-22 00:00:00'),
(14, 4, 1, '2006-09-14 00:00:00'),
(15, 4, 4, '2011-09-22 00:00:00'),
(16, 6, 1, '2013-04-16 00:00:00'),
(17, 3, 2, '2009-08-23 00:00:00'),
(18, 3, 1, '2010-12-05 00:00:00'),
(19, 4, 3, '2017-05-09 00:00:00'),
(20, 3, 3, '2009-04-01 00:00:00'),
(21, 4, 3, '2007-02-26 00:00:00'),
(22, 3, 1, '2008-11-17 00:00:00'),
(23, 4, 3, '2004-03-21 00:00:00'),
(24, 4, 2, '2007-10-15 00:00:00'),
(25, 4, 3, '2013-04-09 00:00:00'),
(26, 5, 2, '2015-05-03 00:00:00'),
(27, 5, 1, '2003-09-12 00:00:00'),
(28, 5, 4, '2017-02-02 00:00:00'),
(29, 4, 4, '2018-04-09 00:00:00'),
(30, 1, 1, '2016-02-26 00:00:00'),
(31, 2, 2, '2014-04-28 00:00:00'),
(32, 4, 1, '2009-09-15 00:00:00'),
(33, 2, 4, '2009-08-27 00:00:00'),
(34, 4, 1, '2010-01-31 00:00:00'),
(35, 1, 2, '2014-07-14 00:00:00'),
(36, 6, 4, '2018-03-09 00:00:00'),
(37, 3, 2, '2004-06-24 00:00:00'),
(38, 2, 3, '2017-01-26 00:00:00'),
(39, 4, 4, '2010-06-25 00:00:00'),
(40, 3, 3, '2010-12-15 00:00:00'),
(41, 5, 3, '2001-08-11 00:00:00'),
(42, 2, 3, '2006-12-31 00:00:00'),
(43, 3, 2, '2006-12-27 00:00:00'),
(44, 3, 4, '2010-07-31 00:00:00'),
(45, 2, 3, '2012-09-29 00:00:00'),
(46, 5, 4, '2010-04-02 00:00:00'),
(47, 2, 3, '2006-01-17 00:00:00'),
(48, 5, 1, '2004-06-27 00:00:00'),
(49, 6, 4, '2016-12-07 00:00:00'),
(50, 6, 4, '2018-08-20 00:00:00'),
(51, 5, 1, '2002-06-02 00:00:00'),
(52, 2, 1, '2002-08-24 00:00:00'),
(53, 3, 3, '2006-02-19 00:00:00'),
(54, 6, 1, '2001-12-13 00:00:00'),
(55, 6, 2, '2011-06-22 00:00:00'),
(56, 4, 2, '2001-06-24 00:00:00'),
(57, 2, 2, '2017-07-28 00:00:00'),
(58, 5, 1, '2001-11-03 00:00:00'),
(59, 4, 2, '2012-11-25 00:00:00'),
(60, 5, 3, '2002-12-07 00:00:00'),
(61, 3, 1, '2007-12-10 00:00:00'),
(62, 6, 1, '2015-11-21 00:00:00'),
(63, 2, 2, '2010-06-03 00:00:00'),
(64, 6, 2, '2001-07-13 00:00:00'),
(65, 6, 1, '2004-05-20 00:00:00'),
(66, 3, 2, '2015-04-01 00:00:00'),
(67, 1, 4, '2010-09-16 00:00:00'),
(68, 6, 1, '2011-01-20 00:00:00'),
(69, 6, 3, '2009-01-18 00:00:00'),
(70, 6, 4, '2013-12-15 00:00:00'),
(71, 3, 2, '2016-07-02 00:00:00'),
(72, 3, 4, '2017-08-25 00:00:00'),
(73, 1, 2, '2001-01-09 00:00:00'),
(74, 1, 1, '2010-04-03 00:00:00'),
(75, 1, 3, '2008-06-03 00:00:00'),
(76, 5, 4, '2009-12-07 00:00:00'),
(77, 3, 3, '2018-10-19 00:00:00'),
(78, 5, 4, '2017-08-03 00:00:00'),
(79, 6, 2, '2012-02-02 00:00:00'),
(80, 4, 4, '2019-03-03 00:00:00'),
(81, 6, 1, '2002-04-28 00:00:00'),
(82, 3, 4, '2019-03-04 00:00:00'),
(83, 1, 4, '2002-06-10 00:00:00'),
(84, 4, 3, '2002-12-15 00:00:00'),
(85, 3, 4, '2002-10-23 00:00:00'),
(86, 3, 1, '2014-08-25 00:00:00'),
(87, 1, 4, '2017-06-21 00:00:00'),
(88, 1, 3, '2018-01-03 00:00:00'),
(89, 6, 3, '2012-05-21 00:00:00'),
(90, 3, 3, '2014-11-11 00:00:00'),
(91, 1, 2, '2005-08-31 00:00:00'),
(92, 1, 2, '2008-07-22 00:00:00'),
(93, 3, 1, '2008-06-22 00:00:00'),
(94, 1, 4, '2004-06-11 00:00:00'),
(95, 1, 1, '2005-12-28 00:00:00'),
(96, 2, 2, '2009-09-13 00:00:00'),
(97, 5, 1, '2003-08-29 00:00:00'),
(98, 4, 1, '2002-07-16 00:00:00'),
(99, 2, 3, '2016-05-09 00:00:00'),
(100, 4, 2, '2005-11-29 00:00:00'),
(101, 3, 2, '2011-05-26 00:00:00'),
(102, 5, 1, '2015-01-22 00:00:00'),
(103, 2, 4, '2010-05-28 00:00:00'),
(104, 5, 4, '2001-05-05 00:00:00'),
(105, 5, 3, '2007-08-03 00:00:00'),
(106, 4, 2, '2018-07-20 00:00:00'),
(107, 1, 1, '2013-09-05 00:00:00'),
(108, 1, 2, '2005-03-04 00:00:00'),
(109, 3, 2, '2005-03-24 00:00:00'),
(110, 6, 4, '2010-04-05 00:00:00'),
(111, 4, 1, '2017-11-28 00:00:00'),
(112, 1, 2, '2009-11-29 00:00:00'),
(113, 6, 1, '2004-09-21 00:00:00'),
(114, 4, 3, '2001-01-13 00:00:00'),
(115, 1, 2, '2016-08-13 00:00:00'),
(116, 4, 4, '2013-08-24 00:00:00'),
(117, 6, 1, '2003-09-12 00:00:00'),
(118, 6, 4, '2001-08-13 00:00:00'),
(119, 1, 1, '2001-07-05 00:00:00'),
(120, 1, 2, '2011-09-21 00:00:00'),
(121, 1, 4, '2012-06-13 00:00:00'),
(122, 2, 1, '2015-07-18 00:00:00'),
(123, 6, 4, '2007-03-10 00:00:00'),
(124, 1, 1, '2004-12-20 00:00:00'),
(125, 3, 4, '2017-09-19 00:00:00'),
(126, 6, 4, '2018-04-13 00:00:00'),
(127, 2, 4, '2009-10-26 00:00:00'),
(128, 2, 2, '2001-09-17 00:00:00'),
(129, 6, 2, '2008-06-16 00:00:00'),
(130, 4, 1, '2009-12-11 00:00:00'),
(131, 1, 2, '2014-12-18 00:00:00'),
(132, 6, 4, '2018-07-27 00:00:00'),
(133, 2, 4, '2006-07-09 00:00:00'),
(134, 4, 2, '2007-01-14 00:00:00'),
(135, 6, 3, '2013-03-06 00:00:00'),
(136, 5, 2, '2009-12-18 00:00:00'),
(137, 2, 4, '2002-05-28 00:00:00'),
(138, 3, 3, '2015-03-05 00:00:00'),
(139, 3, 2, '2011-01-11 00:00:00'),
(140, 2, 1, '2018-06-19 00:00:00'),
(141, 4, 4, '2014-12-09 00:00:00'),
(142, 4, 2, '2005-08-18 00:00:00'),
(143, 2, 2, '2000-11-27 00:00:00'),
(144, 6, 2, '2005-02-13 00:00:00'),
(145, 6, 3, '2017-01-24 00:00:00'),
(146, 1, 4, '2006-02-22 00:00:00'),
(147, 1, 1, '2016-09-01 00:00:00'),
(148, 1, 3, '2001-12-26 00:00:00'),
(149, 5, 4, '2016-11-28 00:00:00'),
(150, 4, 2, '2019-01-09 00:00:00'),
(151, 5, 2, '2005-03-20 00:00:00'),
(152, 2, 2, '2012-11-19 00:00:00'),
(153, 5, 3, '2001-02-28 00:00:00'),
(154, 2, 2, '2008-11-14 00:00:00'),
(155, 3, 2, '2017-04-20 00:00:00'),
(156, 5, 1, '2009-04-10 00:00:00'),
(157, 1, 1, '2014-05-06 00:00:00'),
(158, 2, 3, '2014-06-02 00:00:00'),
(159, 4, 1, '2003-04-21 00:00:00'),
(160, 3, 3, '2018-04-10 00:00:00'),
(161, 3, 2, '2015-12-25 00:00:00'),
(162, 5, 3, '2011-03-08 00:00:00'),
(163, 2, 1, '2017-04-13 00:00:00'),
(164, 1, 4, '2010-10-25 00:00:00'),
(165, 4, 3, '2006-04-22 00:00:00'),
(166, 2, 2, '2005-11-13 00:00:00'),
(167, 2, 2, '2004-06-23 00:00:00'),
(168, 2, 2, '2006-04-20 00:00:00'),
(169, 4, 3, '2004-10-31 00:00:00'),
(170, 6, 4, '2008-07-04 00:00:00'),
(171, 6, 2, '2010-04-06 00:00:00'),
(172, 1, 3, '2001-02-11 00:00:00'),
(173, 6, 1, '2004-11-16 00:00:00'),
(174, 2, 1, '2006-07-12 00:00:00'),
(175, 6, 3, '2005-12-30 00:00:00'),
(176, 3, 3, '2001-08-28 00:00:00'),
(177, 4, 2, '2011-04-22 00:00:00'),
(178, 5, 2, '2015-06-19 00:00:00'),
(179, 2, 4, '2010-07-10 00:00:00'),
(180, 6, 1, '2014-08-16 00:00:00'),
(181, 3, 4, '2003-02-09 00:00:00'),
(182, 2, 1, '2009-07-31 00:00:00'),
(183, 4, 1, '2013-10-18 00:00:00'),
(184, 5, 3, '2009-03-12 00:00:00'),
(185, 3, 4, '2008-04-17 00:00:00'),
(186, 4, 1, '2013-12-15 00:00:00'),
(187, 1, 4, '2016-06-27 00:00:00'),
(188, 4, 4, '2010-07-04 00:00:00'),
(189, 1, 4, '2013-03-26 00:00:00'),
(190, 1, 2, '2001-05-18 00:00:00'),
(191, 5, 1, '2012-03-05 00:00:00'),
(192, 3, 3, '2009-12-06 00:00:00'),
(193, 6, 1, '2005-01-14 00:00:00'),
(194, 5, 3, '2006-12-14 00:00:00'),
(195, 3, 1, '2007-05-18 00:00:00'),
(196, 3, 1, '2003-08-22 00:00:00'),
(197, 6, 4, '2012-05-21 00:00:00'),
(198, 5, 2, '2013-02-09 00:00:00'),
(199, 5, 3, '2004-08-11 00:00:00'),
(200, 3, 3, '2002-08-23 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `temp_table`
--

CREATE TABLE `temp_table` (
  `Company_Name` varchar(100) DEFAULT NULL,
  `ch_month` varchar(100) DEFAULT NULL,
  `total_service_cost` varchar(100) DEFAULT NULL,
  `total_service_count` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company_master`
--
ALTER TABLE `company_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location_master`
--
ALTER TABLE `location_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_master`
--
ALTER TABLE `service_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_provided`
--
ALTER TABLE `service_provided`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company_master`
--
ALTER TABLE `company_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `location_master`
--
ALTER TABLE `location_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `service_master`
--
ALTER TABLE `service_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `service_provided`
--
ALTER TABLE `service_provided`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
