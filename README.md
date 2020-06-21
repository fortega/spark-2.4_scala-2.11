# Spark 3.0 Docker image

## Versions

* Hadoop 2.7 (build in)
* Spark 3.0.0
* Scala 2.12.10

## Extras

* Avro file format
* BigQuery connector
* Cloud Storage connector

## Enviroment variables

### GOOGLE_APPLICATION_CREDENTIALS

(optional)

Base64's encoded Account Service File

## Ports

### tcp/4040

Spark context

## BUILD

> docker build -t felipeortega/spark-3.0 .

## RUN spark-shell

> docker run -p 4040:4040 -e GOOGLE_APPLICATION_CREDENTIALS=$(base64 -w0 /path/to/json) -it --rm --name spark24 felipeortega/spark-3.0

## RUN spark-submit

Executes /app/app.jar

> docker run -p 4040:4040 -e GOOGLE_APPLICATION_CREDENTIALS=$(base64 -w0 /path/to/json) -v $PWD/app:/app -it --rm --name spark24 felipeortega/spark-3.0
