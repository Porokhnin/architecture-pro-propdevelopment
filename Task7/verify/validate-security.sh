#!/bin/bash

echo  "insecure-manifests"
echo  "privileged-pod"
kubectl apply -f insecure-manifests/01-privileged-pod.yaml
echo  "hostpath-pod"
kubectl apply -f insecure-manifests/02-hostpath-pod.yaml
echo  "root-user-pod"
kubectl apply -f insecure-manifests/03-root-user-pod.yaml


echo  "secure-manifests"
echo  "01-secure"
kubectl apply -f secure-manifests/01-secure.yaml
echo  "02-secure"
kubectl apply -f secure-manifests/02-secure.yaml
echo  "03-secure"
kubectl apply -f secure-manifests/03-secure.yaml