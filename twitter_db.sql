-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 27, 2015 at 10:26 
-- Server version: 5.6.16
-- PHP Version: 5.5.11

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
-- Table structure for table `raw_tweets`
--

CREATE TABLE IF NOT EXISTS `raw_tweets` (
  `tweetid` bigint(20) NOT NULL,
  `tweet` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL,
  PRIMARY KEY (`tweetid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(140) DEFAULT NULL,
  `screen_name` varchar(140) NOT NULL,
  `tweet` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
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
  `date_tweeted` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
