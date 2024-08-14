#!/bin/bash

# Inicia o ssh-agent e adiciona as chaves automaticamente no login
# Ainda não está sendo usado, ver como transferir para instcia do img-builder.
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s)
  if [ -f ~/.ssh/id_rsa ]; then
    ssh-add ~/.ssh/id_rsa
  fi
fi