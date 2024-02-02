resource "aws_iam" "name" {
  
}

data "aws_iam_policy_document" "eks_cluster_role" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterfacePermission",
      "iam:ListAttachedRolePolicies",
      "ec2:CreateSecurityGroup",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]

    actions = [
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupIngress",
    ]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["eks-cluster-sg*"]
    }
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:aws:ec2:*:*:vpc/*",
      "arn:aws:ec2:*:*:subnet/*",
    ]

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:TagKeys"
      values   = ["kubernetes.io/cluster/*"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:TagKeys"
      values   = ["kubernetes.io/cluster/*"]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:RequestTag/Name"
      values   = ["eks-cluster-sg*"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:route53:::hostedzone/*"]
    actions   = ["route53:AssociateVPCWithHostedZone"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/eks/*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/eks/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/eks/*:*:*"]
    actions   = ["logs:PutLogEvents"]
  }
}
