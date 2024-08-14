phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "systemctl daemon-reload"
            - "systemctl restart nginx"
        name: upper("${shortname}-nginx-reload")
        onFailure: "Abort"
schemaVersion: 1.0