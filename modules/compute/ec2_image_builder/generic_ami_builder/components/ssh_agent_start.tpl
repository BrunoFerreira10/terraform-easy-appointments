phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "eval $(ssh-agent -s)"
        name: "${name}"
        onFailure: "Abort"
schemaVersion: 1.0
