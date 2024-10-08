name: build-image
description: Workflow to build an AMI
schemaVersion: 1.0

steps:
  - name: LaunchBuildInstance
    action: LaunchInstance
    timeoutSeconds: 600
    onFailure: Abort
    inputs:
      waitFor: "ssmAgent"

  - name: ApplyBuildComponents
    action: ExecuteComponents
    timeoutSeconds: 1200
    onFailure: Abort
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

  - name: InventoryCollection
    action: CollectImageMetadata
    onFailure: Abort
    if:
      and:
        - stringEquals: "AMI"
          value: "$.imagebuilder.imageType"
        - booleanEquals: true
          value: "$.imagebuilder.collectImageMetadata"
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

  - name: RunSanitizeScript
    action: SanitizeInstance
    onFailure: Abort
    if:
      and:
        - stringEquals: "AMI"
          value: "$.imagebuilder.imageType"
        - stringEquals: "Linux"
          value: "$.imagebuilder.platform"
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

  - name: RunSysPrepScript
    action: RunSysPrep
    onFailure: Abort
    if:
      and:
        - stringEquals: "AMI"
          value: "$.imagebuilder.imageType"
        - stringEquals: "Windows"
          value: "$.imagebuilder.platform"
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

  - name: CreateOutputAMI
    action: CreateImage
    onFailure: Abort
    if:
      stringEquals: "AMI"
      value: "$.imagebuilder.imageType"
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

  - name: TerminateBuildInstance
    action: TerminateInstance
    onFailure: Continue
    inputs:
      instanceId.$: "$.stepOutputs.LaunchBuildInstance.instanceId"

outputs:
  - name: "ImageId"
    value: "$.stepOutputs.CreateOutputAMI.imageId"
