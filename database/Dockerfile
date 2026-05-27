FROM python:3.11-slim

WORKDIR /app

COPY init.sql /app/init.sql
COPY init_db.py /app/init_db.py
COPY import_data.py /app/import_data.py
COPY data/ /app/data/

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*


RUN pip install pandas

RUN python init_db.py
RUN python import_data.py

CMD ["/bin/bash"]


