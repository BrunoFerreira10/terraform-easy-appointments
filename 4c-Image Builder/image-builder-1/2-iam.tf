# Image builder required policies
resource "aws_iam_policy" "img-builder-logs-policy" {
  name        = "${var.shortname}-img-builder-logs-policy"
  description = "Permite que Image Builder escreva logs no bucket S3."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "ImageBuilderLogsToS3",
        Effect = "Allow",
        Action = [
          "s3:PutObject",        # Permitir gravar logs
          "s3:PutObjectAcl",     # (Opcional) Definir ACLs nos objetos
          "s3:ListBucket",       # (Opcional) Listar objetos no bucket
          "s3:GetBucketLocation" # (Opcional) Obter a localização do bucket
        ],
        Resource = [
          "arn:aws:s3:::${data.terraform_remote_state.remote-s3-logging.outputs.s3-logging-s3-logging-1-id}/imagebuilder/*",
        ]
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          },
          # ArnLike = {
          #   "aws:SourceArn" = "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group/*"
          # }
        }
      }
    ]
  })
}

# Image Builder Instance Role And Profile
resource "aws_iam_role" "img-builder-ec2-instance-role" {
  name = "${var.shortname}-img-builder-ec2-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "ec2.amazonaws.com"
            # "imagebuilder.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "img-builder-role-attach-logs-policy" {
  policy_arn = aws_iam_policy.img-builder-logs-policy.arn
  role       = aws_iam_role.img-builder-ec2-instance-role.name
}

resource "aws_iam_role_policy_attachment" "img-builder-role-attach-default-policy" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
  role       = aws_iam_role.img-builder-ec2-instance-role.name
}
resource "aws_iam_role_policy_attachment" "img-builder-role-attach-ssm-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.img-builder-ec2-instance-role.name
}

resource "aws_iam_instance_profile" "img-builder-ec2-instance-profile" {
  name = "${var.shortname}-img-builder-logs-instance-profile"
  role = aws_iam_role.img-builder-ec2-instance-role.name
}