#!/usr/bin/env python

import os
import SimpleHTTPServer
import SocketServer

os.chdir('/tmp/gify-panda/resources')
PORT = 8070

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
