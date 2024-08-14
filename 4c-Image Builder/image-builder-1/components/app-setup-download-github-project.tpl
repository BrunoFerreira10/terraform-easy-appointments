phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "cd /var/www/html"
            - "rm -rf ./*"
            - "chown -R ubuntu:ubuntu ./"
            - "sudo -u ubuntu git config --global --add safe.directory /var/www/html"
            - "sudo -u ubuntu git init"
            - "sudo -u ubuntu git remote add origin ${APP_REPOSITORY_URL}"
            - "sudo -u ubuntu GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin"
            - "sudo -u ubuntu git reset --hard origin/master"
        name: upper("${shortname}-apt-update")
        onFailure: "Abort"
schemaVersion: 1.0