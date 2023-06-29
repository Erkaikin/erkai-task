FROM python:3.8-slim-buster

ENV env=test
WORKDIR /app
COPY ./app-code .
RUN pip3 install -r requirements.txt

ENTRYPOINT [ "python", "app.py" ]