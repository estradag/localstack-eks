#!/bin/bash
brew install colima@0.9.1 docker@29.9.1 docker-compose@5.6.0
brew link docker
colima start --cpu 4 --memory 8 --disk 50
brew install localstack/tap/lstk@1.4.1 tfenv@3.2.2
tfenv install 1.16.6
tfenv use 1.16.6
lstk start
lstk login