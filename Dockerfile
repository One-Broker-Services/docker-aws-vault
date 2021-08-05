FROM ubuntu:latest


#install docker
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install apt-transport-https ca-certificates curl gnupg lsb-release unzip
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install docker-ce docker-ce-cli containerd.io
RUN systemctl enable docker.service
RUN systemctl enable containerd.service

#install aws-cli
RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
RUN unzip awscliv2.zip
RUN aws/install
#RUN rm -rf awscliv2.zip aws /usr/local/aws-cli/v2/*/dist/aws_completer /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index /usr/local/aws-cli/v2/*/dist/awscli/examples
RUN aws --version   # Just to make sure its installed alright

#install vault
RUN curl https://releases.hashicorp.com/vault/1.7.1/vault_1.7.1_linux_386.zip -o "vault.zip"
RUN unzip vault
RUN mv vault /usr/bin/
RUN vault -v

#install jq
RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux32 -o "jq"
RUN mv jq /usr/bin
RUN chmod +x /usr/bin/jq
RUN jq --version

#Clean cache
RUN rm -rf /var/cache/apk/*
