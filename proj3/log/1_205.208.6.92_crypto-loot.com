Client request:
CONNECT crypto-loot.com:443 HTTP/1.1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Proxy-Connection: keep-alive
Connection: keep-alive
Host: crypto-loot.com:443


Server response:
HTTP/1.1 400 Bad Request
Server: cloudflare-nginx
Date: Sun, 03 Dec 2017 02:51:41 GMT
Content-Type: text/html
Content-Length: 177
Connection: close
CF-RAY: -

<html>
<head><title>400 Bad Request</title></head>
<body bgcolor="white">
<center><h1>400 Bad Request</h1></center>
<hr><center>cloudflare-nginx</center>
</body>
</html>
