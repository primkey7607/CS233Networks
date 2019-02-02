Client request:
GET http://detectportal.firefox.com/success.txt HTTP/1.1
Host: detectportal.firefox.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Cache-Control: no-cache
Pragma: no-cache
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 8
Last-Modified: Mon, 15 May 2017 18:04:40 GMT
ETag: "ae780585f49b94ce1444eb7d28906123"
Accept-Ranges: bytes
Server: AmazonS3
X-Amz-Cf-Id: mcQrtNe5aioA11zoayL96ltrFd7X1sRtfIZCI-apoFYl7Z6p19rPuQ==
Cache-Control: no-cache, no-store, must-revalidate
Date: Mon, 04 Dec 2017 03:20:00 GMT
Connection: keep-alive

success
