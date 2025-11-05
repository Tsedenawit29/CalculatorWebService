#!/usr/bin/env python3
"""
CORS Proxy Server for SOAP Calculator
Forwards requests from the web browser to the SOAP service with CORS headers
"""

from http.server import HTTPServer, SimpleHTTPRequestHandler
import urllib.request
import sys

SOAP_SERVICE_URL = 'http://localhost:9090/calculator'

class CORSProxyHandler(SimpleHTTPRequestHandler):
    
    def end_headers(self):
        """Override to add CORS headers to all responses"""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, SOAPAction')
        SimpleHTTPRequestHandler.end_headers(self)
    
    def do_OPTIONS(self):
        """Handle preflight CORS requests"""
        self.send_response(200)
        self.end_headers()
    
    def do_GET(self):
        """Serve static files with CORS headers"""
        return SimpleHTTPRequestHandler.do_GET(self)
    
    def do_POST(self):
        """Proxy POST requests to SOAP service"""
        if self.path == '/calculator' or self.path.startswith('/calculator?'):
            # Read the request body
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            try:
                # Forward to SOAP service
                req = urllib.request.Request(
                    SOAP_SERVICE_URL + (self.path[11:] if len(self.path) > 11 else ''),
                    data=post_data,
                    headers={'Content-Type': 'text/xml'}
                )
                
                with urllib.request.urlopen(req) as response:
                    soap_response = response.read()
                    
                    # Send response
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/xml')
                    self.send_header('Content-Length', len(soap_response))
                    self.end_headers()
                    self.wfile.write(soap_response)
                    
            except Exception as e:
                error_msg = f"Error connecting to SOAP service: {str(e)}"
                print(error_msg, file=sys.stderr)
                self.send_response(502)
                self.end_headers()
                self.wfile.write(error_msg.encode())
        else:
            self.send_error(404)
    
    def log_message(self, format, *args):
        """Custom log format"""
        print(f"[{self.log_date_time_string()}] {format % args}")


def run_server(port=8000):
    server_address = ('', port)
    httpd = HTTPServer(server_address, CORSProxyHandler)
    
    print("=" * 60)
    print("🌐 CORS Proxy Server for SOAP Calculator")
    print("=" * 60)
    print(f"📍 Web Calculator: http://localhost:{port}/calculator.html")
    print(f"🔗 Proxying to: {SOAP_SERVICE_URL}")
    print()
    print("⚠️  Make sure SOAP service is running!")
    print("   Run in another terminal: ./start-soap-service.sh")
    print()
    print("Press Ctrl+C to stop...")
    print("=" * 60)
    print()
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n\n👋 Shutting down proxy server...")
        httpd.shutdown()


if __name__ == '__main__':
    run_server()
