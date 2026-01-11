# Zero-Dependency Web Application Plan

## Goal Description
Create a small full-stack application with a Frontend and Backend.
**Original Request**: Node/Postgres stack.
**Current Reality**: The environment lacks `node`, `npm`, `psql`, and `pip`.
**Proposed Solution**: Use **Python Standard Library** only.
- **Backend**: `http.server` (custom handler).
- **Database**: `sqlite3` from stdlib (Postgres is inaccessible without drivers).
- **Frontend**: Vanilla HTML/JS.

## User Review Required
> [!WARNING]
> **Missing Dependencies**: `node`, `npm`, `pip`, `psql` are not installed.
> I cannot install Flask, React, or Postgres drivers.
>
> **Proposed Workaround**:
> 1. Use **SQLite** instead of Postgres (it is built-in).
> 2. Use **Python `http.server`** instead of Express/Flask.
>
> If you strictly require Postgres, you must install `python3-psycopg2` or `libpq-dev` manually.

## Proposed Changes

### Backend
#### [NEW] [server.py](file:///home/vijaydurai/server.py)
- A custom `BaseHTTPRequestHandler` to serve `index.html` and handle API requests (`GET /items`, `POST /items`).
- Runs on port 8080.

### Database
#### [NEW] [database.py](file:///home/vijaydurai/database.py)
- Handles SQLite connection and schema initialization.
- Replaces the requested Postgres functionality.

### Frontend
#### [NEW] [index.html](file:///home/vijaydurai/index.html)
- A single-page app interacting with the backend API.
- Uses `fetch` to get/post data.

## Verification Plan

### Automated Tests
- None (pytest is likely missing).

### Manual Verification
1. Run `python3 server.py`.
2. Open Browser (or use `curl`) to `http://localhost:8080`.
3. Verify loading the page.
4. Verify adding an item (Database write).
5. Verify listing items (Database read).
