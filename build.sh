#!/bin/bash
docker image rm pcloudcc-deb:latest

docker build -t pcloudcc-deb:latest .

rm -rf $(pwd)/out

docker run --name tmp_pcloudcc-deb pcloudcc-deb

docker cp tmp_pcloudcc-deb:/out ./

docker rm tmp_pcloudcc-deb

