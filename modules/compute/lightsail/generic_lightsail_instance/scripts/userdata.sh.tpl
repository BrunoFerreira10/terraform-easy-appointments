#!/bin/bash
## --------------------------------------------------------------------------------------------------------------------
## Use data start
## --------------------------------------------------------------------------------------------------------------------
echo "#### Iniciado user data ####"

## APT update
echo "------ APT Update ------"
apt update -y

echo "------ export AWS keys ------"
export AWS_REGION="${REGION}"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

## AWS Cli install
echo "------ Instalando AWS Cli ------"
cd /home/bitnami
apt-get install -y unzip curl
curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -rf ./aws

## Codedeploy agent install
echo "------ Instalando Codedeploy Agent ------"
mkdir -p /etc/codedeploy-agent/conf

cat <<EOT >> /etc/codedeploy-agent/conf/codedeploy.onpremises.yml
${CODEDEPLOY_ONPREMISES_YML}
EOT

cd /home/bitnami
apt install -y ruby-full
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install
chmod +x ./install
./install auto

## Create setup_config_php.sh file
echo "------ Criando setup_config_php.sh ------"
mkdir /home/bitnami/deploy
chown bitnami:bitnami /home/bitnami/deploy

cat <<EOT >> /home/bitnami/deploy/setup_config_php.sh
${SETUP_CONFIG_PHP_SH}
EOT
chmod a-rw /home/bitnami/deploy/setup_config_php.sh
chmod a+x /home/bitnami/deploy/setup_config_php.sh

## Create Database
DB_PASSWORD=$(cat /home/bitnami/bitnami_application_password)
/opt/bitnami/mariadb/bin/mariadb -u root -p"$DB_PASSWORD" -e "CREATE DATABASE easy_appointments;"

## Certificado SSL
apt-get install expect -y
cat <<EOT >> /home/bitnami/bncert-tool.exp
${BNCERT_TOOL_EXP}
EOT
chmod a+x /home/bitnami/bncert-tool.exp
/home/bitnami/bncert-tool.exp

## Register like on-premises no codedeploy
aws deploy register-on-premises-instance --instance-name ${INSTANCE_NAME} --iam-user-arn ${IAM_USER_ARN} --region ${REGION}

## --------------------------------------------------------------------------------------------------------------------
## Create finish flag files on /tmp/userdata_finished
## This file is read by terraform remote exec and sinalize that user data is finished
## and terraform scripts com follow.
## --------------------------------------------------------------------------------------------------------------------
echo "#### Finalizado user data ####"
sudo -u bitnami touch /tmp/userdata_finished