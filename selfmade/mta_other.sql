-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 09. Sep 2021 um 13:30
-- Server-Version: 10.1.48-MariaDB-0+deb9u2
-- PHP-Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `mta_other`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts`
--

CREATE TABLE `accounts` (
  `Username` varchar(25) NOT NULL,
  `Password` text NOT NULL,
  `Serial` text NOT NULL,
  `Email` text NOT NULL,
  `AdminLevel` int(11) NOT NULL DEFAULT '0',
  `Hunger` int(11) NOT NULL DEFAULT '100',
  `Thirst` int(11) NOT NULL DEFAULT '100',
  `Premium` int(11) NOT NULL DEFAULT '0',
  `Hospitaltime` int(11) NOT NULL DEFAULT '0',
  `BoosttimeMoney20` int(11) NOT NULL DEFAULT '0',
  `BoosttimeMoney50` int(11) NOT NULL DEFAULT '0',
  `BoosttimeEXP20` int(11) NOT NULL DEFAULT '0',
  `BoosttimeEXP50` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `achievement`
--

CREATE TABLE `achievement` (
  `Username` varchar(25) NOT NULL,
  `FirstPlayerKill` int(11) NOT NULL DEFAULT '0',
  `FirstZombieKill` int(11) NOT NULL DEFAULT '0',
  `1000ZombieKills` int(11) NOT NULL DEFAULT '0',
  `10000ZombieKills` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans`
--

