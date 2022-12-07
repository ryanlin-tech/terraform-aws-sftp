provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "s3_default" {
  bucket = "sftp-s3-bucket-test"
}

module "sftp" {
  source      = "../"
  name        = "sftp"
  environment = "test"
  label_order = ["environment", "name"]

  enable_sftp   = true
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgNHjv9nLigWwal+dY5UiAlLFsVeBK2QKGveI3lMTR6Oj/WrGzCNJB5vMMubHmKg5dZvz5cSoSBa5gJ3ViGVYS47k/jZl/5mZDB0gIrQlbW/JWmmoDMqtYEv43vAMhNXzCCeB/giWG5G9iC0fJS/6JjWFDAkIVaEx+aNPPYZabsv6nnIp48zoKeseWjks+/duk7uEb9TgQkgRUS959RZzfBOn1mmuKDwtQz5wh3Ev7ws5wZzSQBAZw1S1EbX/HOMLhoTYuJmNAZQvMg8iZMszjRfJwtwrwJk3YccuxF+IzVrIthfIAQSHBysLJ3/MWoRvF5hkxPJa/u7Xg3oPApSNm1HPlQ1MqQCX1KyJYEjhFMfEj19vRckFKdb6U9WbOh5YADbrRrvqvfXX1pWfHb3Pe7ykKU0RzsVTc6oTV65RbfqW7Wb7MDKtfuj1gg+H72cYP7792pZkgOOtgFqbguJidk0ftt4Ls7UZALVClBt3Mw9sdqZXt1i/BumADjSDu97M= 82789@Ryan-Desktop"
  user_name     = "ftp-user"
  s3_bucket_id  = "sftp-s3-bucket-test"
  endpoint_type = "PUBLIC"
}
