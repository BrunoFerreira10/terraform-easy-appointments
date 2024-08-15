phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands: 
            - |
              cd /var/www/html
              cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
              cp -f ./nginx.conf /etc/nginx/sites-available/default

              echo '${name}: Alterando owner do diretório /var/www/html para www-data'
              chown -R www-data:www-data /var/www/html

              echo '${name}: Acessando /var/www/html.'
              cd /var/www/html

              echo "${name}: Define permissões para 'storage'"
              chmod a+rwx ./storage

              echo "${name}: Configura arquivo 'config-sample.php' e 'config.php'"
              sed -i "s|const BASE_URL = '.*';|const BASE_URL = '${BASE_URL}';|" config-sample.php
              sed -i "s|const DB_HOST = '.*';|const DB_HOST = '${DB_HOST}';|" config-sample.php
              sed -i "s|const DB_NAME = '.*';|const DB_NAME = '${DB_NAME}';|" config-sample.php
              sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = '${DB_USERNAME}';|" config-sample.php
              sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = '${DB_PASSWORD}';|" config-sample.php

              sudo -u www-data cp config-sample.php config.php

              echo '${name}: Executando composer install'
              sudo -u www-data composer install

              echo '${name}: Executando npm install'
              sudo -u www-data npm install

              # echo '${name}: Executando npm run build'
              # sudo -u www-data npm run build
        name: '${name}'
        onFailure: "Abort"
schemaVersion: 1.0

# sed -i "s|const BASE_URL = '.*';|const BASE_URL = 'https://brunoferreira86dev.com';|" config.php
# sed -i "s|const DB_HOST = '.*';|const DB_HOST = 'terraform-20240814175106069800000001.ct2a8wqa2tv0.us-east-1.rds.amazonaws.com';|" config.php
# sed -i "s|const DB_NAME = '.*';|const DB_NAME = 'db_easyappointments';|" config.php
# sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = 'easyapp_rootuser';|" config.php
# sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = 'mZxfMY3Pbx8g9noexEeDcWeK9fFBzB';|" config.php