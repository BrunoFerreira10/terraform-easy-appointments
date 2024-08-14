phases:
  - name: build
    steps:
      - action: ExecuteBash
        inputs:
          commands:
            - "apt update"
        name: upper("${shortname}-apt-update")
        onFailure: "Abort"
schemaVersion: 1.0