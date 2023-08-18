# Techzone Deployer for the Maximo Operator

This repository contains a Tekton pipelines to deploy the [Maximo Operator](https://github.com/cloud-native-toolkit/operator-masauto) that packages [mas-ansible](https://ibm-mas.github.io/ansible-devops/).

## Pre-requisites

### Deployer Cluster

An IBM Technology Zone `deployer` cluster is assumed to be configured with an appropriate Red Hat OpenShift version for the Maximo version you wish to deploy, with appropriate sizing. Refer to [Maximo Product Documentation](https://www.ibm.com/docs/en/mas-cd/continuous-delivery?topic=planning) for more information.

A `deployer` cluster is configured with the following items:

- ExternalSecrets operator deployed with a ClusterSecretStore configured. 
- Techzone Deployer Tekton tasks deployed ([deploy YAML](https://github.com/cloud-native-toolkit/deployer-tekton-tasks/blob/main/argocd.yaml)).
- OpenShift GitOps configured with [One Touch Provisioning ArgoCD instance](https://github.com/one-touch-provisioning/otp-gitops), and any relevant RBAC rules.
- OpenShift Pipelines operator deployed.
- deployer pipelines tasks and cluster tasks

### Entitlement key

If deploying on TechZone the entitlement key is provided from the TechZone Secrets Repo.  If deploying in a non-techzone cluster you will need to provide an entitlement key for the pipelinerun.

Documentation for obtaining an entitlement key here: https://www.ibm.com/docs/en/cloud-paks/1.0?topic=clusters-obtaining-your-entitlement-key


### Maximo License

To activate Maximo you will need a valid license key which is a text file that contains software authorizations and entitlements.  This pipeline in order to run automatically will need this file to be base64 encoded and saved in a kubernetes secret.

1. save the license file to a file locally such as license.dat.
2. Use a tool to base64 encode the file such as "

```
cat license.dat | base64 > license.dat.b64
```

3. copy the output into an OpenShift secret in the default namespace

```
oc create secret generic maximolicense --from-file=licensefile=license.dat.b64 -n default
```

remember the name of the secret for the pipeline run.  ( in the example above "maximolicense" is the name)


## Pipelines organisation

Maximo is deployed with a Tekton Pipeline that is defined in maximo-pipeline.yaml



## Usage

### If using your own cluster
Run Deployer prep on the cluster.
link: https://github.com/cloud-native-toolkit/deployer-cluster-prep/blob/main/prepare-cluster.sh


###
switch to version directory of choice and run these commands
```
oc apply -f pipeline.yaml
oc create -f pipeline-run.yaml
```
