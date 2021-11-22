### Configuração do haproxy-ingress
[Instalação do helm ](../helm/README.md#section)  

### Adicionando o repositório do haproxy-ingress pelo helm

```
    helm repo add haproxy-ingress https://haproxy-ingress.github.io/charts
```
### Geração do arquivo de Intalação e configuração do haproxy-ingress

```
    helm install haproxy-ingress haproxy-ingress/haproxy-ingress \
     --create-namespace --namespace=ingress-controller \
     --set controller.kind=DaemonSet \
     --set controller.daemonset.useHostPort=true \
      -o  yaml > haproxy-ingress-install.yaml
     
```

helm install haproxy-ingress haproxytech/kubernetes-ingress \
  --create-namespace --namespace=ingress-controller \
  --set controller.kind=DaemonSet \
  --set controller.daemonset.useHostPort=true \
  -f haproxy-ingress-values.yaml

  
### Instalação 

```
    kubectl apply -f haproxy-ingress-install.yaml -n ingress-controller
    kubectl apply -f haproxy-ingress-values.yaml 
```

Documentação: https://haproxy-ingress.github.io/docs/getting-started/


