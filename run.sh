#!/bin/bash

docker build . -t aidancrowther/sql:0.05 --build-arg sql_password=testing
docker kill SQL
docker rm SQL
docker run -d --name SQL -p 3000:3306 aidancrowther/sql:0.05
