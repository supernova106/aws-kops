# aws-kops
To make your life easier

## Deploy Kubernetes

- For prod: `cp env.qa .env`
- Generate: terraform state file

```
make terraform
```

- Customize terraform
Using terraform as kops target output allows customizing k8s cluster and adding capabilities not managed by kops.

- Adjust k8s nodes IAM role policies

```
# Add the following policy into this file to allow cloudwatch, cloudwatch logs access by prometheus.
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:Describe*",
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "logs:Get*",
        "logs:List*",
        "logs:Describe*",
        "logs:TestMetricFilter",
        "logs:FilterLogEvents"
      ],
      "Resource": "*"
    },
```

In order to enable shared terraform state store create file config.tf with the following contents.

```
terraform {
  backend "s3" {
    bucket = "us-west-2.test-tf-state"
    key    = "k8s-kops-tf-state"
    region = "us-west-2"
  }
}
```

- Deploy
Run terraform to create kubernetes cluster

```
terraform init
terraform plan
terraform apply
```

- Check installation

```
$ kubectl get nodes
```

- Validate Cluster

```
$ kops validate cluster
```
