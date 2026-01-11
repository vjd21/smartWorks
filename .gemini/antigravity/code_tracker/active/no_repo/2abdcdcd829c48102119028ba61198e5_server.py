¦import http.server
import socketserver
import json
import database
from urllib.parse import urlparse, parse_qs

PORT = 8080

class SimpleHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        parsed_path = urlparse(self.path)
        
        if parsed_path.path == '/api/items':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            
            conn = database.get_db_connection()
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM items')
            items = [dict(row) for row in cursor.fetchall()]
            conn.close()
            
            self.wfile.write(json.dumps(items).encode())
            return

        # Serve static files (index.html, etc.)
        return super().do_GET()

    def do_POST(self):
        parsed_path = urlparse(self.path)
        
        if parsed_path.path == '/api/items':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            data = json.loads(post_data.decode())
            
            name = data.get('name')
            description = data.get('description', '')
            
            if name:
                conn = database.get_db_connection()
                cursor = conn.cursor()
                cursor.execute('INSERT INTO items (name, description) VALUES (?, ?)', (name, description))
                conn.commit()
                new_id = cursor.lastrowid
                conn.close()
                
                self.send_response(201)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({'id': new_id, 'name': name, 'description': description}).encode())
            else:
                self.send_response(400)
                self.end_headers()
                self.wfile.write(b'Name is required')
            return

        self.send_response(404)
        self.end_headers()

def run(server_class=http.server.HTTPServer, handler_class=SimpleHTTPRequestHandler):
    server_address = ('', PORT)
    httpd = server_class(server_address, handler_class)
    print(f"Starting server on port {PORT}...")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping server...")
        httpd.server_close()

if __name__ == "__main__":
    run()
¦*cascade082!file:///home/vijaydurai/server.py