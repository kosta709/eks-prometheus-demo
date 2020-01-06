# Install monitoring stack

we use prometheus operator helm chart from https://github.com/helm/charts/tree/master/stable/prometheus-operator

### Prerequisite
* helm - https://helm.sh/docs/intro/install/
```bash
## for helm 3
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
```
* kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl/

### Install / Upgrade
./run-helm.sh

### Connect to services:
##### prometheus:  
```
kubectl -nmonitoring port-forward svc/prometheus-operated 9090 
```
http://localhost:9090


##### grafana:
```
kubectl -nmonitoring port-forward svc/monitoring-grafana 3000:80
```
http://localhost:3000

##### Load Balancers for services
add/uncomment the values below to prometheus/grafana/alertmanager sections of [prometheusoperator-values.yaml](./prometheusoperator-values.yaml) 



```yaml
prometheus:
  ....

  service:
    type: LoadBalancer
    ## For AWS Interal Load Balancing
    annotations: 
      service.beta.kubernetes.io/aws-load-balancer-internal: 0.0.0.0/0
```

