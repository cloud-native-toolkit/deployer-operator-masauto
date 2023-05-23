
# pipelines is installed
oc apply -f - <<EOF
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: openshift-pipelines-operator
  namespace: openshift-operators
spec:
  channel:  pipelines-1.8
  name: openshift-pipelines-operator-rh
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF


# external secrets operator installed
oc apply -f - <<EOF
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: external-secrets-operator-catalog
  namespace: openshift-operators
spec:
  sourceType: grpc
  image: ghcr.io/external-secrets/external-secrets-helm-operator-catalog:latest
  displayName: External Secrets Operator
  updateStrategy:
    registryPoll:
      interval: 30m
EOF

oc apply -f - <<EOF
apiVersion: operators.coreos.com/v1alpha1 
kind: Subscription 
metadata: 
  name: external-secrets-operator 
  namespace: openshift-operators 
spec: 
  channel: alpha 
  name: external-secrets-operator 
  source: external-secrets-operator-catalog
  sourceNamespace: openshift-operators
EOF

# create IBM Secrets manager

oc apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: ibm-store
spec:
  provider:
    ibm:
      serviceUrl: "https://3f5f4d5b-6179-4d7c-a7a2-72dc28eb4a81.au-syd.secrets-manager.appdomain.cloud"
      auth:
        containerAuth:
          profile: "test container auth profile"
          tokenLocation: "/var/run/secrets/tokens/sa-token"
          iamEndpoint: "https://iam.cloud.ibm.com"
        secretRef:
          secretApiKeySecretRef:
            name: ibm-secret
            key: apiKey
EOF


# git clone task
oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml
# openshift-client 0.1 task
oc apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/openshift-client/0.1/raw
# helm from source task
oc apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/helm-upgrade-from-source/0.3/raw
