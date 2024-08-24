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
      - composer install
      - npm install
      - npm run build

artifacts:
  files:
    - "**/*"
  discard-paths: no
  base-directory: "build"