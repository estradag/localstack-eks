# LocalStack EKS example


TL;DR
- Single line - install and setup all
    > ./setup.sh

## Requirements
- MacOS v26.6.2+
    > It could work on previous MacOS versions or even a linux distribution, but this was the OS the development files were tested on
- docker v29.9.1
    > brew install docker@29.9.1
- colima v0.9.1
    > brew install colima@0.9.1
- docker-compose v5.6.0
    > brew install docker-compose@5.6.0
- tfenv v3.2.2 - Not required, but convenient to install
    > brew install tfenv@3.2.2
- terraform v1.16.6
    > tfenv install 1.16.6
- LocalStack (lstk) v1.4.1
    > brew install localstack/tap/lstk@1.4.1

## Setup
### First-time setup
> brew link docker # so colima can start the docker runtime
> colima start --cpu 4 --memory 8 --disk 50
> tfenv use 1.16.6
> lstk start
> # In your browser, setup your account as a hobbyist so you don't require to pay for anything
> # Back in your terminal, select AWS emulator and create a profile in your ~/.aws/config file, which should be named 'localstack' by default
> lstk login
