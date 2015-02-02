<?php 

// Here you will need to enter the info of the database that the tweets will be sent to
// We use localhost under xampp
$db_host		= "localhost";
$db_user		= "root";
$db_pass		= "";
$db_database	= "twitter_db"; 

$mysqli = new mysqli($db_host,$db_user,$db_pass,$db_database);
$mysqli->query("SET NAMES 'utf8'");

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}


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

$hashtags_text = "#animaltesting OR #animalrights";
$twitterhashtag = urlencode($hashtags_text);
//for more hashtags to be followed just inserted new OR #hashtag

$count_num=99; // max number of tweets to be returned in each call
$results_mode='recent'; //get the most recent tweets


$tweets = $connection->get("https://api.twitter.com/1.1/search/tweets.json?q=".$twitterhashtag."&count=".$count_num."&result_type=".$results_mode);


echo "<center><h2>Tweets fetched!</h2><br />";


/* create a prepared statement */
if ($stmt = $mysqli->prepare("SELECT MAX(tweetid) FROM tweets")) {

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($max_tweetid);

    /* fetch value */
    $stmt->fetch();

    /* close statement */
    $stmt->close();
}


echo "hashtags searched:  $hashtags_text <br />";

$count = 0; //counter to get the new fetched tweets
foreach ($tweets->statuses as $tweet){
	
	if( $tweet->id_str >$max_tweetid){ //Check the max id in db and get only the latest tweets
			
		$count += 1;
		$datetime = $tweet->created_at;
		$datetime_mysql = date('Y-m-d H:i:s', strtotime($datetime)); //convert datetime to mysql datetime type
		
		/* create a prepared statement */
		if ($stmt = $mysqli->prepare("INSERT INTO tweets_hashtags (tweetid, hashtag) VALUES (?,?)")) {

			//Dig out any hashtags from the tweets and upload to the hashtags table
			foreach($tweet->entities->hashtags as $hashtag) {
			    /* bind parameters for markers */
			    $stmt->bind_param("is",$tweet->id_str,$hashtag->text);

			    /* execute query */
			    $stmt->execute();	    
			}

		}

		/* close statement */
		$stmt->close();
		

		//Get any urls from the tweets and upload to the urls table
		/* create a prepared statement */
		if ($stmt = $mysqli->prepare("INSERT INTO tweets_urls (tweetid, url) VALUES (?,?)")) {

			foreach($tweet->entities->urls as $url) {
			    /* bind parameters for markers */
			    $stmt->bind_param("is",$tweet->id_str, $url->expanded_url);

			    /* execute query */
			    $stmt->execute();	    


			}
		}
		/* close statement */
		$stmt->close();


		$raw_tweet=json_encode($tweet);

		if ($stmt = $mysqli->prepare("INSERT INTO raw_tweets (tweetid, tweet, date_tweeted) VALUES (?,?,?)")) {

		    /* bind parameters for markers */
		    $stmt->bind_param("iss",$tweet->id_str, $raw_tweet, $datetime_mysql);

		    /* execute query */
		    $stmt->execute();	    
		}

		/* close statement */
		$stmt->close();

		/*Get fields 
		`user_name`, `screen_name`, `tweet`, `tweetid`, `retweet_count`, `followers_count`, `friends_count`, `listed_count`,  
		`source`, `lang`, `coordinates_type`, `lon`, `lat`,  `location`, `date_tweeted`		
		from tweet and upload to tweets table*/

		if (empty($tweet->coordinates)) {
			if ($stmt = $mysqli->prepare("INSERT INTO tweets (user_name, screen_name, tweet, tweetid, retweet_count, followers_count, friends_count, listed_count, source, lang, location, date_tweeted) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)")) {

			    /* bind parameters for markers */
			    $stmt->bind_param("sssiiiiissss",$tweet->user->name, $tweet->user->screen_name, $tweet->text, $tweet->id_str, $tweet->retweet_count, $tweet->user->followers_count, $tweet->user->friends_count, $tweet->user->listed_count, $tweet->source, $tweet->lang, $tweet->user->location, $datetime_mysql);

			    /* execute query */
			    $stmt->execute();	    
		
			    /* close statement */
			    $stmt->close();

			}
		}else{
			if ($stmt = $mysqli->prepare("INSERT INTO tweets (user_name, screen_name, tweet, tweetid, retweet_count, followers_count, friends_count, listed_count, source, lang, coordinates_type, lon, lat, location, date_tweeted) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)")) {

			/* bind parameters for markers */
		    	$stmt->bind_param("sssiiiiisssddss",$tweet->user->name, $tweet->user->screen_name, $tweet->text, $tweet->id_str, $tweet->retweet_count, $tweet->user->followers_count, $tweet->user->friends_count, $tweet->user->listed_count, $tweet->source, $tweet->lang, $tweet->coordinates->type, $tweet->coordinates->coordinates[0], $tweet->coordinates->coordinates[1], $tweet->user->location, $datetime_mysql);

		    	/* execute query */
		    	$stmt->execute();
		
		   	/* close statement */
		   	$stmt->close();
	    		}
		}
			
	}
}

//Output the number of recent tweets that are stored in the db
echo "fresh tweets:  $count <br />";

//Update the new max tweet id
/* create a prepared statement */
if ($stmt = $mysqli->prepare("SELECT MAX(tweetid) FROM tweets")) {

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($max_tweetid);

    /* fetch value */
    $stmt->fetch();

    /* close statement */
    $stmt->close();
}

echo "max tweet id:  $max_tweetid <br />";


?>
