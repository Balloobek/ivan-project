from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from ivan-project!"}

@app.get("/health")
def health_check():
    return {"status": "ok"}