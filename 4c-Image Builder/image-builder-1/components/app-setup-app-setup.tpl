phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - cd /var/www/html
            - chmod a+rwx ./storage
            - sudo -u ubuntu mv config-sample.php config.php
            - sed -i "s|const BASE_URL = '.*';|const BASE_URL = '${BASE_URL}';|" config.php
            - sed -i "s|const DB_HOST = '.*';|const DB_HOST = '${DB_HOST}';|" config.php
            - sed -i "s|const DB_NAME = '.*';|const DB_NAME = '${DB_NAME}';|" config.php
            - sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = '${DB_USERNAME}';|" config.php
            - sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = '${DB_PASSWORD}';|" config.php
        name: upper("${shortname}-app-setup")
        onFailure: "Abort"
schemaVersion: 1.0