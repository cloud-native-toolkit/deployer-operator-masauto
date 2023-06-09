# Techzone Deployer for the Maximo Operator

This repository contains a Tekton pipelines to deploy the [Maximo Operator](https://github.com/cloud-native-toolkit/operator-masauto) that packages [mas-ansible](https://ibm-mas.github.io/ansible-devops/).

## Pre-requisites

An IBM Technology Zone `deployer` cluster is assumed to be configured with an appropriate Red Hat OpenShift version for the Maximo version you wish to deploy, with appropriate sizing. Refer to [Maximo Product Documentation](https://www.ibm.com/docs/en/mas-cd/continuous-delivery?topic=planning) for more information.

A `deployer` cluster is configured with the following items:

- ExternalSecrets operator deployed with a ClusterSecretStore configured. The remote ExternalSecrets secret store must include an IBM Entitlement Key.
- Techzone Deployer Tekton tasks deployed ([deploy YAML](https://github.com/cloud-native-toolkit/deployer-tekton-tasks/blob/main/argocd.yaml)).
- OpenShift GitOps configured with [One Touch Provisioning ArgoCD instance](https://github.com/one-touch-provisioning/otp-gitops), and any relevant RBAC rules.
- OpenShift Pipelines operator deployed.
- deployer pipelines tasks and cluster tasks


## Pipelines organisation

Maximo is deployed with a Tekton Pipeline that is defined in maximo-pipeline.yaml


## Tasks

Currently uses oc client, git clone, and helm-update-from-source from tekton hub

## Usage

###
```
oc apply -f maximo-pipeline.yaml

tkn pipeline start mas-core-deploy --pod-template pod-template.yaml -w name=shared-workspace,volumeClaimTemplateFile=workspace-template.yaml
```

```
yaml 
apiVersion: tekton.dev/v1 
kind: Task 
metadata: 
  name: mytask 
spec: 
  steps: 
    - name: writesomething 
	  image: ubuntu 
	  command: ["bash", "-c"] 
	  args: ["echo 'foo' > /my-cache/bar"] volumeMounts: 
	    - name: my-cache 
		  mountPath: /my-cache 
--- 
apiVersion: tekton.dev/v1 
kind: Pipeline 
metadata: 
  name: mypipeline 
spec: 
  tasks: 
    - name: task1 
	  taskRef: 
	    name: mytask 
--- 
apiVersion: tekton.dev/v1 
kind: PipelineRun 
metadata: 
  name: mypipelinerun 
spec: 
  pipelineRef: 
    name: mypipeline 
	taskRunTemplate: 
	  podTemplate: 
	    securityContext: 
		  runAsNonRoot: true 
		  runAsUser: 1001 
		  volumes: 
		    - name: my-cache    	  persistentVolumeClaim: claimName: my-volume-claim 
``` 
