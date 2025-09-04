kubectl create namespace clever-home

kubectl create serviceaccount clever-home-developer -n clever-home
kubectl create serviceaccount clever-home-teamlead -n clever-home

kubectl create serviceaccount support-l2
kubectl create serviceaccount devops