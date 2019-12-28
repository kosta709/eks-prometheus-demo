#!/usr/bin/env bash
#
# usage: ./run-helm.sh [helm parameters] 


approveContext() {
	echo "Your kubectl is configured with the following context: "
	kubectl config current-context
	read -r -p "Are you sure you want to continue? [y/N] " response

	if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
	then
			echo "Continuing ..."
	else
			echo "Exiting..."
			exit 0
	fi
}


DIR=$(dirname $0)
#

RELEASE=monitoring
CHART=stable/prometheus-operator 
NAMESPACE=monitoring

VALUES_FILE_1=${DIR}/prometheusoperator-values.yaml
VALUES_FILE_1_PARAM="-f ${VALUES_FILE_1}"


COMMAND="helm upgrade --install --namespace $NAMESPACE  $RELEASE $CHART $VALUES_FILE_1_PARAM  $@"
echo "Running: $COMMAND "

approveContext

if ! kubectl get namespace monitoring >/dev/null 2>&1; then
  kubectl create namespace monitoring
fi

eval $COMMAND