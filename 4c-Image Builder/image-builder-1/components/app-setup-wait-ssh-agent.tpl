phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands: |
            # Verifica se o ssh-agent está rodando
            echo "Verificando o status do ssh-agent..."
            if [ -z "$SSH_AUTH_SOCK" ]; then
              eval $(ssh-agent -s)
            fi

            # Aguarda até que o ssh-agent esteja rodando corretamente
            while [ -z "$SSH_AUTH_SOCK" ]; do
              echo "Aguardando o ssh-agent iniciar..."
              sleep 15
            done

            echo "ssh-agent iniciado com sucesso."

        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0
