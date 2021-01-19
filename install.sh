# curl -s https://raw.githubusercontent.com/yanivpaz/aws-cloudshell/main/install.sh |bash
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

aws eks list-clusters --output text | awk '{print $2}'


