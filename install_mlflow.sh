#!/bin/bash

NS=airflow

# colores
GREEN='\033[0;32m'
NC='\033[0m'

# если до этого запускался mlflow, нужно удалить 
# data-mlflow-postgresql-0 от старого чарта иначе будет ошибка
# failed: FATAL: password authentication failed for user "bn_mlflow"

if kubectl get ns "$NS"; then
  echo -e "${GREEN}namespace for project already exists${NC}"
else
  echo -e "${GREEN}creating namespace for project${NC}"
    kubectl create namespace "$NS"
    echo
fi

# создать pvc для монтирования к mlflow, если его еще нет
# echo -e "${GREEN}create pvc for mlflow data${NC}"
# kubectl apply -f temp_data_mlflow_pvc.yaml -n airflow

# создать секрет для postgresql, если его нет
# bash create_connect_postgesql_secret.sh 

echo -e "${GREEN} install mlflow by helm ${NC}"
helm upgrade --install mlflow oci://registry-1.docker.io/bitnamicharts/mlflow --values=upgrade_values.yaml -n "$NS"

