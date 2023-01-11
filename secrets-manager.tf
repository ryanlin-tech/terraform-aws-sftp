resource "aws_secretsmanager_secret" "gpg_private_key" {
  name = "GPG_PrivateKey"
  description = "Private key used for GPG decryption."
}