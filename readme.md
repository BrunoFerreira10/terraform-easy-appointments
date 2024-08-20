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
| APP_REPOSITORY_URL              | git@github.com:BrunoFerreira10/app-easy-appointments.git |
| EC2_SSH_KEYPAIR_NAME            | your-key-pair-name                                       |
| GENERAL_REGION                  | us-east-1                                                |
| GENERAL_PROJECT_BUCKET_NAME     | your-remote-state-bucket-name                            |
| GENERAL_TAG_AUTHOR              | Bruno Ferreira                                           |
| GENERAL_TAG_CUSTOMER            | CT Med                                                   |
| GENERAL_TAG_PROJECT             | terraform-easy-appointments                              |
| GENERAL_TAG_SHORTNAME           | easy-appointments                                        |
| IAM_AWS_ACCESS_KEY_ID           | AKHG30987GGI876JGJJKJ                                    |
| IMAGE_BUILDER_PARENT_IMAGE      | ami-04b70fa74e45c3917                                    |
| RT53_DOMAIN                     | brunoferreira86dev.com                                   |
| S3_LOGGING_BUCKET_NAME          | your-logging-bucket-name                                 |


### Github Secrets
| Variável                                | Exemplo                   | Detalhes |
| :---                                    | :---------------          | :---     |
| EC2_SSH_PRIVATE_KEY                     |                           |
| IAM_AWS_SECRET_ACCESS_KEY               |                           |
| SSH_PRIVATE_KEY_GITHUB                  |                           |