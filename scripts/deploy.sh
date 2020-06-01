#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/SweaterTest.pem \
  target/sweater-1.0-SNAPSHOT.jar \
  ubuntu@52.28.23.112:/home/ubuntu/

echo 'Restart server...'

ssh -i ~/.ssh/SweaterTest.pem ubuntu@52.28.23.112 << EOF
pgrep java | xargs kill -9
nohup java -jar sweater-1.0-SNAPSHOT.jar > log.txt &
EOF

echo 'Bye'