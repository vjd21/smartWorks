import sqlite3
import os

DB_NAME = "app.db"

def init_db():
    start_fresh = False
    if not os.path.exists(DB_NAME):
        start_fresh = True
        
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    
    # Create table if not exists
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT
        )
    ''')
    
    # Seed data if fresh
    if start_fresh:
        print("Seeding database...")
        cursor.execute("INSERT INTO items (name, description) VALUES (?, ?)", ("Sample Item", "This is a test item"))
        conn.commit()
    
    conn.close()
    print(f"Database {DB_NAME} initialized.")

def get_db_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row
    return conn

if __name__ == "__main__":
    init_db()
