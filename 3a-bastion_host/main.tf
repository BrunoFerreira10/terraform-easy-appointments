# module "bastion_host" {
#   source               = "../modules/compute/ec2/bastion_host"
#   region               = module.data.github_vars.general_region
#   ec2_ssh_keypair_name = module.data.github_vars.ec2_ssh_keypair_name
#   vpc                  = module.data.vpc_app
# }
