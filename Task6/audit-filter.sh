jq 'select(.objectRef.resource=="secrets" and .verb=="get")' ./audit.log > audit-extract.json

jq 'select(.verb=="create" and .objectRef.subresource=="exec")' ./audit.log >> audit-extract.json

jq 'select(.objectRef.resource=="pods" and .requestObject.spec.containers[].securityContext.privileged==true)' ./audit.log >> audit-extract.json

grep -i 'audit-policy' audit.log ./audit.log >> audit-extract.json