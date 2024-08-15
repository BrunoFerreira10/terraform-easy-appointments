phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands: |
            echo "Iniciando ssh-agent"
            eval $(ssh-agent -s)

            echo "Adicionando chave privada do github ao ssh-agent"
            PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)
            echo "$PRIVATE_KEY" | ssh-add -

            echo "Apagando dados de /var/www/html"
            cd /var/www/html
            rm -rf ./*

            echo "Alterando owner do diretório /var/www/html para ubuntu"
            chown -R ubuntu:ubuntu ./

            echo "Definindi /var/www/html com um diretório seguro para o git."
            sudo -u ubuntu git config --global --add safe.directory /var/www/html

            echo "Inicializando repositório git"
            sudo -u ubuntu git init

            echo "Adicionando remote 'origin': ${APP_REPOSITORY_URL}"
            sudo -u ubuntu git remote add origin ${APP_REPOSITORY_URL}

            echo "Excutando git fetch."
            sudo -u ubuntu GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin

            echo "Executando git reset --hard para origin/master"
            sudo -u ubuntu git reset --hard origin/master
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0