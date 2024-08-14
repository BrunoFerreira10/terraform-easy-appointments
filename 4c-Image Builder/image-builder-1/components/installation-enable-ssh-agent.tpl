phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "cat << 'EOF' > /etc/profile.d/ssh-agent.sh"
            - "#!/bin/bash"
            - ""
            - "# Inicia o ssh-agent e adiciona as chaves automaticamente no login"
            - "if [ -z \"$SSH_AUTH_SOCK\" ]; then"
            - "  eval $(ssh-agent -s)"
            - "  if [ -f ~/.ssh/id_rsa ]; then"
            - "    ssh-add ~/.ssh/id_rsa"
            - "  fi"
            - "fi"
            - "EOF"
            - ""
            - "chmod +x /etc/profile.d/ssh-agent.sh"
        name: upper("${shortname}-enable-ssh-agent")
        onFailure: "Abort"
schemaVersion: 1.1
