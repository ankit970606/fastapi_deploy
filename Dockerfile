# Lightweight base
FROM python:3.11-slim

# System deps often needed by OpenCV/ONNXRuntime
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 libsm6 libxext6 libgl1 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app
COPY . .

# (Optional) set a writable cache/home if you need it:
# ENV HF_HOME=/app/.cache/huggingface  INSIGHTFACE_HOME=/app/.cache/insightface
# RUN mkdir -p /app/.cache && chmod -R 777 /app/.cache

# Expose Spaces default port
EXPOSE 7860

# Start FastAPI with uvicorn on port 7860 (Spaces default)
CMD ["uvicorn", "model_api:app", "--host", "0.0.0.0", "--port", "7860"]
