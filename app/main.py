import os
from fastapi import FastAPI
from fastapi.responses import RedirectResponse, JSONResponse

app = FastAPI(title="GHL OAuth Backend (MVP)")

@app.get("/health")
def health():
  return {"status": "ok"}

@app.get("/oauth/start")
def oauth_start():
  client_id = os.getenv("GHL_CLIENT_ID", "YOUR_CLIENT_ID")
  redirect_uri = os.getenv("OAUTH_REDIRECT_URI", "http://localhost:8000/oauth/callback")
  auth_url = (
    "https://app.gohighlevel.com/oauth/authorize"
    f"?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}"
  )
  return RedirectResponse(auth_url)

@app.get("/oauth/callback")
def oauth_callback(code: str | None = None, error: str | None = None):
  if error:
    return JSONResponse({"error": error})
  # TODO: exchange code for tokens via GHL token endpoint using client_secret
  return {"received_code": code, "note": "Exchange this code for tokens with GHL."}
