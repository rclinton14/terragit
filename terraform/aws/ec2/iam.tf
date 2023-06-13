resource "aws_iam_user" "user" {
  name          = "${local.resource_prefix.value}-user"
  force_destroy = true

  tags = merge({
    Name        = "${local.resource_prefix.value}-user"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "9f9ca61e9f76cad3f74c91dce8ad34ecfa248b35"
    git_file             = "terraform/aws/ec2/iam.tf"
    git_last_modified_at = "2023-06-11 04:14:04"
    git_last_modified_by = "itgeek@email.com"
    git_modifiers        = "itgeek"
    git_org              = "smakineni-panw"
    git_repo             = "terragoat-vuln"
    yor_trace            = "9b45b298-c1ea-426a-9644-610780021eaa"
    }, {
    yor_name = "user"
  })

}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "userpolicy" {
  name = "excess_policy"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*",
        "s3:*",
        "lambda:*",
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "username" {
  value = aws_iam_user.user.name
}

output "secret" {
  value = aws_iam_access_key.user.encrypted_secret
}
