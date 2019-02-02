Client request:
GET http://thatsthefinger.com/js/flip-the-bird.js HTTP/1.1
Host: thatsthefinger.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://thatsthefinger.com/
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: CgE1sq4y3rhCDPjdD+B5KbYhgZjaD+qSTRAW2Ayy01Cdm+WzijZ1XZ6g7EeHR0YJxrzkTDXDKao=
x-amz-request-id: 6D0EE34EFF5766D7
Date: Sun, 03 Dec 2017 03:21:29 GMT
Last-Modified: Sat, 01 Aug 2015 16:19:54 GMT
ETag: "74d74615edae5b3da344d1a75a9f78bf"
Content-Type: application/x-javascript
Content-Length: 3577
Server: AmazonS3

/**
 * What, code!?
 */

// SO GLOBAL. YES!
var damnItsTheBody = document.body;
var totalHeight = window.innerHeight;
var color1 = 'rgb(204, 204, 204)'; // super grey
var color2 = 'rgb(255, 66, 66)';   // super red!

var theWidth = 8256; // Pixels, fuck!
var theFrames = 24;
var thatWidth = theWidth / theFrames
var totalHeight = window.innerHeight;
var mobileOrigin;

var hand = document.querySelector( '.hand' );

function App() {

    this.init = function() {

    	// Wait! What! Someone Should trottle this! What! No! Damn!
		window.onmousemove = function( event ) {

			var percentage = 1 - ( event.y / totalHeight );
			var color = fadeToColor(color1, color2, percentage)
			damnItsTheBody.style.backgroundColor = color;

			var segment = Math.floor( 24 * percentage );

			// Wrangle those final frames!
			if ( segment > 23 ) {
    			segment = 23;
  			} else if ( segment < 0 ) {
  				segment = 0;
  			}

  			hand.style.backgroundPosition = ((-segment * thatWidth) + 'px 0px');
		}

        // For flip phones
        if (window.DeviceOrientationEvent) {
            window.addEventListener("deviceorientation", function () {
                mobileTilt([event.beta, event.gamma]);
            }, true);
        } else if (window.DeviceMotionEvent) {
            window.addEventListener('devicemotion', function () {
                mobileTilt([event.acceleration.x * 2, event.acceleration.y * 2]);
            }, true);
        } else {
            window.addEventListener("MozOrientation", function () {
                mobileTilt([orientation.x * 50, orientation.y * 50]);
            }, true);
        }

        window.onresize = function() {
            totalHeight = window.innerHeight;
        }

   		// Load Twitter
        !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');

        // Load Facebook
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
            fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
    }

    // Stack overflow is amazing! Smart! Kapow!
	function fadeToColor(rgbColor1, rgbColor2, ratio) {
	    var color1 = rgbColor1.substring(4, rgbColor1.length - 1).split(','),
	        color2 = rgbColor2.substring(4, rgbColor2.length - 1).split(','),
	        difference,
	        newColor = [];

	    for (var i = 0; i < color1.length; i++) {
	        difference = color2[i] - color1[i];
	        newColor.push(Math.floor(parseInt(color1[i], 10) + difference * ratio));
	    }

	    return 'rgb(' + newColor + ')';
	}

    // lel
    function mobileTilt(data){
        if(mobileOrigin === undefined){
            mobileOrigin = data[0];
        }
        var percentage = ((mobileOrigin - data[0]) + 8) / 16;
        var color = fadeToColor(color1, color2, percentage)
        damnItsTheBody.style.backgroundColor = color;

        var segment = Math.floor( 24 * percentage );

        // Wrangle those final frames!
        if ( segment > 23 ) {
            segment = 23;
        } else if ( segment < 0 ) {
            segment = 0;
        }

        hand.style.backgroundPosition = ((-segment * thatWidth) + 'px 0px');
    }
}

var app = new App();
app.init();
