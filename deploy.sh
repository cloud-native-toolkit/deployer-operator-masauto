#!/bin/bash

#prerequisites
# openshift pipelines installed
# deployer cluster tasks
# OpenShift client - oc
# tekton client - tkn
oc apply -f https://raw.githubusercontent.com/cloud-native-toolkit/deployer-operator-masauto/main/maximo-pipeline.yaml
sleep 20
oc apply -f https://raw.githubusercontent.com/cloud-native-toolkit/deployer-operator-masauto/main/maximo-pipeline-run.yaml
#tkn pipeline start mas-core-deploy \
#    $PARAM_STRING \
#    --pod-template https://raw.githubusercontent.com/cloud-native-toolkit/deployer-operator-masauto/main/pod-template.yaml \
#    -w name=shared-workspace,volumeClaimTemplateFile=https://raw.githubusercontent.com/cloud-native-toolkit/deployer-operator-masauto/main/workspace-template.yaml
