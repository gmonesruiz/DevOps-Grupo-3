# CI-CD test
**	Argocd test

	
	minikube start
	kubectl port-forward svc/argocd-server -n argocd 8081:80
	kubectl logs -f -l app.kubernetes.io/instance=updater -n argocd
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo
	terraform init
	terraform apply
	kubectl apply -f 1-example/repo-secret.yaml
	kubectl apply -f 1-example/secret.yaml
	kubectl apply -f 1-example/application.yaml