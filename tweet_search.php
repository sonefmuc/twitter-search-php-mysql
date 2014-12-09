<?php 

// Here you will need to enter the info of the database that the tweets will be sent to
// We use localhost under xampp
$db_host		= 'localhost';
$db_user		= 'root';
$db_pass		= '';
$db_database	= 'twitter_db'; 

$link = @mysql_connect($db_host,$db_user,$db_pass) or die(mysql_error());

mysql_query("SET NAMES 'utf8'");
mysql_select_db($db_database,$link);

session_start();

require_once("twitteroauth/twitteroauth/twitteroauth.php"); //Path to twitteroauth library 

// These info is specific for your twitter appplication - Replace the "XXXX" with your own values (inside the double quotes) - DO NOT EVER DISTRIBUT THIS INFORMATION
$consumerkey = "XXXX";
$consumersecret = "XXXX";
$accesstoken = "XXXX";
$accesstokensecret = "XXXX";
 
function getConnectionWithAccessToken($cons_key, $cons_secret, $oauth_token, $oauth_token_secret) {
  $connection = new TwitterOAuth($cons_key, $cons_secret, $oauth_token, $oauth_token_secret);
  return $connection;
}
 
$connection = getConnectionWithAccessToken($consumerkey, $consumersecret, $accesstoken, $accesstokensecret);

$twitterhashtag = "#washington OR #newyork OR #losangeles";
$twitterhashtag = urlencode($twitterhashtag);
//for more hashtags to be followed just inserted new OR #hashtag

$count_num=99; // max number of tweets to be returned in each call
$results_mode='recent'; //get the most recent tweets


$tweets = $connection->get("https://api.twitter.com/1.1/search/tweets.json?q=".$twitterhashtag."&count=".$count_num."&result_type=".$results_mode);

echo "<center><h2>Tweets fetched!</h2><br />";

$get_maxid = mysql_query ("SELECT MAX(`tweetid`) FROM $db_database.`tweets`");
$max_tweetid= mysql_result($get_maxid , 0);
echo "max: $max_tweetid <br />";

foreach ($tweets->statuses as $tweet){
	
	if( $tweet->id_str >$max_tweetid){ //Check the max id in db and get only the latest tweets
			
		$datetime = $tweet->created_at;
		$datetime_mysql = date('Y-m-d H:i:s', strtotime($datetime)); //convert datetime to mysql datetime type


		//Dig out any hashtags from the tweets and upload to the hashtags table
		foreach($tweet->entities->hashtags as $hashtag) {
			mysql_query ("INSERT INTO $db_database.`tweets_hashtags` ( `tweetid`, `hashtag`) VALUES ('{$tweet->id_str}', '{$hashtag->text}')");

		}
		//Get any urls from the tweets and upload to the urls table
		foreach($tweet->entities->urls as $url) {
			mysql_query ("INSERT INTO $db_database.`tweets_urls` ( `tweetid`, `url`) VALUES ('{$tweet->id_str}', '{$url->expanded_url}')");

		}
		/*Get fields 
		`user_name`, `screen_name`, `tweet`, `tweetid`, `retweet_count`, `followers_count`, `friends_count`, `listed_count`,  
		`source`, `lang`, `coordinates_type`, `lon`, `lat`,  `location`, `date_tweeted`		
		from tweet and upload to tweets table*/

		mysql_query ("INSERT INTO $db_database.`tweets` ( `user_name`, `screen_name`, `tweet`, `tweetid`, `retweet_count`, `followers_count`, `friends_count`, `listed_count`,  `source`, `lang`, `coordinates_type`, `lon`, `lat`,  `location`, `date_tweeted`) VALUES ('{$tweet->user->name}', '{$tweet->user->screen_name}', '{$tweet->text}', '{$tweet->id_str}', '{$tweet->retweet_count}', '{$tweet->user->followers_count}', '{$tweet->user->friends_count}', '{$tweet->user->listed_count}', '{$tweet->source}', '{$tweet->lang}', '{$tweet->coordinates->type}', '{$tweet->coordinates->coordinates[0]}', '{$tweet->coordinates->coordinates[1]}', '{$tweet->user->location}', '$datetime_mysql')");	
				
		
	}
}


?>
