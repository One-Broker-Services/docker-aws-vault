FROM docker:latest

#install curl if missing
RUN apk add --no-cache curl

#install prerequisites for awscli see https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
RUN apk add --no-cache glibc groff less 

#install aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

RUN aws --version

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
