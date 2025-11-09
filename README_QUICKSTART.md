# Quick start (one command)

From the project root you can start both backend and frontend with the convenience script. The script will prepare a Python virtualenv for the backend (if needed), start the FastAPI backend in the background, then start the React frontend in the foreground.

Make sure you have Python 3 and Node.js/npm installed on your machine.

```bash
# make the script executable (only needed once)
chmod +x ./start-all.sh

# start both services
./start-all.sh
```

Alternatively you can use the provided Makefile:

```bash
make start
```

Notes:
- Backend logs are written to `logs/backend.log`.
- The frontend is served at http://localhost:3000 and proxies API requests to http://localhost:8000 (see `frontend/package.json`).
- If you prefer to manage venv/npm manually, use `make setup` first.
