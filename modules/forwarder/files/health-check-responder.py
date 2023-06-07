#!/usr/bin/python2.7

import BaseHTTPServer
import sys


class Handler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write("OK\n")

    def log_request(self, code='-', size='-'):
        pass


if __name__ == '__main__':
    httpd = BaseHTTPServer.HTTPServer(("0.0.0.0", int(sys.argv[1])), Handler)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
