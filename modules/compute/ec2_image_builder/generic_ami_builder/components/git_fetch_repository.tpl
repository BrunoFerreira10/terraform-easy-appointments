phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands: 
            - |
              echo '${NAME}: Iniciando ssh-agent'
              eval $(ssh-agent -s)

              echo '${NAME}: Adicionando chave privada do github ao ssh-agent'
              PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)
              echo "$PRIVATE_KEY" > /tmp/github_ssh_key
              chmod 600 /tmp/github_ssh_key
              ssh-add /tmp/github_ssh_key
              rm /tmp/github_ssh_key

              echo '${NAME}: Apagando dados de /var/www/html'
              cd /var/www/html
              rm -rf ./*

              echo '${NAME}: Configurando /var/www/html com um diretório seguro para o git.'
              git config --global --add safe.directory /var/www/html

              echo '${NAME}: Inicializando repositório git'
              git init

              echo '${NAME}: Adicionando remote 'origin': ${APP_REPOSITORY_URL}'
              git remote add origin ${APP_REPOSITORY_URL}

              echo '${NAME}: Excutando git fetch.'
              GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin

              echo "${NAME}: Restaura configuração original do 'StrictHostKeyChecking' para 'yes'"
              ssh -o StrictHostKeyChecking=yes true || echo '${NAME}: Falha ao restaurar StrictHostKeyChecking, verifique manualmente.'

              echo '${NAME}: Executando git reset --hard para origin/master'
              git reset --hard origin/master
        name: ${NAME}
        onFailure: "Abort"
schemaVersion: 1.0