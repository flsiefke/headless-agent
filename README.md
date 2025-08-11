# GHL OAuth Backend (MVP)
Minimal FastAPI skeleton with OAuth routes for GoHighLevel (GHL).
> NOTE: Replace placeholders with your real GHL `client_id`, `client_secret`, and redirect URI.

## Run locally
```bash
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
# visit http://localhost:8000/health
```
## Docker
```bash
docker build -t ghl-oauth-mvp .
docker run -p 8000:8000 --env-file .env ghl-oauth-mvp
```
