Client request:
CONNECT shavar.services.mozilla.com:443 HTTP/1.1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Proxy-Connection: keep-alive
Connection: keep-alive
Host: shavar.services.mozilla.com:443


Server response:
GET / HTTP/1.1
Host: shavar.services.mozilla.com

HTTP/1.0 200 Connection established
Proxy-agent: Pyx

