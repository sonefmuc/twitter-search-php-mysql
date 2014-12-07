-- phpMyAdmin SQL Dump
-- Host: localhost
-- PHP Version: 5.5.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `twitter_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
`id` int(4) NOT NULL,
  `user_name` varchar(140) DEFAULT NULL,
  `screen_name` varchar(140) NOT NULL,
  `tweet` varchar(140) DEFAULT NULL,
  `tweetid` bigint(20) DEFAULT NULL,
  `retweet_count` int(11) NOT NULL,
  `followers_count` int(11) NOT NULL,
  `friends_count` int(11) NOT NULL,
  `listed_count` int(11) NOT NULL,
  `source` varchar(140) NOT NULL,
  `lang` varchar(10) NOT NULL,
  `coordinates_type` varchar(10) NOT NULL,
  `lon` float NOT NULL,
  `lat` float NOT NULL,
  `location` varchar(255) NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=57789 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_hashtags`
--

CREATE TABLE IF NOT EXISTS `tweets_hashtags` (
  `tweetid` bigint(20) NOT NULL,
  `hashtag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_urls`
--

CREATE TABLE IF NOT EXISTS `tweets_urls` (
  `tweetid` bigint(20) NOT NULL,
  `url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tweets`
--
ALTER TABLE `tweets`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tweets`
--
ALTER TABLE `tweets`
MODIFY `id` int(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57789;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
