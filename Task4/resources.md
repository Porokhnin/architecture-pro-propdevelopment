Role (роль) — набор разрешений, который определяет, какие действия можно выполнять над ресурсами в определённом неймспейсе.
ClusterRole аналогичен Role, но применяется ко всему кластеру. Используется для управления ресурсами, которые не привязаны к определённому неймспейсу, например nodes или persistentvolumes.
RoleBinding связывает пользователя, группу или сервисный аккаунт с ролью (Role) в конкретном неймспейсе и предоставляет разрешения, которые определены в роли.
ClusterRoleBinding аналогичен RoleBinding, но применяется ко всему кластеру. Связывает пользователя, группу или сервисный аккаунт с кластерной ролью (ClusterRole).

Для права на запись (write) — create, update, patch, delete
Для права на чтение (read) — get, list, watch

#https://kubernetes.io/docs/reference/access-authn-authz/rbac/
#https://faun.pub/give-users-and-groups-access-to-kubernetes-cluster-using-rbac-b614b6c0b383


# role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"] 
  

# rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: development
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io 



# clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"] 
  


# clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-read-pods
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-pod-reader
  apiGroup: rbac.authorization.k8s.io 
  



# Создание пользователя
kubectl config set-credentials $USER --username=$USERNAME --password=$PASSWORD
kubectl create serviceaccount $username -n $NAMESPACE

# Создание namespace
kubectl create namespace production

#Применить yaml-файл
kubectl apply -f role.yaml 
kubectl apply -f rolebinding.yaml
kubectl apply -f clusterrole.yaml 
kubectl apply -f clusterrolebinding.yaml 

#Просмотр
kubectl get roles, rolebindings --all-namespaces
kubectl get nodes 
kubectl config get-users
kubectl api-resources --sort-by name -o wide

#Ресурсы
resources:
  - pods
  - services
  - configmaps
  - namespaces
  - deployments
  - daemonsets
  - statefulsets
  - jobs
  - cronjobs
  - ingresses
  - resourcequotas

#Действия
verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]



#ДЗ
kubectl create namespace clever-home

kubectl create serviceaccount clever-home-developer -n clever-home
kubectl create serviceaccount clever-home-teamlead -n clever-home

kubectl create serviceaccount support-l2
kubectl create serviceaccount devops



apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: clever-home
  name: clever-home-viewer
rules:
- apiGroups: [""]
  resources: [""]
  verbs: ["get", "list", "watch"] 
---  
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: clever-home
  name: clever-home-admin
rules:
- apiGroups: [""]
  resources: [""]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"] 
---  
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-pods-viewer
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
--- 
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-devops-admin
rules:
- apiGroups: [""]
  resources: [""]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]


 
  
  
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: clever-home-viewer-binding
  namespace: clever-home
subjects:
- kind: ServiceAccount
  name: clever-home-developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: clever-home-viewer
  apiGroup: rbac.authorization.k8s.io 
---  
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: clever-home-admin-binding
  namespace: clever-home
subjects:
- kind: ServiceAccount
  name: clever-home-teamlead
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: clever-home-admin
  apiGroup: rbac.authorization.k8s.io 
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-pods-viewer-binding
subjects:
- kind: ServiceAccount
  name: support-l2
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-pods-viewer
  apiGroup: rbac.authorization.k8s.io 
--- 
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-devops-admin-binding
subjects:
- kind: ServiceAccount
  name: devops
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-devops-admin
  apiGroup: rbac.authorization.k8s.io 