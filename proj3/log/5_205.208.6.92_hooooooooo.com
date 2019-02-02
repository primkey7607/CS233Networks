Client request:
GET http://hooooooooo.com/favicon.ico HTTP/1.1
Host: hooooooooo.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: zK/TKAM/VTk3x70Q+l3JhzdcyqM1d2rwFooCVzaypDQgBkpm9EnsS2xhRhE1lJEng0GovLsg3zk=
x-amz-request-id: 90C10EEEE681F24C
Date: Sun, 03 Dec 2017 03:21:47 GMT
Last-Modified: Sun, 03 Jul 2016 03:49:18 GMT
ETag: "d41d8cd98f00b204e9800998ecf8427e"
Content-Type: image/x-icon
Content-Length: 0
Server: AmazonS3

