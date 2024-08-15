phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - |
              echo "Aguardando o ssh-agent iniciar..."
              while [ -z "$SSH_AUTH_SOCK" ]; do
                sleep 15
              done
            - echo "ssh-agent iniciado com sucesso."
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0
