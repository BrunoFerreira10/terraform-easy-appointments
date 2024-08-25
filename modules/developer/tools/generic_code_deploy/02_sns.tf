# Referência ao bucket S3 existente usando o nome fornecido pela variável
data "aws_s3_bucket" "project_bucket_name" {
  bucket = var.project_bucket_name
}

# Criação do tópico SNS para receber notificações do S3
resource "aws_sns_topic" "s3_deployment_notifications" {
  name = "s3-deployment-notifications"
}

# Configuração de notificações do bucket S3 para enviar mensagens ao SNS
resource "aws_s3_bucket_notification" "s3_bucket_notifications" {
  bucket = data.aws_s3_bucket.project_bucket_name.id  # Corrigido para usar o ID do bucket S3 referenciado

  topic {
    topic_arn = aws_sns_topic.s3_deployment_notifications.arn  # Referencia o tópico SNS criado
    events    = ["s3:ObjectCreated:*"]

    filter_prefix = "code_deploy_outputs/"  # Modifique conforme necessário
    filter_suffix = "build.zip"
  }
}
