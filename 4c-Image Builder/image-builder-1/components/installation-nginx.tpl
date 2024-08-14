phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt-get install -y nginx"
        name: upper("${shortname}-install-nginx")
        onFailure: "Abort"
schemaVersion: 1.0