For S3 Bucket, 

chmod +x 

terraform init
terraform plan
terraform apply -auto-approve

Export kubernetes config
    $ aws eks --region eu-west-3 update-kubeconfig --name my-demo
    $ aws eks --region eu-west-3 describe-cluster --name my-demo --query cluster.status
    $ kubectl get svc
    $ kubectl get nodes
    $ kubectl get all
    $ kubectl exec aws-cli -- aws s3api list-buckets
    


