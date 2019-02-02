Client request:
GET http://www.theuselessweb.com/js/libs/utils.js HTTP/1.1
Host: www.theuselessweb.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://www.theuselessweb.com/
Connection: keep-alive
Pragma: no-cache
Cache-Control: no-cache


Server response:
HTTP/1.1 200 OK
x-amz-id-2: 38M1ajLDwd7A50IMI0JJShNJUhc0ZZvbpDXMdl9Etnt/W4Lbwv5KEOWZHijZPPwkJRIo679fD2E=
x-amz-request-id: 62EACEDF2B28AF78
Date: Sun, 03 Dec 2017 03:20:47 GMT
Last-Modified: Mon, 29 Oct 2012 23:00:28 GMT
ETag: "16f4fc81df3a70a23b9d4a3bbe36444b"
Content-Type: application/x-javascript
Content-Length: 145
Server: AmazonS3

function supportsHtmlStorage() {
	try {
		return 'localStorage' in window && window['localStorage'] !== null;
	} catch (e) {
		return false;
	}
}