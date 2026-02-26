FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*

COPY main.py .
COPY requirements.txt .

RUN pip install -r requirements.txt

CMD ["python3", "main.py"]

