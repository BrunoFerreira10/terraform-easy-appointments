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
| EC2_SSH_KEYPAIR_NAME            |                                   |
| GENERAL_REGION                  |                                   |
| GENERAL_REMOTE_STATE_BUCKET     |                                   |
| GENERAL_TAG_AUTHOR              |                                   |
| GENERAL_TAG_CUSTOMER            |                                   |
| GENERAL_TAG_PROJECT             |                                   |
| GENERAL_TAG_SHORTNAME           |                                   |
| IAM_AWS_ACCESS_KEY_ID           |                                   |
| IMAGE_BUILDER_PARENT_IMAGE      |                                   |
| RT53_DOMAIN                     |                                   |
| S3_LOGGING_BUCKET_NAME          |                                   |
| REGIAO                          |                                   |
| REGIAO                          |                                   |
| REGIAO                          |                                   |

### Github Secrets
| Variável                                | Exemplo                   | Detalhes |
| :---                                    | :---------------          | :---     |
| EC2_SSH_PRIVATE_KEY                     |                           |
| IAM_AWS_SECRET_ACCESS_KEY               |                           |
| SSH_PRIVATE_KEY_GITHUB                  |                           |