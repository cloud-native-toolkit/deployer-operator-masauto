# deployer-operator-masauto
Tektoncd pipeline to deploy the Maximo Operator for IBM TechZone Deployer (experimental)

## Prerequisites

* Openshift Cluster with OpenShift Pipelines 1.8 installed
* oc task installed from tekton hub
* helm task installed from tekton hub

./prereqs.sh

## Tasks

Currently uses oc client, git clone, and helm-update-from-source from tekton hub

## Usage

###
oc apply -f maximo-pipeline.yaml to install mas-core-deploy
tkn pipeline start mas-core-deploy -s openshift-client-sa --pod-template pod-template.yaml -w name=shared-workspace,volumeClaimTemplateFile=workspace-template.yaml -p ibm-entitlement-key=your-entitlement-key
