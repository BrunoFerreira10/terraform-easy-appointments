phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "systemctl daemon-reload"
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0