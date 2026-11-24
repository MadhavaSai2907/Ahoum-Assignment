
resource "aws_secretsmanager_secret" "mongo_uri" {
  name                    = "${var.project_name}-mongo-uri"
  description             = "MongoDB connection string for Sessions API"
  recovery_window_in_days = 7

  tags = {
    Name = "${var.project_name}-mongo-secret"
  }
}
