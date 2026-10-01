aws_region   = "ap-south-2"
cluster_name = "my-cloud-journey-eks"
vpc_id       = "vpc-05b0acf0c413e87c6"

subnet_ids = [
  "subnet-01b1864ad02ba269e",
  "subnet-0fcc9a385bb1b427b",
  "subnet-0faa850c1b6635355"
]

node_instance_type = "t3.small"
kubernetes_version = "1.30"
