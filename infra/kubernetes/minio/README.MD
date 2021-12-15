# Install plugin minio operator

### add repository
```bash
helm repo add minio https://operator.min.io/
``` 

### Install e create namespace kubernetes

```bash
helm install --namespace minio-operator --create-namespace --generate-name minio/minio-operator
```

helm install minio --namespace minio --create-namespace \ 
--set accessKey.password=minio \
--set secretKey.password=minio123 \
minio/minio



### Get the JWT for logging in to the console:
```bash
    kubectl get secret $(kubectl get serviceaccount console-sa --namespace minio-operator -o jsonpath="{.secrets[0].name}") --namespace minio-operator -o jsonpath="{.data.token}" | base64 --decode 
```

### Get the Operator Console URL by running these commands:
```bash
    kubectl --namespace minio-operator port-forward svc/console 9090:9090
    echo "Visit the Operator Console at http://127.0.0.1:9090"

    or
    kubectl port-forward svc/minio-tenant-1-console 9443:9443 -n minio-tenant-1
```

### krew installation minio:
    kubectl krew update
    kubectl krew install minio

### Create tenant
    kubectl create ns minio-tenant
    kubectl minio tenant create minio \
      --servers 4                             \
      --volumes 4                            \
      --capacity 25Gi                         \
      --namespace minio-tenant              \
      --storage-class direct-csi-min-io

### Watch result
    kubectl get tenant -n minio-tenant-1  

### Mount storage

    lsblk -f
    mkfs -t ext4 /dev/sdb
    mkdir -p /mnt/sdb
    chmod 775 -R /mnt/sdb/
    mount -t auto /dev/sdb /mnt/sdb/
    blkid
    vim /etc/fstab
    /dev/disk/by-uuid/8cceded3-ebe5-4e95-a397-2fb51f308516 /mnt/sdb xfs defaults 0 0

    
    


