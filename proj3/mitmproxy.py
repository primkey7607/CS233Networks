import socket               
import getopt
import errno
import re
import ssl
import sys
import select
import time
import os 
#from thread import *
import threading

##########################################################
def usage():
   print "Usage:\n -h: bring up this help page\n -v: print the version number \n -p: add the port number to listen on\n -t: specify length of timeout\n -l: create log of HTTP/HTTPS responses\n"

###########################################################
def start():
    lPort = -1 
    num_workers = -1
    timeout = -1
    global log
    global countWorkers
    countWorkers = 0
    log = ""
    global reqdict
    reqdict = dict()

    try:
        opts, args = getopt.getopt(sys.argv[1:], "p:n:t:l:vh", ['help', 'version', 'port=', 'num_worker=', 'timeout=', 'log='])
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    for opt, arg in opts:
        if opt in ('-h', '--help'):
           usage()
           sys.exit(2)
        elif opt in ('-v', '--version'):
           print "Version No.: 0.1"
           sys.exit(0)
        elif opt in ('-p', '--port'):
           lPort = int(arg)
           #print lPort
        elif opt in ('-n', '--num_worker'):
           num_workers = int(arg)
           #print num_workers
        elif opt in ('-l', '--log'):
           log = arg
           #print log
        elif opt in ('-t', '--timeout'):
           timeout = int(arg)
           #print timeout
        else:
           usage()
           sys.exit(2)

    if lPort == -1:
       print "Usage: port argument required"
       sys.exit(2)
    if num_workers == -1:
       num_workers = 10 #default
    if timeout == -1:
       timeout = 2 #default
       
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        #print socket
        #print lPort
        s.bind(('', lPort))
        #print "Now listening"
        s.listen(5)
        print ("[*] initialization done on [%d]\n" % (lPort))
    except Exception, e:
        print e
        print "Unable to create socket\n"
        sys.exit(2)

    while 1:
        try:
            conn, addr = s.accept()
            #print "Starting new conn_thread"
            t_conn_handler = threading.Thread(target=conn_handler, args=(conn, buffer_size, addr, timeout, num_workers, log))
            t_conn_handler.daemon = True
            t_conn_handler.start()
            #start_new_thread(conn_handler, (conn, buffer_size, addr, timeout, num_workers, log))
            #conn_handler(conn, buffer_size, addr, timeout, num_workers, log)
        except KeyboardInterrupt:
            s.close()
            print "Proxy shutting down\n"
            sys.exit(1)
    s.close()

########################################################
def recv_timeout(the_socket,timeout=2):
    the_socket.setblocking(0)
    total_data=[];data='';begin=time.time()
    while 1:
        #if you got some data, then break after wait sec
        if total_data and time.time()-begin>timeout:
            break
        #if you got no data at all, wait a little longer
        elif time.time()-begin>timeout*2:
            break
        try:
            data=the_socket.read(8192)
            if data:
                total_data.append(data)
                begin=time.time()
            else:
                time.sleep(0.1)
        except:
            pass
    return ''.join(total_data)
########################################################

def conn_handler(connection, buff_size, addr, conn_timeout, num_workers, log):

    print "In conn_handler"
    global countWorkers

    data = connection.recv(buff_size)
    if len(data.strip()) == 0:
        connection.close()
        return
    if (threading.active_count() > num_workers) :
        reply = "HTTP/1.0 500 Internal Error\r\n"
        reply += "Proxy-agent: Pyx\r\n"
        reply += "\r\n"
        connection.send(reply)
        connection.close()
        return
    try:
        ###HERE
        getstr = 'get'
        connstr = 'connect'
        fl = data.split('\n')[0]
	    ###HERE
        req_str = fl.split(' ')[0]
        if (req_str.lower() == getstr) :
            url = fl.split(' ')[1]
            httpPos = url.find("://")
            if (httpPos == -1):
                temp = url
            else:
                temp = url[(httpPos+3):]
            portPos =temp.find(":")
            serverPos = temp.find("/")
            if serverPos == -1 :
                serverPos = len(temp)
            wserver = ""
            port = -1
            if (portPos == -1 or serverPos < portPos):
                port = 80
                wserver = temp[:serverPos]
            else:
                port = int((temp[(portPos+1):])[:serverPos-portPos-1])
                wserver = temp[:portPos]

            if reqdict.has_key(wserver):
               reqdict[wserver] = reqdict[wserver] + 1
            else:
               reqdict[wserver] = 1
            reqindex = reqdict[wserver]   
            countWorkers += 1
            #start_new_thread(proxy, (wserver, port, connection, addr, data, reqindex,conn_timeout))
            #proxy(wserver, port, connection, addr, data, reqindex,conn_timeout)
            t_proxy = threading.Thread(target=proxy, args=(wserver, port, connection, addr, data, reqindex,conn_timeout))
            t_proxy.daemon = True
            t_proxy.start()
        elif (req_str.lower() == connstr):
            fl = data.split('\n')[0]
            url = fl.split(' ')[1]
            httpPos = url.find("://")
            if (httpPos == -1) :
                temp = url
            else :
                temp = url[(httpPos+3):]
            portPos =temp.find(":")
            serverPos = temp.find("/")
            if serverPos == -1 :
                serverPos = len(temp)
            wserver = ""
            port = -1
            if (portPos == -1 or serverPos < portPos):
                port = 443
                wserver = temp[:serverPos]
            else:
                port = int((temp[(portPos+1):])[:serverPos-portPos-1])
                wserver = temp[:portPos]
            if reqdict.has_key(wserver):
               reqdict[wserver] = reqdict[wserver] + 1
            else:
               reqdict[wserver] = 1
            reqindex = reqdict[wserver]   
            countWorkers += 1
            #start_new_thread(s_proxy, (wserver, port, connection, addr, data, reqindex, conn_timeout))
            t_s_proxy = threading.Thread(target=s_proxy, args=(wserver, port, connection, addr, data, reqindex,conn_timeout))
            t_s_proxy.daemon = True
            t_s_proxy.start()
    except Exception, e:
        print e
        print "Data: " + data 
        pass

