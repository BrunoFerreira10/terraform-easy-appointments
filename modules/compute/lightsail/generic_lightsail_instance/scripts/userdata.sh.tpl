#!/bin/bash
## --------------------------------------------------------------------------------------------------------------------
## Use data start
## --------------------------------------------------------------------------------------------------------------------
echo "#### Iniciado user data ####"

## AWS Cli install
cd /home/bitnami
apt-get install -y unzip curl
curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -rf ./aws

## Setup env vars
# export AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}"
# export AWS_SECRET_ACCESS_KEY="j${SECRET_ACCESS_KEY}"
# export AWS_REGION="${REGION}"

## Codedeploy agent install
mkdir -p /etc/codedeploy-agent/conf

cat <<EOT >> /etc/codedeploy-agent/conf/codedeploy.onpremises.yml
---
aws_access_key_id: ${ACCESS_KEY_ID}
aws_secret_access_key: ${SECRET_ACCESS_KEY}
iam_user_arn: ${IAM_USER_ARN}
region: ${REGION}
EOT

cd /home/bitnami
apt install -y ruby-full
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install
chmod +x ./install
./install auto

## Create setup_config_php.sh file
mkdir /home/bitnami/deploy
chown bitnami:bitnami /home/bitnami/deploy

DB_PASSWORD = $(cat /home/bitnami/bitnami_application_password)

cat <<EOT >> /home/bitnami/deploy/setup_config_php.sh
# Configurando config.php
cd /opt/bitnami/apache2/htdocs/
sed -i "s|const BASE_URL = '.*';|const BASE_URL = '${DOMAIN}';|" config.php
sed -i "s|const DB_HOST = '.*';|const DB_HOST = 'localhost';|" config.php
sed -i "s|const DB_NAME = '.*';|const DB_NAME = 'easy_appointments';|" config.php
sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = 'root';|" config.php
sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = '$DB_PASSWORD';|" config.php
EOT
chmod a-rw /home/bitnami/deploy/setup_config_php.sh

## Create Database
mariadb -u root -p'$DB_PASSWORD' -e "CREATE DATABASE easy_appointments;"

## --------------------------------------------------------------------------------------------------------------------
## Create finish flag files on /tmp/userdata_finished
## This file is read by terraform remote exec and sinalize that user data is finished
## and terraform scripts com follow.
## --------------------------------------------------------------------------------------------------------------------
echo "#### Finalizado user data ####"
sudo -u ubuntu touch /tmp/userdata_finished