
#docker installation

sudo apt-get update -y

sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository -y\
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

#uploading jenkins

sudo docker build -t jenkins_im .

sudo docker run --name jenkins -p 8080:8080 /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home jenkins_im