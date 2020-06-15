#!/usr/bin/env bash

SERVICE_NAME=${SERVICE_NAME:-hello-world}

function print_usage() {
    echo "1"
}

for i in "$@"; do
  case $i in
  --cluster=*)
    CLUSTER="${i#*=}"
    ;;
   --service_name=*)
    SERVICE_NAME="${i#*=}"
    ;;
  -h | --help)
    print_usage
    exit 0
    ;;
  *)
    print_usage
    exit 1
    ;;
  esac
done

[[ -z "$CLUSTER" ]] && echo "env var: CLUSTER is required!" && print_usage && exit 1

nsePod=$(kubectl --context "$CLUSTER" get pods -l "networkservicemesh.io/app=${SERVICE_NAME}" -o=name)

kubectl --context "$CLUSTER" exec -it "$nsePod" -- ipsec up kiknos