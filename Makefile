build:
	nerdctl --namespace k8s.io build -t simpleserver:latest .
	@echo "Build Complete"

run:
	kubectl apply -f deploy/kubernetes/simple-full-deployment.yaml
	@echo "Deployed Application in Kubernetes Cluster"

istio-run:
	kubectl apply -f deploy/kubernetes/full-app-istio.yaml
	@echo "Deployed Application in Kubernetes Cluster with Istio"

clean:
	kubectl delete -f deploy/kubernetes/simple-full-deployment.yaml
	@echo "Deployment deleted"

istio-clean:
	kubectl delete -f deploy/kubernetes/full-app-istio.yaml
	@echo "Istio Deployment deleted"

install-istio:
	brew install istioctl
	istioctl install