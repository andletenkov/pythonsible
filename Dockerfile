FROM alpine:3.12

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache \
    bzip2 \
    file \
    gzip \
    libffi=3.2.1-r4 \
    libffi-dev=3.2.1-r4 \
    krb5 \
    krb5-dev \
    krb5-libs \
    musl-dev=1.1.19-r10 \
    openssh \
    openssl-dev \
    python2-dev=2.7.15-r1 \
    py-cffi=1.10.0-r0 \
    py-cryptography=2.1.4-r1 \
    py2-pip=10.0.1-r0 \
    py-setuptools=39.1.0-r0 \
    py2-yaml=3.12-r1 \
    sshpass \
    git \
    tar \
 && apk add --no-cache --virtual build-dependencies \
    gcc=6.4.0-r9 \
    make=4.2.1-r2 \
 && pip install --upgrade pip==18.0 \
 && pip install \
    ansible==2.7.6 \
    botocore==1.12.86 \
    boto==2.49.0 \
    boto3==1.9.86 \
    awscli==1.16.96 \
    pywinrm[kerberos]==0.3.0 \
    requests \
    google-auth \
&& 	apk del build-dependencies

RUN echo "**** install Python3 ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
