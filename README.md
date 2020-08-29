# footloose k3s

Spinning up a 3 node k3s (Kubernetes) cluster in localhose. This aims to ease your journey onbarding to kubernetes.

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
~/footloose-k3s master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-bsvp5</td>
~/footloose-k3s master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-khcb4</td>
~/footloose-k3s master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-xhlfv</td>
~/footloose-k3s master ?1 ❯ curl -s http://localhost:8080 | grep hello-kubernetes
      <td>hello-kubernetes-594f6f475f-bsvp5</td>
```

Your http request will route through Traefik load balance to one of the hello-kubernetes nodes.
