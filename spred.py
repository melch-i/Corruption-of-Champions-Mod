#!/usr/bin/python

import SimpleHTTPServer
import SocketServer

PORT = 8000

class Handler(SimpleHTTPServer.SimpleHTTPRequestHandler):
	def do_GET(self):
		if self.path == "/":
			self.send_response(302) # Found
			self.send_header("Location", "/devTools/spred/spred.html")
			self.end_headers()
			return
		SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)
	def end_headers(self):
		self.send_header("Cache-Control","no-cache")
		SimpleHTTPServer.SimpleHTTPRequestHandler.end_headers(self)

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at http://localhost:"+str(PORT)+"/"
httpd.serve_forever()
