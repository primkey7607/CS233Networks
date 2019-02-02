Client request:
GET http://www.theuselessweb.com/css/style.css HTTP/1.1
Host: www.theuselessweb.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/css,*/*;q=0.1
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://www.theuselessweb.com/
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: dd14duDXDMDkuC1S1J8PJpT0RTieYPW2Q4+jeJiW97F4bcfy1rcGX/Y6NoAqxiFmZutoc2XR5lQ=
x-amz-request-id: 6E09E94981F16F7F
Date: Sun, 03 Dec 2017 03:21:26 GMT
Last-Modified: Sat, 11 Mar 2017 17:27:46 GMT
ETag: "79d44c8937373560ecb6863d52f46edd"
Content-Type: text/css
Content-Length: 4063
Server: AmazonS3

html, body {
	padding: 0px;
	margin: 0px;
}

html {
	font-family: 'Josefin Slab', 'Times';
	background: #ffffff;
	background: -moz-radial-gradient(center, ellipse cover,  #ffffff 0%, #f2f2f2 100%);
	background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%,#ffffff), color-stop(100%,#f2f2f2));
	background: -webkit-radial-gradient(center, ellipse cover,  #ffffff 0%,#f2f2f2 100%);
	background: -o-radial-gradient(center, ellipse cover,  #ffffff 0%,#f2f2f2 100%);
	background: -ms-radial-gradient(center, ellipse cover,  #ffffff 0%,#f2f2f2 100%);
	background: radial-gradient(ellipse at center,  #ffffff 0%,#f2f2f2 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f2f2f2',GradientType=1 );
	height: 100%;
	min-height: 460px;
}

body {
}

hgroup {
	margin-left: -250px;
	margin-top: -250px;
	position: absolute;
	width: 500px;
	left: 50%;
	top: 50%;
}

h1, h2, h3, h4, h5 {
	text-shadow: 2px 2px 4px #999;
	text-align: center;
	margin: auto;
	color: #333;
}

h1 {
	font-size: 68px;
}

h2 {
	margin-bottom: 7px;
	font-size: 30px;
}

h3 {
	font-size: 78px;
}

h4 {
	font-size: 72px;
}

h5 {
	font-size: 45px;
}

button {
	padding: 10px;
	padding-bottom: 2px;
	background-color: deepPink;
	margin: 10px;
	color: white;
	text-shadow: none;
	box-shadow: 1px 0px 1px #BE3077,
				0px 1px 1px hotpink,
				2px 1px 1px #BE3077,
				1px 2px 1px hotpink,
				3px 2px 1px #BE3077,
				2px 3px 1px hotpink,
				4px 3px 1px #BE3077,
				3px 4px 1px hotpink,
				5px 4px 1px #BE3077,
				4px 5px 1px hotpink,
				6px 5px 1px #BE3077;
	cursor: pointer;
	display: inline-block;
	margin-top: 11px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	position: relative;
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;

	border: 0px;
	font-size: 45px;
	font-weight: normal;
	font-family: 'Josefin Slab', cursive;
	outline: 0px;
}

button:hover {
	background-color: #E21A62;
}

button:active {
	box-shadow: 1px 0px 1px #BE3077,
				0px 1px 1px hotpink,
				2px 1px 1px #BE3077,
				1px 2px 1px hotpink,
				3px 2px 1px #BE3077;
    top: 2px;
    left: 3px;
}

.sharing {
	box-shadow: 0px 0px 0px 3px rgba(0, 0, 0, 0.15);
	height: 30px;
	background-color: #232323;
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	color: #232323;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	padding-left:10px;
	padding-right: 10px;

	-webkit-transition: box-shadow 450ms;
	-moz-transition: box-shadow 450ms;
	-ms-transition: box-shadow 450ms;
	-o-transition: box-shadow 450ms;
	transition: box-shadow 450ms;
}

.sharing:hover {
	box-shadow: 0px 0px 0px 4px deeppink;
}

.sharing a {
	color: greenyellow;
}

.text {
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif; 
   	font-weight: 300;
	top: -9px;
	position: relative;
	font-size: 13px;
	color: #fff;
	top: 7px;
}

.facebook {
	width: 48px;
}

.small {
	font-size: 12px;
}

iframe {
	margin: 5px;
	float: right;
}

.monetary-thing {
	margin-top: 90px;
}

@media only screen and (max-width : 980px) {

	.sharing {
		height: 55px !important;
	}

	.text {
		width: 100%;
		text-align: center;
		position: absolute;
		box-sizing: border-box;
		-moz-box-sizing: border-box;
		padding-right: 25px;
	}

	.buttons {
		position: absolute;
		bottom: 0px;
		left: 50%;
		margin-left: -60px
	}

}

@media only screen and (max-width : 650px) {

	h1 {
    font-size: 55px;
	}

	h3 {
		font-size: 65px;
	}

	h4 {
		font-size: 61px;
	}

	h5 {
    font-size: 31px;
	}

	button {
		font-size: 40px;
	}

	hgroup {
    width: 100%;
    text-align: center;
    margin-left: 0px;
    position: relative;
    margin-top: 50px;
    left: 0px;
    top: 0px;
	}

	.monetary-thing {
		height: 120px;
		box-sizing: border-box;
    margin-top: 60px;
    padding-left: 5px;
    padding-right: 5px;
    width: 100%;
    padding-bottom: 0px;
	}

	.sharing {
		height: 90px !important;
	}

}