phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt-get install -y nginx"
      - name: ${name}
      - onFailure: "Abort"
schemaVersion: 1.0