phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - eval $(ssh-agent -s)
        name: ssh-agent-start
        onFailure: "Abort"
      - action: ExecuteBash
        inputs:
          commands:
            - PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)
            - echo "$PRIVATE_KEY" | ssh-add -
        name: ssh-add-github-key
        onFailure: "Abort"
      - action: ExecuteBash
        inputs:
          commands:
            - cd /var/www/html
            - rm -rf ./*
            - chown -R ubuntu:ubuntu ./
            - sudo -u ubuntu git config --global --add safe.directory /var/www/html
            - sudo -u ubuntu git init
            - sudo -u ubuntu git remote add origin ${APP_REPOSITORY_URL}
            - sudo -u ubuntu GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin
            - sudo -u ubuntu git reset --hard origin/master
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0