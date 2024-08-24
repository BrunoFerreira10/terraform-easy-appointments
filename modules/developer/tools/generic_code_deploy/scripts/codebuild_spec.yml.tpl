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
      - composer install -n
      - npm install
      - npm run build

artifacts:
  files:
    - "**/*"
  discard-paths: no
  base-directory: "build"