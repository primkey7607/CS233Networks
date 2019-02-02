Client request:
GET http://thatsthefinger.com/css/styles.css HTTP/1.1
Host: thatsthefinger.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/css,*/*;q=0.1
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://thatsthefinger.com/
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: 8WM92Zwgmrza9P8zGm5+cOFZs3j0YBt34v+RkBJFiVzifGUldK6MwJUkHJ9QGbQ1PDqhoxwXrAA=
x-amz-request-id: EE5740F1F1FD77D8
Date: Sun, 03 Dec 2017 03:21:29 GMT
Last-Modified: Sat, 01 Aug 2015 16:20:02 GMT
ETag: "849db4ae76a2482af5e0aec3ae6b60c3"
Content-Type: text/css
Content-Length: 969
Server: AmazonS3

/**
 * Flip them the bird!
 */
html, body {
  padding: 0px;
  margin: 0px;
}

body {
  background-color: #cccccc;
}

.hand {
  -webkit-transform: translate3d(-50%, -50%, 0);
  -moz-transform: translate3d(-50%, -50%, 0);
  -ms-transform: translate3d(-50%, -50%, 0);
  -o-transform: translate3d(-50%, -50%, 0);
  transform: translate3d(-50%, -50%, 0);
  position: absolute;
  height: 444px;
  width: 344px;
  left: 50%;
  top: 50%;
  background-image: url("/img/flippers.png");
}

.share {
  overflow: hidden;
  position: fixed;
  bottom: 15px;
  right: 15px;
}

.twitter-share-button {
  vertical-align: bottom;
  margin-right: 8px;
}

@media (max-width: 600px) {
  .hand {
    -webkit-transform: translate3d(-50%, -50%, 0) scale(0.6);
    -moz-transform: translate3d(-50%, -50%, 0) scale(0.6);
    -ms-transform: translate3d(-50%, -50%, 0) scale(0.6);
    -o-transform: translate3d(-50%, -50%, 0) scale(0.6);
    transform: translate3d(-50%, -50%, 0) scale(0.6);
  }
}