CREATE TABLE `bans` (
  `Admin` varchar(50) NOT NULL,
  `Target` varchar(50) NOT NULL,
  `TargetSerial` varchar(50) NOT NULL,
  `Reason` text NOT NULL,
  `Time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `counter`
--

CREATE TABLE `counter` (
  `Lootbox` int(11) NOT NULL DEFAULT '1',
  `Vehicles` int(11) NOT NULL DEFAULT '1',
  `Itemdepot` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `counter`
--

INSERT INTO `counter` (`Lootbox`, `Vehicles`, `Itemdepot`) VALUES
(168, 1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventory`
--

CREATE TABLE `inventory` (
  `Username` varchar(25) NOT NULL,
  `Coins` int(50) NOT NULL DEFAULT '0',
  `Pastacan` int(11) NOT NULL DEFAULT '0',
  `Ravioli` int(11) NOT NULL DEFAULT '0',
  `Pepsi` int(11) NOT NULL DEFAULT '0',
  `Cola` int(11) NOT NULL DEFAULT '0',
  `Fuelcan` int(11) NOT NULL DEFAULT '0',
  `Repairkit` int(11) NOT NULL DEFAULT '0',
  `FirstAidKit` int(11) NOT NULL DEFAULT '0',
  `Weapondepot` int(11) NOT NULL DEFAULT '0',
  `Itemdepot` int(11) NOT NULL DEFAULT '0',
  `Skin_7` int(11) NOT NULL DEFAULT '0',
  `Skin_11` int(11) NOT NULL DEFAULT '0',
  `Skin_12` int(11) NOT NULL DEFAULT '0',
  `Skin_13` int(11) NOT NULL DEFAULT '0',
  `Skin_31` int(11) NOT NULL DEFAULT '0',
  `Boost_Money20` int(11) NOT NULL DEFAULT '0',
  `Boost_Money50` int(11) NOT NULL DEFAULT '0',
  `Boost_EXP20` int(11) NOT NULL DEFAULT '0',
  `Boost_EXP50` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `itemdepots`
--

CREATE TABLE `itemdepots` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(25) NOT NULL,
  `SpawnX` varchar(25) NOT NULL,
  `SpawnY` varchar(25) NOT NULL,
  `SpawnZ` varchar(25) NOT NULL,
  `Rot` varchar(25) NOT NULL,
  `Coins` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logoutweapons`
--

CREATE TABLE `logoutweapons` (
  `Username` varchar(25) NOT NULL,
  `Weapons` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lootpositions`
--

CREATE TABLE `lootpositions` (
  `ID` int(50) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `RotZ` varchar(50) NOT NULL,
  `LootPriority` mediumint(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `lootpositions`
--

INSERT INTO `lootpositions` (`ID`, `SpawnX`, `SpawnY`, `SpawnZ`, `RotZ`, `LootPriority`) VALUES
(1, '-2038.1', '182.2', '27.9', '90', 0),
(3, '-2135.8', '169.9', '41.4', '90', 0),
(4, '-2025.8', '-41.7', '37.9', '90', 0),
(5, '206.8', '1923.2', '16.8', '0', 2),
(6, '285.6', '1941.5', '16.8', '0', 2),
(7, '285.5', '1975.3', '16.8', '0', 2),
(8, '273.6', '2003.6', '16.8', '0', 2),
(9, '267.5', '2020.3', '16.8', '90', 2),
(10, '205.6', '1858', '12.3', '0', 2),
(11, '245.2', '1858', '13.2', '0', 2),
(12, '244.8', '1830.5', '6.7', '0', 2),
(13, '216.5', '1822.8', '5.5', '0', 2),
(14, '314.8', '1837.8', '7', '0', 2),
(15, '260.5', '1884.7', '7.6', '0', 2),
(16, '166.1', '1849.8', '33', '0', 2),
(17, '352.9', '2029.5', '23', '0', 2),
(18, '290.4', '1802.5', '17', '0', 2),
(19, '286.1', '1807.9', '26.1', '0', 2),
(20, '-1374.7', '-526.1', '13.3', '0', 0),
(21, '-1348.2', '-460.7', '13.3', '0', 0),
(22, '-1473.4', '-518', '13.3', '0', 0),
(23, '-1233.7', '52', '13.3', '0', 1),
(24, '-1676.7', '419.4', '6.5', '0', 0),
(25, '-1341.2', '495.8', '10.3', '0', 1),
(26, '-1330.3', '510', '10.3', '0', 1),
(27, '-1395.8', '502', '10.3', '0', 1),
(28, '-1325.2', '495.6', '21.6', '0', 1),
(29, '-1249.3', '492.5', '15.7', '0', 1),
(30, '-1616', '686.2', '6.3', '0', 1),
(31, '-1593.4', '710.8', '-6.1', '90', 1),
(32, '-1619.5', '667.1', '-5.8', '90', 1),
(33, '-1359.4', '489.9', '23.4', '0', 1),
(34, '-1465.9', '509.2', '9.1', '0', 1),
(35, '-1492.9', '920.1', '6.3', '90', 0),
(36, '-1550.7', '1168.6', '6.3', '90', 0),
(37, '-1658.7', '1207.2', '6.4', '0', 0),
(38, '-1665.5', '1227.7', '12.8', '0', 0),
(39, '-1645.6', '1203.1', '20.3', '0', 0),
(41, '-1263.293945', '41.239258', '13.339128', '312.030212', 1),
(42, '-1831.806641', '110.746094', '14.317187', '178.917847', 0),
(43, '-1961.943359', '536.678711', '34.371875', '270.292511', 0),
(44, '-2026.590820', '-101.698242', '34.364063', '177.192932', 0),
(45, '-2171.718750', '244.530273', '34.528381', '90.866577', 0),
(46, '-2171.738281', '262.099609', '34.528358', '2.156128', 0),
(47, '-2425.535156', '337.631836', '36.201942', '59.395752', 0),
(48, '-2529.444336', '-26.705078', '15.621875', '187.333481', 0),
(49, '-2664.656250', '-10.317383', '5.332813', '267.760132', 0),
(50, '-2789.653320', '-52.425781', '9.262500', '273.330292', 0),
(51, '-2791.107422', '126.959961', '6.401954', '268.238037', 0),
(52, '-2671.491211', '258.278320', '3.832813', '180.637222', 0),
(53, '-2649.301758', '376.004883', '5.359250', '270.710022', 0),
(54, '-2457.924805', '773.978516', '34.371875', '179.033203', 0),
(57, '-2203.775391', '616.538086', '34.364063', '358.486603', 0),
(58, '-1901.259766', '291.593750', '40.246875', '267.507446', 0),
(59, '-1907.776367', '297.962891', '40.246875', '92.377197', 0),
(60, '-1862.242188', '-145.257812', '11.098437', '180.186768', 0),
(61, '-1829.834961', '63.393555', '14.322790', '91.135742', 0),
(62, '-1721.324219', '1359.870117', '6.385316', '267.084473', 0),
(63, '-1679.502930', '1379.811523', '11.590625', '40.218811', 0),
(64, '-1528.551025', '456.243958', '12.153415', '240.563049', 0),
(65, '-1531.447876', '454.953705', '9.253415', '144.826721', 1),
(66, '-1467.894165', '462.015228', '7.982543', '99.403076', 1),
(67, '-1342.981445', '440.543945', '6.387500', '2.194580', 1),
(68, '-1365.541016', '503', '12.543550', '204.834976', 1),
(69, '-1796.987305', '394.554688', '15.718225', '308.382690', 0),
(70, '-1056.727539', '-621.245117', '31.107813', '3.490936', 2),
(71, '-1068.897461', '-597.136719', '31.107813', '162.564453', 2),
(72, '-1060.722656', '-623.571289', '33.189600', '181.373306', 2),
(73, '-1071.296875', '-668.241211', '31.107813', '94.953552', 2),
(74, '-1051.805664', '-701.416992', '31.451563', '270.512268', 2),
(75, '-1018.373047', '-754.423828', '31.107813', '256.466003', 2),
(76, '-987.510742', '-710.504883', '31.107813', '88.938416', 2),
(77, '-1008.343933', '-604.201172', '34.053415', '1.804535', 2),
(78, '-1001.783386', '-600.462097', '36.953416', '282.262299', 2),
(79, '-1119.944336', '-608.839844', '33.189600', '271.792175', 2),
(80, '-1122.959961', '-658.540039', '31.107813', '162.064575', 2),
(82, '-2091.535400', '-83.842384', '34.499662', '5.864044', 0),
(83, '-2078.630127', '-83.502541', '34.492822', '270.276031', 0),
(84, '-1557.412720', '-423.511322', '5.398866', '218.782333', 1),
(85, '-2454.629883', '503.783203', '29.178293', '88.328674', 0),
(86, '-2446.560547', '520.828125', '29.337118', '88.619812', 0),
(87, '-326.376770', '1040.381104', '19.808286', '91.778442', 0),
(88, '-322.229309', '1023.823486', '19.740745', '178.198242', 0),
(89, '-323.291809', '1058.408447', '19.793497', '88.768127', 0),
(90, '323.040039', '1965.712158', '17.004337', '85.950104', 2),
(91, '326.676758', '1956.864502', '16.993789', '270.391388', 2),
(92, '1643.479492', '-48.447266', '26.763227', '279.356384', 0),
(93, '1552.482422', '-33.744141', '20.456672', '182.477448', 0),
(94, '1549.574219', '13.190430', '23.245313', '281.504211', 0),
(95, '1509.457031', '17.733398', '23.240625', '106.665131', 0),
(96, '1359.815430', '205.275391', '18.855516', '150.666077', 0),
(97, '1324.330078', '286.497070', '19.145195', '155.967041', 0),
(98, '1367.425781', '248.299805', '18.666933', '245.391617', 0),
(99, '-2489.058594', '-607.898438', '140.573434', '2.655975', 0),
(100, '-2512.825195', '-697.581055', '138.420312', '350.048981', 0),
(101, '-2336.693359', '-166.860352', '34.654688', '89.202087', 0),
(102, '-2384.464844', '-14.074610', '34.610628', '254.691681', 0),
(103, '-2388.793945', '-24.147852', '34.601724', '104.357971', 0),
(104, '-2689.142090', '-55.769142', '12.273437', '0.403748', 0),
(105, '-2719.570312', '-319.149414', '6.943750', '226.747543', 1),
(106, '-2866.604980', '-439.426575', '11.912500', '89.921722', 0),
(107, '-2857.677246', '-434.478333', '16.740625', '40.768127', 0),
(108, '-2870.780762', '-426.431458', '20.977289', '357.344025', 0),
(109, '-2866.497559', '411.219147', '12.673438', '356.316772', 0),
(110, '-2767.447266', '788.851562', '51.881250', '89.663544', 0),
(111, '-1682.255859', '1318.599609', '6.408890', '191.920334', 0),
(112, '-1675.063477', '1312.325195', '6.395877', '259.421387', 0),
(113, '-2051.588867', '252.081055', '30.552147', '285.140747', 0),
(114, '-463.974213', '593.327332', '25.073438', '279.653015', 0),
(115, '-523.247437', '615.916016', '15.997385', '52.748932', 0),
(116, '-760.252563', '763.004883', '17.860937', '244.249023', 0),
(117, '-749.416626', '747.598633', '17.860937', '206.131393', 0),
(118, '-756.780884', '740.373047', '17.860937', '177.703857', 0),
(119, '-758.210571', '738.673828', '17.860937', '231.444260', 0),
(120, '26.788086', '1361.923828', '8.271875', '224.401932', 0),
(121, '172.780273', '1345.156250', '9.685937', '23.013947', 0),
(122, '188.136719', '1372.061523', '22.834375', '266.331879', 1),
(123, '247.513672', '1409.602539', '9.807500', '313.051971', 0),
(124, '246.728516', '1435.416016', '22.475000', '356.618896', 0),
(125, '215.369141', '1467.795898', '22.834375', '282.097504', 1),
(126, '277.040039', '1839.673828', '6.928125', '64.899963', 2),
(127, '271.585938', '1873.772461', '7.857812', '32.511780', 2),
(128, '268.760742', '1876.452148', '-4.369453', '189.585724', 2),
(129, '268.770508', '1876.674805', '-23.142962', '180.269150', 2),
(130, '263.265625', '1879.144531', '-31.290625', '124.661011', 2),
(131, '274.359375', '1887.517578', '-31.290625', '298.643158', 2),
(132, '287.076172', '1815.746094', '0.107812', '90.844604', 2),
(133, '259.125000', '1816.027344', '0.107812', '89.839325', 2),
(134, '239.596680', '1861.619141', '7.857812', '1.414490', 2),
(135, '202.161133', '1873.576172', '12.240625', '1.716644', 2),
(136, '-2274.324951', '555.813477', '43.173437', '358.695343', 0),
(137, '-2172.915039', '680.275391', '54.262605', '267.227295', 0),
(138, '-2181.548828', '712.904297', '52.990648', '182.197296', 0),
(139, '-1950.836914', '294.059570', '40.147081', '270.199127', 0),
(140, '-1901.438477', '-1682.457031', '22.115625', '182.290695', 0),
(141, '-1920.159180', '-1659.548828', '22.115625', '4.869751', 0),
(142, '-1722.307617', '-1669.898438', '47.050912', '203.670395', 1),
(143, '-264.703125', '-223.612503', '9.373437', '266.551605', 0),
(144, '-1975.654297', '364.672852', '49.878126', '304.614319', 0),
(145, '-2431.638672', '-109.685547', '34.420313', '87.751892', 1),
(146, '-2475.034180', '-187.981445', '29.826563', '86.757629', 0),
(147, '-2799.245117', '-307.934570', '15.173437', '83.708862', 1),
(148, '-2542.508789', '-353.069336', '36.131250', '277.878693', 2),
(149, '-2628.520508', '267.579102', '6.295312', '268.891754', 0),
(150, '-2622.052734', '239.604492', '3.428125', '87.927673', 0),
(151, '-2544.542969', '191.366211', '12.139062', '279.823303', 0),
(152, '-2500.671875', '529.206055', '29.178125', '270.957184', 0),
(153, '-2442.675781', '754.907227', '34.271875', '359.761047', 0),
(154, '-2514.320312', '794.634766', '41.201563', '90.811646', 0),
(155, '-2687.414062', '834.681641', '49.084375', '180.939346', 0),
(156, '-2661.890625', '876.649414', '78.873796', '179.906616', 0),
(157, '-2641.111328', '935.508789', '71.053125', '1.612274', 0),
(158, '-2591.168945', '927.861328', '64.115625', '270.693542', 0),
(159, '-2545.057617', '929.629883', '64.089243', '271.885559', 0),
(160, '-2503.019531', '921.375000', '64.340814', '358.437164', 0),
(161, '-2420.155273', '969.690430', '44.396875', '91.739960', 0),
(162, '-2448.099609', '965.992188', '44.401617', '264.343323', 0),
(163, '-2454.795898', '1065.151367', '59.678125', '0.925629', 1),
(164, '-2589.280273', '1163.630859', '57.615625', '148.886230', 0),
(165, '-2698.491211', '1240.367188', '56.823030', '97.271667', 0),
(166, '-1987.807617', '217.569336', '26.787500', '88.812073', 1),
(167, '-2618.538086', '480.235352', '13.709375', '44.305786', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `premiumtime`
--

CREATE TABLE `premiumtime` (
  `Username` varchar(25) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Time` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `settings`
--

CREATE TABLE `settings` (
  `Username` varchar(25) NOT NULL,
  `SpawnX` varchar(25) NOT NULL,
  `SpawnY` varchar(25) NOT NULL,
  `SpawnZ` varchar(25) NOT NULL,
  `SpawnROT` varchar(25) NOT NULL,
  `SpawnINT` varchar(25) NOT NULL,
  `SpawnDIM` varchar(25) NOT NULL,
  `SkinID` int(11) NOT NULL,
  `Hitglocke` int(11) NOT NULL DEFAULT '4',
  `RenderdistanceWorld` int(11) NOT NULL DEFAULT '2000',
  `RenderdistanceCustom` int(11) NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `stats`
--

CREATE TABLE `stats` (
  `Username` varchar(25) NOT NULL,
  `Playtime` int(11) NOT NULL DEFAULT '0',
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `Damage` int(20) NOT NULL DEFAULT '0',
  `ZombieKills` int(11) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT '1',
  `EXP` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `ID` int(11) NOT NULL,
  `VehID` mediumint(3) NOT NULL,
  `SpawnX` varchar(25) NOT NULL,
  `SpawnY` varchar(25) NOT NULL,
  `SpawnZ` varchar(25) NOT NULL,
  `RotX` varchar(25) NOT NULL,
  `RotY` varchar(25) NOT NULL,
  `RotZ` varchar(25) NOT NULL,
  `Fuel` int(11) NOT NULL DEFAULT '100',
  `Health` mediumint(3) NOT NULL DEFAULT '1000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weapondepots`
--

CREATE TABLE `weapondepots` (
  `ID` int(50) NOT NULL,
  `Username` varchar(25) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  `WeaponAmmo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weaponskills`
--

CREATE TABLE `weaponskills` (
  `Username` varchar(25) NOT NULL,
  `Colt45` int(11) NOT NULL DEFAULT '0',
  `Silenced` int(11) NOT NULL DEFAULT '0',
  `Deagle` int(11) NOT NULL DEFAULT '0',
  `Shotgun` int(11) NOT NULL DEFAULT '0',
  `Sawedoff` int(11) NOT NULL DEFAULT '0',
  `Uzi` int(11) NOT NULL DEFAULT '0',
  `Mp5` int(11) NOT NULL DEFAULT '0',
  `AK47` int(11) NOT NULL DEFAULT '0',
  `M4` int(11) NOT NULL DEFAULT '0',
  `Rifle` int(11) NOT NULL DEFAULT '0',
  `Sniper` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `whitelist`
--

CREATE TABLE `whitelist` (
  `Name` varchar(25) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Access` varchar(25) NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `achievement`
--
ALTER TABLE `achievement`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`TargetSerial`);

--
-- Indizes für die Tabelle `counter`
--
ALTER TABLE `counter`
  ADD PRIMARY KEY (`Lootbox`);

--
-- Indizes für die Tabelle `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `itemdepots`
--
ALTER TABLE `itemdepots`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `logoutweapons`
--
ALTER TABLE `logoutweapons`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `lootpositions`
--
ALTER TABLE `lootpositions`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `premiumtime`
--
ALTER TABLE `premiumtime`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `weapondepots`
--
ALTER TABLE `weapondepots`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `weaponskills`
--
ALTER TABLE `weaponskills`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`Serial`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `weapondepots`
--
ALTER TABLE `weapondepots`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
