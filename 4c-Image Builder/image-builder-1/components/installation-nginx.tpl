phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt-get install -y nginx"
        name: upper("${shortname}-nginx-installation")
        onFailure: "Abort"
schemaVersion: 1.0