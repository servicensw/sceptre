FROM amazonlinux

LABEL maintainer "@egorpe"

ENV AWS_CLI_VERSION=2.0.53
ENV JP_VERSION=0.1.3

RUN yum -y update \
    && yum -y install \
        python3 \
        unzip \
        zip \
        tar \
        gzip \
        wget \
        git \
        make \
    && curl -o awscliv2.zip \
        -L https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && pip3 install --no-cache-dir --upgrade \
        sceptre \
        troposphere \
        flake8 \
        cfn-lint \
        yamllint \
    && curl -o /usr/local/bin/jp \
        -L https://github.com/jmespath/jp/releases/download/${JP_VERSION}/jp-linux-amd64 \
    && chmod +x /usr/local/bin/jp

VOLUME [ "/root/.aws" ]
VOLUME [ "/root/.ssh" ]
VOLUME [ "/opt/app" ]

WORKDIR /opt/app

CMD [ "sceptre", "--version" ]
