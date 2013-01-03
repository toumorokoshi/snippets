import json
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from os import curdir, sep

PORT_NUMBER = 8081

class JsonHandler(BaseHTTPRequestHandler):

    def _verify_json(self):
	if not 'content-type' in self.headers.keys():
	    print "Content type isn't set"
	elif self.headers['content-type'] != "application/json":
	    print "Content type isn't application/json, it's %s" % self.headers['content-type']
	response_string =  self.rfile.read(int(self.headers['content-length']))
	print "request string is: %s" % response_string
	try:
	    json.loads(response_string)
	except Exception as e:
	    print "Invalid json! %s" % str(e)

    def do_GET(self):
	self._verify_json()

    def do_POST(self):
	self._verify_json()

try: 
    server = HTTPServer(('', PORT_NUMBER), JsonHandler)
    print "Starting server on port %s..." % PORT_NUMBER
    server.serve_forever()

except KeyboardInterrupt:
    server.socket.close()