########################################################
def proxy(webserver, port, cl_conn, addr, data, reqindex, timeout) :
    print "In proxy"
    global countWorkers
    if (log != ""):
       filename = str(reqindex) + "_" + str(addr[0]) + "_" + str(webserver)  
       #cwd = check if we need this later
       filepath = log + filename
       fh = open(filepath, "w+")
       fh.write("Client request:\n" + data + "\n")
       fh.write("Server response:\n")
    try:
        serv_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        serv_sock.connect((webserver, port))
        serv_sock.send(data)
        #serv_reply = recv_timeout(serv_sock, timeout)
        while 1:	
              #serv_sock.settimeout(timeout)
              serv_reply = serv_sock.recv(8192)
              if len(serv_reply.strip()) == 0:
                 break
              cl_conn.send(serv_reply)
              if log != "":
                  fh.write(serv_reply)
              len_recv = float(len(serv_reply))
              len_recv = float(len_recv/1024)
              len_recv = "%.3s" % (str(len_recv))
              len_recv = "%s KB" % (len_recv)
              print "[*] Request Done: %s=>%s<= " %(str(addr[0]), str(len_recv))
        if log != "":
           fh.close()
        serv_sock.close
        cl_conn.close
        countWorkers -= 1
    except socket.error, (value, message):
        if log != "":
           fh.close()
        serv_sock.close
        cl_conn.close
        countWorkers -= 1
        sys.exit(1)

#######################################################

def s_proxy(webserver, port, conn, addr, data, reqindex,timeout) :
    print "in s_proxy with " + webserver
    print "\n"
    global countWorkers
    if (log != ""):
       filename = str(reqindex) + "_" + str(addr[0]) + "_" + str(webserver)  
       #cwd = check if we need this later
       filepath = log + filename
       fh = open(filepath, "w+")
       fh.write("Client request:\n" + data + "\n")
       fh.write("Server response:\n")
    try:
        s_ = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s = ssl.wrap_socket(s_, cert_reqs=ssl.CERT_REQUIRED, ca_certs="cacert.pem")
        try:
            s.connect((webserver, port))
            writebuf = 'GET / HTTP/1.1\r\nHost: ' 
            writebuf += webserver
            writebuf += '\r\n\r\n'
            s.write(writebuf)
            if log != "":
                fh.write(writebuf)
            d = s.read()
            #print d
            buf = recv_timeout(s, 5)
            if log != "":
                fh.write(buf)
            #print buf
            #cert = ssl.get_server_certification((webserver, port))
            s_.close()
        except socket.error as err:
            print "error connecting to " + webserver
            exit(0)
        time.sleep(1)
        reply = "HTTP/1.0 200 Connection established\r\n"
        reply += "Proxy-agent: Pyx\r\n"
        reply += "\r\n"
        conn.send(reply)
        if log != "":
            fh.write(reply)
        print "after send sock\n"
        connstream = ssl.wrap_socket(conn, server_side=True, certfile="servercert.pem", keyfile="serverkey.pem")
        print "after wrap sockect"
        connstream.write(buf)
        conn.shutdown(socket.SHUT_RDWR)
        conn.close()
    except socket.error as err:
	conn.close()
	s_.close()
"""
#        sproxy_sock = socket.create_connection((webserver, port))
#        sproxy_sock.settimeout(10)
#        time.sleep(1)
#        reply = "HTTP/1.0 200 Connection established\r\n"
#        reply += "Proxy-agent: Pyx\r\n"
#        reply += "\r\n"
#        #cl_wrapped_sock.write(reply)
#        client_conn.send(reply)
#        if log != "":
#            fh.write(reply)
#        print "after send sock\n"
#    except socket.error as err:
#        print "error in https socket creation\n";
#        return 
#    sproxy_sock.setblocking(0)
#    client_conn.setblocking(0)
#    while 1:
#        r, w, x = select.select([sproxy_sock, client_conn],[],[])
#        if sproxy_sock in r:
#            try :
#                server_reply = sproxy_sock.recv(buffer_size)
#                if len(server_reply) == 0 :
#                    break
#                try :
#                    client_conn.send(server_reply)
#                    if log != "":
#                        fh.write("\n" + "server Response:\n" + server_reply)
#                except socket.error:
#                    print "client socket busy"
#            except socket.error as e:
#                if e.errno != errno.ECONNRESET:
#                    raise
#                else :
#                    break
#        if client_conn in r:
#            try :
#                browser_reply = client_conn.recv(8192)
#                if len(browser_reply) == 0 :
#                    break
#                try :
#                    sproxy_sock.send(browser_reply)
#                    if log != "":
#                        fh.write("\n" + "client Response:\n" + browser_reply)
#                except socket.error:
#                    print "server socket busy"
#            except socket.error as e:
#                if e.errno != errno.ECONNRESET:
#                    raise
#                else :
#                    break
#    countWorkers -= 1
#    sproxy_sock.close()
#    client_conn.close()
"""
#######################################################
buffer_size = 8192
#reqindex = 0
start()
while True:
    time.sleep(1)
