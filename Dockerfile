FROM python:latest
WORKDIR /usr/src/app
COPY . /usr/src/app
CMD ["python3", "app.py"]
