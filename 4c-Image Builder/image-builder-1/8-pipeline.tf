resource "aws_imagebuilder_image_pipeline" "img-builder-pipeline-1" {
  name = "img-builder-pipeline-1"

  image_recipe_arn                 = aws_imagebuilder_image_recipe.recipe-1.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure-1.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.distribution-1.arn

  execution_role = "arn:aws:iam::096320584768:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.img-builder-workflow-1.arn
  }

  # schedule {
  #   schedule_expression                  = "cron(0 0 * * ? *)"  # Executa diariamente
  #   pipeline_execution_start_condition   = "EXPRESSION_MATCH_ONLY"
  # }

  # image_tests_configuration {
  #   image_tests_enabled = true
  #   timeout_minutes     = 720
  # }

  # testing_configuration {
  #   enabled = true
  #   tests {
  #     action = "ExecuteBash"
  #     name   = "TestNginxFunctionality"
  #     inputs = {
  #       commands = [
  #         "curl -I http://localhost | grep '200 OK'",  # Testa se o Nginx responde na porta 80
  #         "curl -I http://localhost/custom | grep '200 OK'",  # Testa a rota customizada
  #         "curl http://localhost | grep 'Welcome to the custom location!'",  # Verifica o conteúdo da página
  #         "sudo apt-get update && sudo apt-get install -y lynis",  # Instala o Lynis para verificação de segurança
  #         "sudo lynis audit system -Q --tests-from-group security",  # Executa uma auditoria básica
  #         "sudo lynis show findings | grep 'No issues found' || exit 1"  # Verifica se há problemas de segurança
  #       ]
  #     }
  #   }
  # }
}