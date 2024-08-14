phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            # Recuperar a chave privada do SSM Parameter Store
            - "PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)"

            # Passar a chave diretamente para o ssh-add
            - "echo \"$PRIVATE_KEY\" | ssh-add -"
            
      - name: ${name}
      - onFailure: "Abort"
schemaVersion: 1.0
