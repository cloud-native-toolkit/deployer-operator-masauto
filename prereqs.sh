

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

# git clone task
oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml
# openshift-client 0.1 task
oc apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/openshift-client/0.1/raw
# helm from source task
oc apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/helm-upgrade-from-source/0.3/raw
