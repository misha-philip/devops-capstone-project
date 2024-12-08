FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt . 
COPY service/ ./service/

RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -m -r --uid 1000 theia && \
    chown -R theia:theia /app

USER theia

ENV port=8080

EXPOSE $port

CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]


