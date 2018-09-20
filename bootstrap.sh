#!/bin/bash -ex
DOCKER_VERSION=${1:-"17.12.1~ce-0~ubuntu"}
KOPS_VERSION="1.10.0"
JX_VERSION="1.3.290"
HELM_VERSION="2.11.0-rc.4"

sudo apt-get update && sudo apt-get install -y \
    python-pip \
    jq

# Install kops
sudo pip install --upgrade awscli boto boto3
cd /tmp && wget -O kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64
sudo chmod +x /tmp/kops
if [ -f "/usr/local/bin/kops" ]; then
    sudo rm /usr/local/bin/kops
fi
sudo mv /tmp/kops /usr/local/bin/

# Install kubectl
cd /tmp && wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x /tmp/kubectl
if [ -f "/usr/local/bin/kubectl" ]; then
    sudo rm /usr/local/bin/kubectl
fi
sudo mv /tmp/kubectl /usr/local/bin/kubectl

# Install Docker CE
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update && \
    sudo apt-get install -y \
    docker-ce=${DOCKER_VERSION}

# Install Jx
cd /tmp && wget -O jx https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
sudo chmod +x /tmp/jx
if [ -f "/usr/local/bin/jx" ]; then
    sudo rm /usr/local/bin/jx
fi
sudo mv /tmp/jx /usr/local/bin

# Install helm
cd /tmp && curl -L https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar -zxfv
sudo chmod +x /tmp/linux-amd64/helm
if [ -f "/usr/local/bin/helm" ]; then
    sudo rm /usr/local/bin/helm
fi
sudo mv /tmp/linux-amd64/helm /usr/local/bin

# Install kubectx, kubens
curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx > /tmp/kubectx
sudo chmod +x /tmp/kubectx
if [ -f "/usr/local/bin/kubectx" ]; then
    sudo rm /usr/local/bin/kubectx
fi
sudo mv /tmp/kubectx /usr/local/bin/

curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens > /tmp/kubens
sudo chmod +x /tmp/kubens
if [ -f "/usr/local/bin/kubens" ]; then
    sudo rm /usr/local/bin/kubens
fi
sudo mv /tmp/kubens /usr/local/bin/