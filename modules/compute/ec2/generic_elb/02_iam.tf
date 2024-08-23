## --------------------------------------------------------------------------------------------------------------------
## Launch template instance IAM definitions
## --------------------------------------------------------------------------------------------------------------------

## Policies

## TODO - Converter politicas gerenciadas pela AWS em custom.

## Role definition
resource "aws_iam_role" "launch_tpl" {
  name = "role_launch_tpl_${var.shortname}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "role_launch_tpl_${var.shortname}"
  }
}

## Policies attachments
resource "aws_iam_role_policy_attachment" "ssm_managed_to_launch_tpl" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.launch_tpl.name
}

## Profile definition
resource "aws_iam_instance_profile" "launch_tpl" {
  name = "profile_launch_tpl_${var.shortname}"
  role = aws_iam_role.launch_tpl.name

  tags = {
    Name = "profile_launch_tpl_${var.shortname}"
  }
}
## --------------------------------------------------------------------------------------------------------------------