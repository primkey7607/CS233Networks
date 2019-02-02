Client request:
GET http://theuselessweb.com/ HTTP/1.1
Host: theuselessweb.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Upgrade-Insecure-Requests: 1


Server response:
HTTP/1.1 301 Moved Permanently
Date: Sun, 03 Dec 2017 03:19:47 GMT
Server: Apache
Location: http://www.theuselessweb.com
Content-Length: 0
Content-Type: text/html; charset=UTF-8
X-Varnish: 735849436 737127478
Age: 97
Via: 1.1 varnish-v4
X-redirector: MTk4MzEyMjYK
Connection: keep-alive

