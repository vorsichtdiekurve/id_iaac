# main.tf

resource "aws_ecr_repository" "ecr_test" {
  name                 = "id_iaac_ecr"
}
