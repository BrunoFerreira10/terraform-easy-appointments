version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 18
    commands:
      - apt update
      - apt install -y composer
  build:
    commands:
      - ls -la

      - echo "------ Configura arquivo 'config-sample.php' e 'config.php' ------"
      - sed -i "s|const BASE_URL = '.*';|const BASE_URL = '${DOMAIN}';|" config-sample.php
      - sed -i "s|const DB_HOST = '.*';|const DB_HOST = '${DB_HOST}';|" config-sample.php
      - sed -i "s|const DB_NAME = '.*';|const DB_NAME = '${DB_NAME}';|" config-sample.php
      - sed -i "s|const DB_USERNAME = '.*';|const DB_USERNAME = '${DB_USERNAME}';|" config-sample.php
      - sed -i "s|const DB_PASSWORD = '.*';|const DB_PASSWORD = '${DB_PASSWORD}';|" config-sample.php

      - echo "------ Executando composer install ------"
      - composer install -n

      - echo "------ Executando npm install ------"
      - npm install

      - echo "------ Executando npm run build ------"
      - npm run build

      - echo "------ Renomeia arquivo config-sample.php ------"
      - mv build/config-sample.php build/config.php

artifacts:
  files:
    - "**/*"
  discard-paths: no
  base-directory: "build"