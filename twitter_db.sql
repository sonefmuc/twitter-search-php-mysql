-- phpMyAdmin SQL Dump
-- version 4.4.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 25, 2015 at 04:28 PM
-- Server version: 5.5.43-MariaDB
-- PHP Version: 5.5.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `twitter_db`
--
CREATE DATABASE IF NOT EXISTS `twitter_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `twitter_db`;

-- --------------------------------------------------------

--
-- Stand-in structure for view `email_tweets`
--
CREATE TABLE IF NOT EXISTS `email_tweets` (
`screen_name` varchar(140)
,`tweet` varchar(255)
,`retweet_count` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `email_tweets_tweetid_count`
--
CREATE TABLE IF NOT EXISTS `email_tweets_tweetid_count` (
`screen_name` varchar(140)
,`tweet` varchar(255)
,`retweet_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `email_tweets_unsorted`
--
CREATE TABLE IF NOT EXISTS `email_tweets_unsorted` (
`screen_name` varchar(140)
,`tweet` varchar(255)
,`retweet_count` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `parsed_tweets`
--

CREATE TABLE IF NOT EXISTS `parsed_tweets` (
  `tweetid` bigint(20) NOT NULL,
  `date_parsed` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `prv_day_tweets`
--
CREATE TABLE IF NOT EXISTS `prv_day_tweets` (
`init_tweetid` bigint(20)
,`max_tweetid` bigint(20)
,`retweet_count` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `prv_day_tweets_tweetid_count`
--
CREATE TABLE IF NOT EXISTS `prv_day_tweets_tweetid_count` (
`init_tweetid` bigint(20)
,`max_tweetid` bigint(20)
,`user` varchar(140)
,`tweet` varchar(255)
,`retweet_count` int(11)
,`count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `raw_tweets`
--

CREATE TABLE IF NOT EXISTS `raw_tweets` (
  `tweetid` bigint(20) NOT NULL,
  `tweet` longtext COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `top_hashtags`
--
CREATE TABLE IF NOT EXISTS `top_hashtags` (
`hashtag` varchar(255)
,`retweet_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `top_prv_day_tweets`
--
CREATE TABLE IF NOT EXISTS `top_prv_day_tweets` (
`tweetid` bigint(20)
,`max_tweetid` bigint(20)
,`retweet_count` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `top_urls`
--
CREATE TABLE IF NOT EXISTS `top_urls` (
`url` varchar(500)
,`retweet_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `id` int(4) NOT NULL,
  `user_name` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `screen_name` varchar(140) COLLATE utf8_unicode_ci NOT NULL,
  `tweet` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tweetid` bigint(20) DEFAULT NULL,
  `retweet_count` int(11) NOT NULL,
  `retweet_id` bigint(20) DEFAULT NULL,
  `retweet_user` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `followers_count` int(11) NOT NULL,
  `friends_count` int(11) NOT NULL,
  `listed_count` int(11) NOT NULL,
  `source` varchar(140) COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `coordinates_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `lon` float NOT NULL,
  `lat` float NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_dw`
--

CREATE TABLE IF NOT EXISTS `tweets_dw` (
  `id` int(4) NOT NULL,
  `user_name` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `screen_name` varchar(140) COLLATE utf8_unicode_ci NOT NULL,
  `tweet` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tweetid` bigint(20) DEFAULT NULL,
  `retweet_count` int(11) NOT NULL,
  `retweet_id` bigint(20) DEFAULT NULL,
  `retweet_user` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `followers_count` int(11) NOT NULL,
  `friends_count` int(11) NOT NULL,
  `listed_count` int(11) NOT NULL,
  `source` varchar(140) COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `coordinates_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `lon` float NOT NULL,
  `lat` float NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_hashtags`
--

CREATE TABLE IF NOT EXISTS `tweets_hashtags` (
  `tweetid` bigint(20) NOT NULL,
  `hashtag` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_hashtags_dw`
--

CREATE TABLE IF NOT EXISTS `tweets_hashtags_dw` (
  `tweetid` bigint(20) NOT NULL,
  `hashtag` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_urls`
--

CREATE TABLE IF NOT EXISTS `tweets_urls` (
  `tweetid` bigint(20) NOT NULL,
  `url` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tweets_urls_dw`
--

CREATE TABLE IF NOT EXISTS `tweets_urls_dw` (
  `tweetid` bigint(20) NOT NULL,
  `url` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `date_tweeted` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure for view `email_tweets`
--
DROP TABLE IF EXISTS `email_tweets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `email_tweets` AS select `email_tweets_unsorted`.`screen_name` AS `screen_name`,`email_tweets_unsorted`.`tweet` AS `tweet`,`email_tweets_unsorted`.`retweet_count` AS `retweet_count` from `email_tweets_unsorted` order by `email_tweets_unsorted`.`retweet_count` desc;

-- --------------------------------------------------------

--
-- Structure for view `email_tweets_tweetid_count`
--
DROP TABLE IF EXISTS `email_tweets_tweetid_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `email_tweets_tweetid_count` AS select `prv_day_tweets_tweetid_count`.`user` AS `screen_name`,`prv_day_tweets_tweetid_count`.`tweet` AS `tweet`,`prv_day_tweets_tweetid_count`.`count` AS `retweet_count` from `prv_day_tweets_tweetid_count` order by `prv_day_tweets_tweetid_count`.`count` desc;

-- --------------------------------------------------------

--
-- Structure for view `email_tweets_unsorted`
--
DROP TABLE IF EXISTS `email_tweets_unsorted`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `email_tweets_unsorted` AS select `tweets`.`screen_name` AS `screen_name`,`tweets`.`tweet` AS `tweet`,`top_prv_day_tweets`.`retweet_count` AS `retweet_count` from (`tweets` join `top_prv_day_tweets` on((`tweets`.`tweetid` = `top_prv_day_tweets`.`tweetid`))) union all select `tweets`.`retweet_user` AS `retweet_user`,`tweets`.`tweet` AS `tweet`,`tweets`.`retweet_count` AS `retweet_count` from `tweets` where `tweets`.`tweetid` in (select `top_prv_day_tweets`.`max_tweetid` from `top_prv_day_tweets` where (not(exists(select 1 from `tweets` where (`tweets`.`tweetid` = `top_prv_day_tweets`.`tweetid`)))));

-- --------------------------------------------------------

--
-- Structure for view `prv_day_tweets`
--
DROP TABLE IF EXISTS `prv_day_tweets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prv_day_tweets` AS select (case when isnull(`tweets`.`retweet_id`) then `tweets`.`tweetid` else `tweets`.`retweet_id` end) AS `init_tweetid`,max(`tweets`.`tweetid`) AS `max_tweetid`,max(`tweets`.`retweet_count`) AS `retweet_count` from `tweets` where (`tweets`.`date_tweeted` > (curdate() - interval 1 day)) group by (case when isnull(`tweets`.`retweet_id`) then `tweets`.`tweetid` else `tweets`.`retweet_id` end) order by max(`tweets`.`retweet_count`) desc;

-- --------------------------------------------------------

--
-- Structure for view `prv_day_tweets_tweetid_count`
--
DROP TABLE IF EXISTS `prv_day_tweets_tweetid_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prv_day_tweets_tweetid_count` AS select (case when isnull(`tweets`.`retweet_id`) then `tweets`.`tweetid` else `tweets`.`retweet_id` end) AS `init_tweetid`,max(`tweets`.`tweetid`) AS `max_tweetid`,(case when isnull(`tweets`.`retweet_id`) then convert(`tweets`.`screen_name` using utf8mb4) else convert(`tweets`.`retweet_user` using utf8mb4) end) AS `user`,`tweets`.`tweet` AS `tweet`,max(`tweets`.`retweet_count`) AS `retweet_count`,count(0) AS `count` from `tweets` where (`tweets`.`date_tweeted` > (curdate() - interval 2 day)) group by (case when isnull(`tweets`.`retweet_id`) then `tweets`.`tweetid` else `tweets`.`retweet_id` end) order by count(0) desc limit 20;

-- --------------------------------------------------------

--
-- Structure for view `top_hashtags`
--
DROP TABLE IF EXISTS `top_hashtags`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `top_hashtags` AS select `tweets_hashtags`.`hashtag` AS `hashtag`,count(0) AS `retweet_count` from (`tweets_hashtags` join `tweets` on((`tweets`.`tweetid` = `tweets_hashtags`.`tweetid`))) where ((`tweets`.`date_tweeted` > (curdate() - interval 1 day)) and (`tweets_hashtags`.`hashtag` <> 'animaltesting') and (`tweets_hashtags`.`hashtag` <> 'animalrights')) group by `tweets_hashtags`.`hashtag` order by count(0) desc limit 20;

-- --------------------------------------------------------

--
-- Structure for view `top_prv_day_tweets`
--
DROP TABLE IF EXISTS `top_prv_day_tweets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `top_prv_day_tweets` AS select `prv_day_tweets`.`init_tweetid` AS `tweetid`,`prv_day_tweets`.`max_tweetid` AS `max_tweetid`,`prv_day_tweets`.`retweet_count` AS `retweet_count` from (`prv_day_tweets` left join `parsed_tweets` on((`prv_day_tweets`.`init_tweetid` = `parsed_tweets`.`tweetid`))) where isnull(`parsed_tweets`.`tweetid`) limit 20;

-- --------------------------------------------------------

--
-- Structure for view `top_urls`
--
DROP TABLE IF EXISTS `top_urls`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `top_urls` AS select `tweets_urls`.`url` AS `url`,count(0) AS `retweet_count` from (`tweets_urls` join `tweets` on((`tweets`.`tweetid` = `tweets_urls`.`tweetid`))) where (`tweets`.`date_tweeted` > (curdate() - interval 1 day)) group by `tweets_urls`.`url` order by count(0) desc limit 20;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `raw_tweets`
--
ALTER TABLE `raw_tweets`
  ADD PRIMARY KEY (`tweetid`);

--
-- Indexes for table `tweets`
--
ALTER TABLE `tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tweetid` (`tweetid`),
  ADD KEY `retweet_id` (`retweet_id`),
  ADD KEY `date_tweeted` (`date_tweeted`);

--
-- Indexes for table `tweets_dw`
--
ALTER TABLE `tweets_dw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tweets_hashtags`
--
ALTER TABLE `tweets_hashtags`
  ADD KEY `tweetid` (`tweetid`),
  ADD KEY `date_tweeted` (`date_tweeted`);

--
-- Indexes for table `tweets_urls`
--
ALTER TABLE `tweets_urls`
  ADD KEY `tweetid` (`tweetid`),
  ADD KEY `date_tweeted` (`date_tweeted`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tweets`
--
ALTER TABLE `tweets`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tweets_dw`
--
ALTER TABLE `tweets_dw`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
