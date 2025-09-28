```
cat <<EOF | kind create cluster --name my-cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-ing nginx-stable/nginx-ingress

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl apply -f app1/k8s
kubectl apply -f app2/k8s


curl http://api.127.0.0.1.nip.io/app1


curl http://api.127.0.0.1.nip.io/app2

```

