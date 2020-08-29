# https://github.com/weaveworks/footloose/blob/master/images/debian10/Dockerfile
FROM quay.io/footloose/debian10:latest

ADD ./install-k3s.sh /root/install-k3s.sh

ADD ./hello-kubernetes.yaml /root/hello-kubernetes.yaml

RUN cd root \
    && chmod +x ./install-k3s.sh \
    && export INSTALL_K3S_SKIP_START=true \
    && export INSTALL_K3S_SKIP_ENABLE=true \
    && ./install-k3s.sh