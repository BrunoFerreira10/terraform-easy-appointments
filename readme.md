# Sobre o projeto
## Descrição
Implementação de sistema Starfood na AWS usando IaC Terraform e repositório no 
Github.<br>
Execução dos scripts Terraform através do Github Actions.

## Estrutura
O projeto conta com vários **'sub-projetos'** Terraform, os quais se comunicam 
usando um **'remote state'** alocado em um S3.<br>
Com isso é possível criar e destruir os recursos de forma individual.

# Requisitos

## Requisitos da AWS
  - Usuário com acesso CLI e politicas de admintração do ambiente. 
  - Chave ssh criada para acesso via ssh.
  - Dominio e HostedZone (Router 53) previamente criados.

## Variavéis e Secrets configuradas no Github Actions
### Github Vars
| Variável                        | Exemplo                           | Detalhes |
| :---                            | :---                              | :---     |
| DOMAIN_BASE                     | brunoferreira86dev.com            |
| REGIAO                          | us-east-1                         |

### Github Secrets
| Variável                                | Exemplo                           | Detalhes |
| :---                                    | :---------------                  | :---     |
| AWS_DEV_CLI_ADMIN_KEY                   |                                   |
| AWS_DEV_CLI_ADMIN_SECRET                |                                   |
| AWS_DEV_CLI_ADMIN_SSH_PRIVATE_KEY       |                                   |