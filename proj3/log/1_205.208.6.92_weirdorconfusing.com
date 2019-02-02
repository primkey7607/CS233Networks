Client request:
GET http://weirdorconfusing.com/ HTTP/1.1
Host: weirdorconfusing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://www.theuselessweb.com/
Connection: keep-alive
Upgrade-Insecure-Requests: 1


Server response:
HTTP/1.1 200 OK
x-amz-id-2: 1nr/q4jHb+M1Tuxw7T7NAuyjVpg2plAt1hCkTNl/BT66wD+NWHGw5rUHkQfifEdfE+GE4Yeex0A=
x-amz-request-id: A8B1B2D1B27C481A
Date: Sun, 03 Dec 2017 03:21:48 GMT
Last-Modified: Thu, 05 Oct 2017 17:43:08 GMT
ETag: "72e36c547f4f2d801f79735716de05c1"
Content-Type: text/html
Content-Length: 3232
Server: AmazonS3

<!doctype html>
<html>
	<head>
		<title> Weird or Confusing </title>

		<!-- META -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="Weird or Confusing... there's a lot of strange stuff out there!">
		<link rel="icon" href="favicon.ico" type="image/x-icon" />

		<!-- Facebook -->
		<meta property="og:title" content="Weird or Confusing"/>
		<meta property="og:url" content="http://weirdorconfusing.com/"/>
		<meta property="og:site_name" content="Weird or Confusing"/>
		<meta property="og:type" content="website"/>
		<meta property="og:description" content="There's a lot of odd stuff out there, really, weird stuff."/>
		<meta property="og:image" content="http://weirdorconfusing.com/share-image-smalls.png"/>

		<!-- Twitter -->
		<meta name="twitter:card" content="summary">
    	<meta name="twitter:title" content="Weird or Confusing">
    	<meta name="twitter:url" content="http://weirdorconfusing.com">
    	<meta name="twitter:description" content="There's a lot of odd stuff out there, really, weird stuff.">
    	<meta name="twitter:image:src" content="http://weirdorconfusing.com/share-image-smalls.png">

		<!-- CSS -->
		<link href="css/style.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Courgette" rel="stylesheet">

		<!-- JS -->
		<script type="text/javascript" src="js/weird-or-confusing.js"></script>
	</head>
	<body>

		<hgroup>
			<h1> SELL ME </h1>
			<h2 id='joint'> SOMETHING </h2>
			<h3> WEIRD OR </h3>
			<h4> CONFUSING </h4>
			<h5>&rarr;<button id='button'>PLEASE</button>&larr;</h5>
			
			<script>
				var uselessWebButton = new uselessWebButton( document.getElementById( 'button' ) ); 
			</script>
		</hgroup>


 		<div class='sharing'>

 			<span class='text'>Weird or confusing stuff on ebay, at the click of a button!</span>

 			<span class='buttons'>

				<iframe class="facebook" src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Fweirdorconfusing.com&amp;width&amp;layout=button_count&amp;action=like&amp;show_faces=false&amp;share=false&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px;" allowTransparency="true"></iframe>

				<a href="https://twitter.com/share" data-text="Weird or Confusing... there's a lot of strange stuff out there! - " class="twitter-share-button" data-count="none" data-url="http://weirdorconfusing.com" data-lang="en" data-align="right" data-via="twholman">Tweet</a>
				
				<script>
					!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="http://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
				</script>
			</span>
		</div>

	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-81407516-1', 'auto');
	  ga('send', 'pageview');

	</script>

	</body>
</html>