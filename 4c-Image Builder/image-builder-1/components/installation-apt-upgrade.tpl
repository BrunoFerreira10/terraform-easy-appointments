phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt upgrade -y"
      - name: '${name}'
      - onFailure: "Abort"
schemaVersion: 1.0