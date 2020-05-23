#!/bin/sh

sudo apt update
sudo apt upgrade -y

# apache 서버 설치
sudo apt install -y apache2

sudo tar -zxvf php-7.0.33.tar.gz
sudo tar -zxvf php-operator.tgz