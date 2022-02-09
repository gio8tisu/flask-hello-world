FROM python:3.10

WORKDIR /app

ADD requirements.txt /app
RUN pip install -r requirements.txt

ADD hello.py /app

EXPOSE 80
