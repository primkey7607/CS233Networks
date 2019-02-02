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
x-amz-id-2: DMG66C8pfw90lQIzKKo4auBIh+b8vK2XK0QZF9n7e7Mwrh5XCtMJtpT1r1nyFU198Vjjt721Wzo=
x-amz-request-id: 6BB730C1F0C3DB7A
Date: Mon, 04 Dec 2017 03:15:17 GMT
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