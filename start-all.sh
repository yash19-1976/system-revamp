#!/usr/bin/env zsh
set -euo pipefail

# start-all.sh
# Convenience script to prepare environment and start backend (uvicorn) in the background
# and frontend (create-react-app) in the foreground. Designed for macOS / zsh.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$LOG_DIR"

echo "[start-all] Root: $ROOT_DIR"

# --- Backend setup and start ---
echo "[start-all] Preparing backend..."
cd "$ROOT_DIR/backend"
if [ ! -d ".venv" ]; then
  echo "[start-all] Creating virtualenv (.venv)..."
  python3 -m venv .venv
fi

# shellcheck source=/dev/null
. .venv/bin/activate
python -m pip install --upgrade pip >/dev/null
if [ -f "requirements.txt" ]; then
  echo "[start-all] Installing backend Python requirements..."
  pip install -r requirements.txt >/dev/null
fi

echo "[start-all] Starting backend (uvicorn) on http://127.0.0.1:8000 ..."
nohup python -m uvicorn main:app --reload --host 127.0.0.1 --port 8000 > "$LOG_DIR/backend.log" 2>&1 &
echo "[start-all] Backend started (logs: $LOG_DIR/backend.log)"

# --- Frontend setup and start ---
cd "$ROOT_DIR/frontend"
if [ ! -d "node_modules" ]; then
  echo "[start-all] Installing frontend npm dependencies..."
  npm install
fi

echo "[start-all] Starting frontend (React) on http://localhost:3000 ..."
npm run dev
