FROM docker:latest

#install curl if missing
RUN apk add --no-cache curl

#install awscli
RUN RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli
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
