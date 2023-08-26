1. Kuberenetes is container orchaestraion system, 
2. It solves the problem when mulitple containers on many servers are required.
	1. It takes care of automatic deployement of containerized applications across servers.
	2. Distribution of the load across multiple servers
	3. Auto-Scaling of the deployed applications 
	4. Monitoring and health check of the containers 
	5. Replacements of the failed containers.
3. K8s supports the following container runtimes: 
	1. Docker
	2. CRI-O
	3. containerd
4. So the above the containers must be running on one of the servers inside kubernetes cluster.
5. **POD** is the smallest unit in K8s worlds
6. A POD can have multiple containers, they have shared volumes along with the shared IP address
7. Usually they still usually have single container per container.

### Kubernetes Cluster.
1. This is cluster of servers either a bare metal or in cloud.
2. Each server is called a Node.
3. Inside of the nodes there are PODs
4. There are master nodes and worker nodes.
5. Master nodes run only system pods.


## Kubernetes Notes:
1. The official Definiation: Open source container orchestration tool
2. Developed by Google.
3. Helps manage containereized applications.
4. Rose due to rise in monolith to microservice architecutre, that demand usage of many many containeres.
5. K8s gurantee the following:
	1. High Avvailability.
	2. Disaster recovery.
	3. Scalalibity.

## K8s Componenets:
1. **Node** and **Pod**, Node(server or whatever), Pod(Abstraction over the container, the container run-time is not important this way.)
2. One node can have multiple pods.
3. Each pod get's its own ip address.
4. Each pod will communicate using these IP addresses.
5. The pods are ephimiral, the pods can die, but everytime they come alive with a new IP address.
6. So avoid communication breakages the is  something called **Service**, that gives static ip addresses to pods, lifecycle of pod and service are not connected.
7. **External Service**, is the public ip address to access the application.
8. **Ingress** for using actual urls, that resolves to internal ip address of the K8s cluster.
9. **ConfigMap** is a component, extrenal config file for the application.
10. **Secret**  used to secret data (pwd, username) in as base64 encoded format.

## Volumes 
1. **Volumes** are the physical storage that are used by K8s for its' use, it can be both intenal or remtoe storage, it acts as simple storage, K8s does not give persistance to the data, that is for the user to take care of.
## What is node fails?
2. **Replicas**: 
	1. **Serivce** has two functionalities :
		1. Provide a static ip addr.
		2. Also acts as a load balancer between replicas of the nodes.
3. **Deployements**  are blueprints for 'app' pods.
	1. You create deployements not pods.
	2. abstraction of pods, makes it easier to work with them.
4. **How do you handle Database  pods?**
	1. If you have database pod, they have a state, which pod is writing or reading data from the database?
	2. Not orchestrating them properly can lead to data inconsistency.
5. **StatefulSet** for stateful apps, 
6. **Deployement for stateless apps**
7. **StatfulSet for stateFUL apps or databases.**
8. K8s will take care of scaling and consistency.
9. StatefulSet however are hard to deal with so many time stateful apps are extrenal to K8s cluster.


### K8s Architecture:
1. There are two nodes **Master** and **Worker**.
2. Three processes must be installed on every node(bold ones):
	1. **container runtime**(like docker)
	2. **kubelet**
	3. services for communication
	4. **Kube proxy**
3. How to interact with the cluster???
	1. Managing process are done by **master** node.

4. Container Runtime is obviously neccessary.
5. Kubelet interacts with both - the container and node.
6. Kubelet starts the pod with a container inside.
7. Kube proxy, managing the intelligent forwarding decisions.

8. How to:
	1. Scedule pod
	2. moitor?
	3. re-scedule/re-start pod

Managing processes are done by master nodes, they have four processes running on them:
1. Api server:
All of the requests and queries get forwarded to the api server, which then validates the request, calls other processes and launches or does whatever with the pod.
good for security(only one end point)
2. Sceduleer.
called by the api server, then sees where to put the pod, manage the resources find the worker node etc.
Scheduler just decides on which node new pod should be scheduled(done by kutbelet)
4. Contoller manager.
Takes care of dying pods, launches new pods etc.
5. etcd
cluster brain, it is log of all the changes that happen in the cluster, it's health, the resources etc.(a key value store.)


## Notes:
1. Run minikube inside a VM.
2. minikube requires kubectl as dependency.
3. kubectl CLI for configuring the MiniKube cluster.
4. Minikube CL for start up/deleting the cluster.

## Basic Kubectl commands:
```bash
kubectl get status
kubectl get pod
kubectl get services
kubectl create
kubectl get replicaset
kubectl logs 'Pod-name'
kubectl create deployement 'name and arugmetns'
kubectl delete 'deployement-name'
kuebctl describe 'deployement-name' #explains what the deployement is doing.
kubectl create namespace 'nsaspace name'
```

1. Pod is the smallest unit, but we work with deployments.
2. Eg.
```
most basic configuration for deployment require only the name and image to use
kubectl create deployment nginx-depl --image=nginx
```

3. The number of replicas in configured in the deployement.

### Layers of Abstraction:


Everything below should be managed by K8s automatically.

In practice we use kubectl config file

```bash
kubectl apply -f config-file.yaml
```

In the config file we have three components, **metadata**, **specifications** and **status**.
The information about the status comes from '**etcd**'.

In config file we can define the config for the pods under the namespace template, the tempalte will be used for all the pods that are defined by the deployement.



## K8s Namespaces:
1. Resources can be orgainsed in virutal groups.
2. There are a few out of the box namespaces.
	1. kube-system : System processes, master, node etc.
	2. kube-public : cluster info that is public.
	3. kube-node-lease: Hearbeats of nodes, nodes availailbilty info.
	4. default : resource that we create if we don't create a new namespace.
3. Easy to seperate concerns of apps.
4. Group resources into namespaces.
5. Using config files for namespaces is a good idea.
6. Can also manage resources and access.
7. 



