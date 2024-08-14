phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt update"
      - name: ${name}
      - onFailure: "Abort"
schemaVersion: 1.0