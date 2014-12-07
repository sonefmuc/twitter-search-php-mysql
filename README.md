This simple php/sql code set up a db and an api to search recent tweets based on hashtags you select. 

The api extracts all hashtags and urls mentioned in the tweet and uploads the values to dedicated tables in the database.

Fields extracted from the tweet and stored in the main table of the database are
 
user_name, screen_name, tweet, tweetid, retweet_count, followers_count, friends_count, listed_count, source, lang, coordinates_type, lon, lat,  location, date_tweeted



The code uses the library twitteroauth which is developed by Copyright (c) 2009 Abraham Williams - http://abrah.am - abraham@abrah.am

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
 
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


