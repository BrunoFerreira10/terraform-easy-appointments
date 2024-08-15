phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands: |
            echo '${name}: Iniciando ssh-agent'
            eval $(ssh-agent -s)

            echo '${name}: Adicionando chave privada do github ao ssh-agent'
            PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)
            echo "$PRIVATE_KEY" | ssh-add -

            echo '${name}: Apagando dados de /var/www/html'
            cd /var/www/html
            rm -rf ./*

            echo '${name}: Alterando owner do diretório /var/www/html para ubuntu'
            chown -R ubuntu:ubuntu ./

            echo '${name}: Configurando /var/www/html com um diretório seguro para o git.'
            sudo -u ubuntu git config --global --add safe.directory /var/www/html

            echo '${name}: Inicializando repositório git'
            sudo -u ubuntu git init

            echo '${name}: Adicionando remote 'origin': ${APP_REPOSITORY_URL}'
            sudo -u ubuntu git remote add origin ${APP_REPOSITORY_URL}

            echo '${name}: Excutando git fetch.'
            sudo -u ubuntu GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin

            echo '${name}: Executando git reset --hard para origin/master'
            sudo -u ubuntu git reset --hard origin/master
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0