#!/bin/bash

echo  "constraint-templates"
echo  "privileged"
kubectl apply -f gatekeeper/constraint-templates/privileged.yaml
echo  "hostpath"
kubectl apply -f gatekeeper/constraint-templates/hostpath.yaml
echo  "runasnonroot"
kubectl apply -f gatekeeper/constraint-templates/runasnonroot.yaml


echo  "constraints"
echo  "privileged"
kubectl apply -f gatekeeper/constraints/privileged.yaml
echo  "hostpath"
kubectl apply -f gatekeeper/constraints/hostpath.yaml
echo  "runasnonroot"
kubectl apply -f gatekeeper/constraints/runasnonroot.yaml