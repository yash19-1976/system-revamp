SHELL := /bin/zsh

.PHONY: start backend frontend setup

start: ## Start both backend and frontend (recommended)
	./start-all.sh

backend: ## Start only the backend (assumes .venv exists)
	cd backend && . .venv/bin/activate && python -m uvicorn main:app --reload --host 127.0.0.1 --port 8000

frontend: ## Start only the frontend
	cd frontend && npm run dev

setup: ## Prepare both environments (venv + npm install)
	cd backend && python3 -m venv .venv && . .venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt
	cd frontend && npm install
