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
    


Deploying the Dashboard UI 
The Dashboard UI is not deployed by default. To deploy it, run the following command:

    $ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml


Command line proxy 
You can enable access to the Dashboard using the kubectl command-line tool, by running the following command:

    $ kubectl proxy