docker network create k3s-cluster

# make sure we have an up-to-date image for the footloose nodes
docker build -t footloose-k3s/debian10 ./debian10

footloose create

# set up k3s on node0 as the master
footloose ssh root@node0 -- "env INSTALL_K3S_SKIP_DOWNLOAD=true /root/install-k3s.sh"

# get the token from node0
export k3stoken=$(footloose ssh root@node0 -- cat /var/lib/rancher/k3s/server/node-token)

# set up k3s on node1 and node2 with the token from node0
footloose ssh root@node1 -- "env INSTALL_K3S_SKIP_DOWNLOAD=true env K3S_URL=https://node0:6443 env K3S_TOKEN=$k3stoken /root/install-k3s.sh"
footloose ssh root@node2 -- "env INSTALL_K3S_SKIP_DOWNLOAD=true env K3S_URL=https://node0:6443 env K3S_TOKEN=$k3stoken /root/install-k3s.sh"

# install the hello-kubenetes
footloose ssh root@node0 -- "kubectl apply -f hello-kubernetes.yaml"

# copy the k3s kubeconfig from the node
docker cp k3s-node0:/etc/rancher/k3s/k3s.yaml .