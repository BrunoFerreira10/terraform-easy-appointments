phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - |              
              while [ -z "$SSH_AUTH_SOCK" ]; do
                echo "Aguardando o ssh-agent iniciar (15s) ..."
                sleep 15
              done
            - echo "ssh-agent iniciado com sucesso."
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0
