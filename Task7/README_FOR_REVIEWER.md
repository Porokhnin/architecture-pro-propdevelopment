Создание namespace
```bash
kubectl apply -f 01-create-namespace.yaml
```

Валидация манифестов
```bash
bash verify/validate-security.sh
```



Установка Gatekeeper
```bash
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
```

Валидация OPA Gatekeeper
```bash
bash verify/verify-admission.sh
```