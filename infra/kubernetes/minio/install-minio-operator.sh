#!/bin/bash
apt install -y unzip

wget -qO- https://github.com/minio/operator/releases/latest/download/kubectl-minio_linux_amd64.zip | sudo bsdtar -xvf- -C /usr/local/bin
wget -qO- https://github.com/minio/operator/releases/download/v4.2.12/kubectl-minio_linux_amd64.zip | sudo bsdtar -xvf- -C /usr/local/bin
sudo unzip kubectl-minio_linux_amd64.zip  /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl-minio


wget -qO- https://github.com/minio/operator/releases/latest/download/kubectl-minio_linux_amd64.zip | sudo bsdtar -xvf- -C /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl-minio


minio console

minio/minio:RELEASE.2021-09-15T04-54-25Z
minio/minio:RELEASE.2021-11-09T03-21-45Z