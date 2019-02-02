Client request:
GET http://thatsthefinger.com/ HTTP/1.1
Host: thatsthefinger.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://www.theuselessweb.com/
Connection: keep-alive
Upgrade-Insecure-Requests: 1


Server response:
HTTP/1.1 200 OK
x-amz-id-2: +H85o+dxTbtYSjvdta0tjWXOtzHVEuXDgl6dGWX7gCg3J5NKU3r+dIkIdob0p5KxMYyZIaQct4Y=
x-amz-request-id: 55A6C212F08B6C9F
Date: Sun, 03 Dec 2017 03:21:29 GMT
Last-Modified: Sun, 16 Nov 2014 23:19:06 GMT
ETag: "10caba7add34b5a7c8c3a90d0fba146b"
Content-Type: text/html
Content-Length: 1962
Server: AmazonS3

<!doctype html>
<html>
    <head>
        <title> The finger, deal with it. </title>

        <!-- CSS -->
        <link href='./css/styles.css' rel='stylesheet'>

        <!-- META -->
        <link rel="icon" type="image/png" href="/favicon.png" />

        <meta name="description" content="Yep, thats the finger!">
        <meta property="og:title" content="The finger, deal with it."/>
        <meta property="og:site_name" content="Thats the Finger"/>
        <meta property="og:description" content="Hey you betta check this out... yep, you deserve it."/>
        <meta property="og:image" content="http://thatsthefinger.com/img/share.png"/>
        <meta property="article:author" content="https://www.facebook.com/guy.trefler" />

        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="Yep, thats the finger.">
        <meta name="twitter:description" content="... Deal with it.">
        <meta name="twitter:image" content="http://thatsthefinger.com/img/share.png">

    </head>
    <body>
    	<div class="hand"></div>
    	<div class="share">
            <a href="https://twitter.com/share" class="twitter-share-button" data-text="The finger, yep, deal with it... via @guytrefler & @twholman -" data-align="right">Tweet</a>
            <div class="fb-like" data-href="http://thatsthefinger.com" data-send="false" data-layout="button_count" data-width="200" data-show-faces="false"></div>
    	</div>
        <script src='js/flip-the-bird.js'></script>
		<script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

		  ga('create', 'UA-56795519-1', 'auto');
		  ga('send', 'pageview');
		</script>
    </body>
</html>
