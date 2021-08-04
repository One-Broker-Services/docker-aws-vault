FROM docker:latest

#install aws-cli trough python https://stackoverflow.com/questions/61918972/how-to-install-aws-cli-on-alpine
RUN apk --no-cache add binutils curl
RUN export GLIBC_VER=$(curl -s https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest | grep tag_name | cut -d : -f 2,3 | tr -d \",' ')
RUN echo $GLIBC_VER
RUN curl -sL https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub
RUN curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VER/glibc-$GLIBC_VER.apk
RUN curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VER/glibc-bin-$GLIBC_VER.apk
RUN ls
RUN apk add --no-cache glibc-$GLIBC_VER.apk glibc-bin-$GLIBC_VER.apk
RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
RUN unzip awscliv2.zip
RUN aws/install
RUN rm -rf awscliv2.zip aws /usr/local/aws-cli/v2/*/dist/aws_completer /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index /usr/local/aws-cli/v2/*/dist/awscli/examples
RUN apk --no-cache del binutils
RUN rm glibc-$GLIBC_VER.apk
RUN rm glibc-bin-$GLIBC_VER.apk
RUN rm -rf /var/cache/apk/*
RUN ln -s $(which awscliv2) /usr/bin/aws
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
