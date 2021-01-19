# curl -s https://raw.githubusercontent.com/yanivpaz/aws-cloudshell/main/install.sh |bash

if [ ! -f /usr/local/bin/kubectl ]
then
 echo "Installing kubectl"
 curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
 chmod +x ./kubectl
 sudo mv ./kubectl /usr/local/bin/kubectl
fi

if [ ! -f /usr/local/bin/helm ]
then
 echo "Installing helm"
 sudo yum install openssl -y
 curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
 chmod 700 get_helm.sh
 ./get_helm.sh
fi


if [ ! -f /usr/local/bin/eksctl ]
then
 echo "Installing eksctl"
 curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
 sudo mv /tmp/eksctl /usr/local/bin
fi 


if [ ! -f /usr/local/bin/scheduler-cli ]
then
 curl -LO https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/scheduler-cli.zip
 sudo apt install unzip
 unzip scheduler-cli.zip
 sudo -E python3 setup.py install
 rm -f scheduler-cli.zip
fi 

if [ ! -f /usr/local/bin/awslogs ]
then
 echo "Installing awslogs"
 sudo pip3 install awslogs
fi

if [ ! -d ~/.oh-my-zsh ]
then 
 sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi 

EKS_CLUSTER=`aws eks list-clusters --output text |tail -1 | awk '{print $2}'|tail -1`
KUBECONFIG="aws eks update-kubeconfig --name $EKS_CLUSTER"
eval echo $KUBECONFIG

# example
# awslogs get scheduler-instance-logs -S  -G --timestamp -w

