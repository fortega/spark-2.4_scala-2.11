#!/bin/bash

JSON_PATH=/secrets/gcp.json
APP_PATH=/app/app.jar

gcp_credentials(){
    if [[ -f $JSON_PATH ]]
    then
        echo "GCP credentials found in file $JSON_PATH"
    elif [[ ! -z ${GOOGLE_APPLICATION_CREDENTIALS} ]]
    then
        echo "GCP credentials found in env GOOGLE_APPLICATION_CREDENTIALS"
        echo $GOOGLE_APPLICATION_CREDENTIALS | base64 -d > $JSON_PATH
    else
        echo "GCP credentials not found"
        mkdir -p $(dirname $JSON_PATH)
        touch $JSON_PATH
    fi

    export GOOGLE_APPLICATION_CREDENTIALS=$JSON_PATH
}

run(){
    if [[ -f $APP_PATH ]]
    then
        echo Starting spark-submit: $APP_PATH
        echo ======================
        spark/bin/spark-submit /app/app.jar
    else
        echo Not found: $APP_PATH. Starting spark-shell
        echo ==========
        spark/bin/spark-shell
    fi
}

gcp_credentials
run