# Road Map tools TCC 2

### Haproxy configuration vm load balancer

    - Install haproxy

    ~# apt install -y haproxy
    ~# vim /etc/haproxy/haproxy.cfg
        frontend kubernetes
            mode tcp
            bind ip-vm-haproxy:6xxx # vm haproxy ip
            option tcplog
            default_backend k8s-master

        backend k8s-master
            mode tcp
            balance roundrobin
            option tcp-check
            server k8s-master ip-node-masterj:6xxx check fall 3 rise 2

    ~# systemclt restart haproxy     
    ~# tail -f /var/log/haproxy.log
  
### Docker install
    
    apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

    vim /etc/docker/daemon.json
    {
        "exec-opts": ["native.cgroupdriver=systemd"]
    }

    sudo systemctl restart docker

## Kubernets configuration
## - Instalação - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

    1- sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    2-  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    3- sudo apt-get update
       sudo apt-get install -y kubelet=1.22.2-00 kubeadm=1.22.2-00 kubectl=1.22.2-00
       sudo apt-mark hold kubelet kubeadm kubectl
   
## ou

    #~ curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x ./kubectl

    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl - comand line to manager kubernets and clusters 

## Cluster configuration
    - Desabilitar swap: 
        swapoff -a 
    - Renomear vms:
        hostname vm-name
        echo "vm-name" > /etc/hostname
        bash

    - Executar no nó master: iniciar o cluster
        sudo kubeadm init --control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" --upload-certs
        "kubeadm init --control-plane-endpoint "k8s-haproxy:6443" --upload-certs"
    
    - CNI plugin configuration:

        kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

    - Test:
        kubectl get pod -n kube-system -w
## Get join Token
    kubeadm token list # if token not expired
    kubeadm token create # generate new token
    kubeadm token create --print-join-command # show comand to join node the cluster

## Comandos
    kubectl get nodes - ver clusters em execução
    kubectl get pods --watch - ver pods em execução iterativo

### Alias para kubectl
    alias k=kubectl

### yaml files kubernets
    https://kubeyaml.com/ - validar yaml 

### Recursos kubernets
    - PV -  Persistence volume - kubectl get pv
    
    - PVC - persistence volume claim - definir o tamanho do storage, tipo de leitura e escrita e fazer o bind com storageclass - kubectl get pvc
    
    - SC - Storage class - definir disco  e qual o tipo de arquivos.

    - Stateful Set - 

### Run cluster by yaml
    kubectl apply -f ./portal-noticias.yaml
    kubctl describe pods portal-noticias.yaml

### Listar servicos
    kubectl get svc

### Entrar em um pod
    kubectl exec -it pod-1 -- bash

### Ver ips de pods em execução
    kubectl get pods -o wide

### Ver ips de nos em execução
    kubectl get nodes -o wide

### Deletar pods e serviços
    kubectl delete pods --all
    kubectl delete svc --all

### Versionar deployments
    kubectl annotate deployment nome-deployment kubernetes.io/change-cause="versao xxx"

### Ver versões de deployments
    kubectl rollout history deployment nome-deployment

### Ver configuração horizontal pod auto scale
    kubectl get hpa

### Criar um namespace
    kubectl create ns namespace-name

### Executar yaml em um namespace
    kubectl apply -n namespace-name -f file-name.yaml


### Criar um novo contexto dentro de um namespace
    kubectl config set-context name-of-context --namespace=namespace-name \ --cluster=minikube --user=minikube \

### Trocar o contexto
    kubectl config use-context name-of-context
    
### Expor um serviço 
    kubectl port-forward -n spark service/jupyter 8888:8888

### Minikube - cluster virtual 

    curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.12.1/minikube-linux-amd64 \ && chmod +x minikube

    sudo install minikube /usr/local/bin/

    minikube start - iniciar o cluster


### Minikube - addons list - listar extensões disponiveis
    
    minikube addons list

### Minikube - habilitar extensão 
    
    minikube addons enable name-extension



