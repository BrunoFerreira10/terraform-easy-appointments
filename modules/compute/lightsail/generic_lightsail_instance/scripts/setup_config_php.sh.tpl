#!/bin/bash

# Configurando config.php
echo "------ Configurando config.php ------"
DB_PASSWORD=\$(cat /home/bitnami/bitnami_application_password)

cd /opt/bitnami/apache2/htdocs/
sed -i "s|const BASE_URL = '.*';|const BASE_URL = '${DOMAIN}';|" config.php
sed -i "s|const DB_HOST = '.*';|const DB_HOST = 'localhost';|" config.php
sed -i "s|const DB_NAME = '.*';|const DB_NAME = 'easy_appointments';|" config.php
sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = 'root';|" config.php
sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = '\$DB_PASSWORD';|" config.php