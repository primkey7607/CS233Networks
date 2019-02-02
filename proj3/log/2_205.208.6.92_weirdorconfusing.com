Client request:
GET http://weirdorconfusing.com/css/style.css HTTP/1.1
Host: weirdorconfusing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/css,*/*;q=0.1
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://weirdorconfusing.com/
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: JkkclWFjvFuxqTFHf0zmOxO/uCWqyeth7DkISYlkS17T3pVNOBig/Zm4unMeJE+mIhqbkDtv9hc=
x-amz-request-id: 98556DEED7963DFB
Date: Sun, 03 Dec 2017 03:21:48 GMT
Last-Modified: Wed, 06 Jul 2016 18:12:43 GMT
ETag: "e4330f863e76a185b9f2040d11c3a8be"
Content-Type: text/css
Content-Length: 2818
Server: AmazonS3

html, body {
	padding: 0px;
	margin: 0px;
}

html {
	height: 100%;
	min-height: 460px;
	-webkit-font-smoothing: antialiased;
}

body {
	font-family: 'Courgette', cursive;
}

hgroup {
	margin-left: -250px;
	margin-top: -220px;
	position: absolute;
	width: 500px;
	left: 50%;
	top: 50%;
}

h1, h2, h3, h4, h5 {
	text-shadow: 2px 2px 1px #ccc;
	text-align: center;
	margin: auto;
	color: #333;
	font-weight: normal;
}

h1 {
	font-size: 85px;
}

h2 {
	margin-bottom: 7px;
	font-size: 30px;
}

h3 {
	font-size: 68px;
}

h4 {
	font-size: 63px;
}

h5 {
	font-size: 45px;
	margin-top: 5px;
}

button {
	font-family: inherit;
  padding: 10px 30px;
  padding-bottom: 8px;
	background-color: deepPink;
  margin: 30px;
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
	position: relative;

	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;

	border: 0px;
	font-size: 45px;

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
  height: 37px;
  padding-top: 4px;
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	color: #aaa;
	box-sizing: border-box;
	padding-left:10px;
	padding-right: 0px;
	transition: box-shadow 450ms;
	border-top: 1px dashed #aaa;
}

.text {
  font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
  font-weight: 400;
  position: relative;
  font-size: 13px;
  color: #525252;
  top: 3px;
}

.facebook {
  width: 77px;
}

.small {
	font-size: 12px;
}

iframe {
	margin: 5px;
	float: right;
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
		font-size: 65px;
	}

	h3 {
		font-size: 51px;
	}

	h4 {
		font-size: 49px;
	}

	h5 {
		font-size: 0;
    margin-top: 5px;
	}

	.monetary-thing {
		height: 100px;
		padding-bottom: 100px;
	}

	hgroup {
		width: 300px;
		margin-left: -150px;
	}

	.sharing {
		height: 70px !important;
	}

}