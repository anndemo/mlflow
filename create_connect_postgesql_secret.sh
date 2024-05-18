#!/bin/bash

NS=airflow

# colores
GREEN='\033[0;32m'
NC='\033[0m'

if kubectl get ns "$NS"; then
  echo -e "${GREEN}namespace for project already exists${NC}"
else
  echo -e "${GREEN}creating namespace for project${NC}"
    kubectl create namespace "$NS"
    echo
fi

echo -e "${GREEN}create secret connect-postgresql-secret ${NC}"

kubectl create secret generic connect-postgresql-secret	--from-literal=username=anndemo	--from-literal=password=psql_password --namespace "$NS"
