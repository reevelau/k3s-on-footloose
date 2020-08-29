# k3s on footloose 

[Kubernetes](https://kubernetes.io/) seems a very large and cloud only stuff in the old days. But by the effort of [K3S](https://github.com/rancher/k3s), [footloose](https://github.com/weaveworks/footloose) and [docker](https://docs.docker.com/get-docker/). We are now able to setup a Kubernetes clusters every easily on our local machine.

Spinning up a 3 node k3s (Kubernetes) cluster in localhose. This repo aims to ease your journey onboarding to kubernetes.

# Dependencies

## MacOS or Linux
1. [docker](https://docs.docker.com/get-docker/)
2. [footloose](https://github.com/weaveworks/footloose)
3. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Windows
If you don't have a mac, you may consider to use vagrant to run this example

1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](https://www.vagrantup.com/docs/installation)

```
vagrant up && vagrant ssh
```

# How to use

Run the bootstrap command
```
./bootstrap.sh
```

Run kubectl to ensure all pods are running
```
export KUBECONFIG=$PWD/k3s.yaml
kubectl get pods --all-namespaces
```

Then you can issue a http request to the hello-kubernetes service
```
curl -s http://localhost:8080 | grep hello-kubernetes
```

You should see something like the following
```
~/k3s-on-footloose master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-bsvp5</td>
~/k3s-on-footloose master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-khcb4</td>
~/k3s-on-footloose master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-xhlfv</td>
~/k3s-on-footloose master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-bsvp5</td>
```

Your http request will route through Traefik load balance to one of the hello-kubernetes nodes.
