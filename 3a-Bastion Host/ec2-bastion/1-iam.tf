# Criar Role
resource "aws_iam_role" "ec2-role-bastion-host" {
  name = "iam-role-bastion-host"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "bastion-host-role-attach-ssm-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2-role-bastion-host.name
}

# Cria profile baseado no role definido acima.
resource "aws_iam_instance_profile" "ec2-instance-profile-bastion-host" {
  name = "iam-instance-profile-bastion-host"
  role = aws_iam_role.ec2-role-bastion-host.name
}