phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "systemctl restart nginx"
        name: ${name}
        onFailure: "Abort"
schemaVersion: 1.0