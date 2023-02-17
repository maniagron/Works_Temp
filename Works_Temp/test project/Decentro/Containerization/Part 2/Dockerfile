FROM python:3.9

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

COPY crawler.py /app/crawler.py

CMD ["python", "/app/crawler.py"]