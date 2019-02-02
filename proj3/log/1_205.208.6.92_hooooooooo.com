Client request:
GET http://hooooooooo.com/ HTTP/1.1
Host: hooooooooo.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://heeeeeeeey.com/
Connection: keep-alive
Upgrade-Insecure-Requests: 1


Server response:
HTTP/1.1 200 OK
x-amz-id-2: o5f+kxWYenl7cP1MZVI12ZUgACQoWC9Esecrt3oDSiWjNl71/2u6nGtu/+Sbh2vT8VQG08WUbeY=
x-amz-request-id: 334379BEF601A93F
Date: Sun, 03 Dec 2017 03:21:43 GMT
Last-Modified: Tue, 05 Jul 2016 03:33:24 GMT
ETag: "f0760422562c119bfbb6da859e446209"
Content-Type: text/html
Content-Length: 3850
Server: AmazonS3

<!DOCTYPE html>
<html>
<head>
	<meta name=viewport content="width=device-width,initial-scale=1">
  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.jplayer.min.js"></script>
  <script>
    $(document).ready(function(){


		$("h1").fitText();


		if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			setTimeout(function(){
				location.href = 'http://heeeeeeeey.com';
			}, 1000);
		} else {
			$("#jquery_jplayer_1").jPlayer({
				ready: function () {
					$(this).jPlayer("setMedia", {
						m4a: "ho.m4a",
						oga: "ho.ogg"
					}).jPlayer("play");
				},
				ended: function (event) {
					$(this).jPlayer("stop");
					location.href = 'http://heeeeeeeey.com';
				},
				swfPath: "js",
				supplied: "m4a, oga"
			});
		}

    });




    (function( $ ){

		$.fn.fitText = function( kompressor, options ) {

		    var settings = {
	        'minFontSize' : Number.NEGATIVE_INFINITY,
	        'maxFontSize' : Number.POSITIVE_INFINITY
	      };

				return this.each(function(){
					var $this = $(this);              // store the object
					var compressor = kompressor || 1; // set the compressor

	        if ( options ) {
	          $.extend( settings, options );
	        }

	        // Resizer() resizes items based on the object width divided by the compressor * 10
					var resizer = function () {
						$this.css('font-size', Math.max(Math.min($this.width() / (compressor*10), parseFloat(settings.maxFontSize)), parseFloat(settings.minFontSize)));
					};

					// Call once to set.
					resizer();

					// Call on resize. Opera debounces their resize by default.
	      	$(window).resize(resizer);

				});

		};

	})( jQuery );

  </script>
  <style>
  	html, body {
  		width: 100%;
  		height: 100%;
  		background-color: #000;
  		border: 0px;
  		padding: 0px;
  	}

  	#inner {
	  	width: 100%;
	  	height: 100%;
	  	display: table;
  	}

  	h1 {
  		display: table-cell;
  		vertical-align: middle;

  		font-family: Helvetica, Arial, sans-serif;
  		font-size: 50px;
  		text-align: center;
  		color: #fff;

  	}

  	#footer { bottom: 5px; position: absolute; color: #999; font-family: Helvetica, Arial, sans-serif; font-size: 11px;}
  	#social { bottom: 5px; right: 5px; position: absolute; }
  	a { color: #999; }
  </style>
  <title>HOOOOOOOOOOOOOO!</title>

  <script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-147514-30']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>
<body>

	<div id="jquery_jplayer_1" class="jp-jplayer"></div>
	<div id="inner">
	<h1>HOOOOOOOOO!</h1>
	</div>

	<div id="footer">
		Made by <a href="http://bod.ge">Mike Bodge</a> <a href="http://itunes.apple.com/us/album/greatest-hits-naughtys-nicest/id50235454?uo=4">iTunes</a>
	</div>

	<div id="social">
		<a href="http://twitter.com/share" class="twitter-share-button" data-count="none" data-via="mikebodge">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script> <iframe src="http://www.facebook.com/plugins/like.php?app_id=214234055277649&amp;href=http%3A%2F%2Fheeeeeeeey.com&amp;send=false&amp;layout=button_count&amp;width=500&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:50px; height:21px; padding-top: 2px;" allowTransparency="true"></iframe>
	</div>

</body>
</html>
