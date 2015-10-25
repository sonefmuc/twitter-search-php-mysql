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


/* create a prepared statement */
if ($stmt = $mysqli->prepare("SELECT * FROM email_tweets_tweetid_count")) {

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($screen_name,$tweet,$retweet_count);

    /* fetch values */
    while ($stmt->fetch()) {
        //printf ("%s (%s)\n", $name, $code);
	$email .= "RT: ".$retweet_count." - User ".$screen_name." said ".$tweet."\n"; 
    }

    /* close statement */
    $stmt->close();
}

$email .= "\n\n\nTop urls:\n"; 

/* create a prepared statement */
if ($stmt = $mysqli->prepare("SELECT * FROM top_urls")) {

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($url, $retweet_count);

    /* fetch values */
    while ($stmt->fetch()) {
        //printf ("%s (%s)\n", $name, $code);
	$email .= $url." - ".$retweet_count."\n"; 
    }

    /* close statement */
    $stmt->close();
}


$email .= "\n\n\nTop hashtags:\n"; 

/* create a prepared statement */
if ($stmt = $mysqli->prepare("SELECT * FROM top_hashtags")) {

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($hashtag, $retweet_count);

    /* fetch values */
    while ($stmt->fetch()) {
        //printf ("%s (%s)\n", $name, $code);
	$email .= $hashtag." - ".$retweet_count."\n"; 
    }

    /* close statement */
    $stmt->close();
}

//$stmt_ins = $mysqli->prepare("INSERT INTO parsed_tweets(tweetid, date_parsed) select ?,? from top_prv_day_tweets;");
//$stmt_ins->bind_param('is', $tweetid, $current_date);  
//$stmt_ins->execute();
//$stmt_ins->close();

$to = "recipient@email.com";
$subject.= "Top tweets for ".date("Y/m/d");
$headers = "From: no-relpy@twitteralerts.com" . "\r\n" .
"CC: youremail@email.com";

// send email
mail($to,$subject,$email,$headers);

if ($stmt = $mysqli->prepare("INSERT INTO tweets_dw (id, user_name, screen_name, tweet, tweetid, retweet_count, retweet_id, retweet_user, followers_count, friends_count, listed_count, source, lang, coordinates_type, lon, lat, location, date_tweeted) SELECT id, user_name, screen_name, tweet, tweetid, retweet_count, retweet_id, retweet_user, followers_count, friends_count, listed_count, source, lang, coordinates_type, lon, lat, location, date_tweeted from tweets where tweets.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}

if ($stmt = $mysqli->prepare("INSERT INTO tweets_hashtags_dw (tweetid, hashtag, date_tweeted) SELECT tweetid, hashtag, date_tweeted from tweets_hashtags where tweets_hashtags.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}

if ($stmt = $mysqli->prepare("INSERT INTO tweets_urls_dw (tweetid, url, date_tweeted) SELECT tweetid, url, date_tweeted from tweets_urls where tweets_urls.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}


if ($stmt = $mysqli->prepare("DELETE from tweets where tweets.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}

if ($stmt = $mysqli->prepare("DELETE from tweets_hashtags where tweets_hashtags.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}

if ($stmt = $mysqli->prepare("DELETE from tweets_urls where tweets_urls.date_tweeted < CURRENT_DATE -7")) {

	/* execute query */
	$stmt->execute();
		
	/* close statement */
	$stmt->close();
}

/* close connection */
$mysqli->close();



?>
