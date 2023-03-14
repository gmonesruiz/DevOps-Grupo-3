**Cluster de kubernetes desplegado en AWS grupo3
**
> El cluster de compone de tres entornos, dev, staging y production. Ademas en la carpeta modules/aws-s3-bucket tenemos la herramienta para crear los recursos necesarios para guardar el backend de forma remota. 
>
> Luego de crear los recursos para el backend, se pueden empezar a desplegar los entornos.
.
> Cada entorno crea recursos de kubernetes en AWS



	$ terraform init
	$ terraform plan
	$ terraform apply

> Para este ejercicio vamos a comenzar agregando un hello world

	$ kubectl apply -f deployment.yaml

> Verificamos el nombre del pod y hacemos un port forwading, el puerto cambia segun el entorno

	$ kubectl get pods
	$ kubectl port-forward <hello-kubernetes-??????> 8080:8080

> Y verificamos que funciona ingresando a
	
	http://localhost:8080

> Luego para configurar un unico ingress para todos los pods, usamos helm
> Añadimos el repo para helm

	$ helm repo add eks https://aws.github.io/eks-charts

> Y bajamos ALB Ingress Controller en nuestro cluster con

	$ helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
	  --set autoDiscoverAwsRegion=true \
	  --set autoDiscoverAwsVpcID=true \
	  --set clusterName=learnk8s	

> A continuacion creamos el ALB ingress

	$ kubectl apply -f ingress.yaml
> El mismo se crea luego de unos minutos, para verificar el estado ejecutar

	$ kubectl describe ingress


> Para eliminar los recursos creados

	$ helm uninstall aws-load-balancer-controller
	$ terraform distroy
